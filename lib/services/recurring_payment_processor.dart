// lib/services/recurring_payment_processor.dart
// note: Shared recurring payment processor for both foreground AppProvider and background Workmanager worker.

import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import '../models/models.dart';

class RecurringPaymentProcessor {
  final AppDatabase db;
  static const _uuid = Uuid();

  RecurringPaymentProcessor(this.db);

  /// Checks if a payment is due based on nextDate, endDate, and autoPayTime.
  static bool isPaymentDue(RecurringPayment r, DateTime now) {
    if (!r.autoPayEnabled) return false;
    if (r.endDate != null && r.nextDate.isAfter(r.endDate!)) return false;

    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(r.nextDate.year, r.nextDate.month, r.nextDate.day);

    if (dueDate.isBefore(today)) return true;
    if (dueDate.isAtSameMomentAs(today)) {
      final parts = r.autoPayTime.split(':');
      final targetHour = int.tryParse(parts[0]) ?? 9;
      final targetMinute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
      final currentMinutes = now.hour * 60 + now.minute;
      final targetMinutes = targetHour * 60 + targetMinute;
      return currentMinutes >= targetMinutes;
    }
    return false;
  }

  /// Calculates the exact DateTime occurrence for a given nextDate and autoPayTime.
  static DateTime occurrenceDateFor(RecurringPayment r) {
    final parts = r.autoPayTime.split(':');
    final hour = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
    return DateTime(
      r.nextDate.year,
      r.nextDate.month,
      r.nextDate.day,
      hour,
      minute,
    );
  }

  /// Processes all due recurring payments with auto-pay enabled.
  /// Runs inside a database transaction per payment for idempotency and atomicity.
  /// Handles debit-card balance redirection to parent bank account.
  Future<List<String>> processDuePayments({DateTime? nowOverride}) async {
    final now = nowOverride ?? DateTime.now();
    final recurringList = await db.getRecurring();
    final accountsList = await db.getAccounts();
    final processedIds = <String>[];

    // Build account lookup
    final accountMap = {for (final a in accountsList) a.id: a};

    for (var r in recurringList) {
      if (!r.autoPayEnabled) continue;

      int catchUpCycles = 0;
      const maxCycles = 24;

      while (catchUpCycles < maxCycles) {
        if (!isPaymentDue(r, now)) break;

        final occurrence = occurrenceDateFor(r);

        // Determine balance-holding account (Debit Card redirect)
        final acc = accountMap[r.accountId];
        final balanceAccountId = (acc != null && acc.isDebit && acc.linkedAccountId != null && acc.linkedAccountId!.isNotEmpty)
            ? acc.linkedAccountId!
            : r.accountId;
        final paidViaAccountId = (acc != null && acc.isDebit) ? r.accountId : null;

        final txId = _uuid.v4();
        final tx = AppTransaction(
          id: txId,
          type: r.paymentType,
          amount: r.amount,
          description: '${r.name} (recurring)',
          accountId: balanceAccountId,
          paidViaAccountId: paidViaAccountId,
          categoryId: r.categoryId,
          date: occurrence,
          currency: acc?.currency ?? 'EGP',
        );

        final balanceDelta = r.paymentType == 'income' ? r.amount : -r.amount;

        final updatedR = r.copyWith(
          nextDate: r.calcNextDate(),
          paidPayments: r.paidPayments + 1,
        );

        final historyEntry = RecurringHistoryEntry(
          id: _uuid.v4(),
          recurringId: r.id,
          action: 'paid',
          date: occurrence,
          amount: r.amount,
          currency: acc?.currency ?? 'EGP',
        );

        // Execute idempotency check and payment atomically inside a DB transaction
        final didPay = await db.transaction(() async {
          final alreadyPaid = await _isAlreadyPaid(r.id, occurrence);
          if (alreadyPaid) {
            return false;
          }
          await db.applyTransactionWithBalance(tx, balanceDelta);
          await db.insertRecurringHistory(historyEntry);
          await db.updateRecurring(updatedR);
          return true;
        });

        if (!didPay) {
          // If already paid by another runner, step cursor and break/continue
          r = r.copyWith(nextDate: r.calcNextDate());
          break;
        }

        processedIds.add(r.id);
        r = updatedR;
        catchUpCycles++;

        if (r.endDate != null && r.nextDate.isAfter(r.endDate!)) break;
      }
    }

    return processedIds;
  }

  Future<bool> _isAlreadyPaid(String recurringId, DateTime occurrence) async {
    final startOfDay = DateTime(occurrence.year, occurrence.month, occurrence.day);
    final endOfDay = DateTime(occurrence.year, occurrence.month, occurrence.day, 23, 59, 59);

    final history = await db.getRecurringHistory(recurringId);
    return history.any((h) =>
        h.action == 'paid' &&
        !h.date.isBefore(startOfDay) &&
        !h.date.isAfter(endOfDay));
  }
}
