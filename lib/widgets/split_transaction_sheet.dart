// lib/widgets/split_transaction_sheet.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../screens/add_transaction_screen.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';
import 'shared_widgets.dart';

class SplitTransactionSheet extends StatelessWidget {
  final AppTransaction transaction;
  final List<TransactionSplit> splits;
  final AppProvider app;

  const SplitTransactionSheet({
    super.key,
    required this.transaction,
    required this.splits,
    required this.app,
  });

  static Future<void> show(
    BuildContext context, {
    required AppTransaction transaction,
    required List<TransactionSplit> splits,
    required AppProvider app,
  }) {
    AppHaptics.tap(context, HapticStrength.light);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SplitTransactionSheet(
        transaction: transaction,
        splits: splits,
        app: app,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final acc = app.accountById(transaction.accountId);
    final accCurrency = acc?.currency ?? app.settings.currency;
    final displayCurrency =
        transaction.currency.isNotEmpty ? transaction.currency : accCurrency;

    final totalAmount = transaction.amount > 0 ? transaction.amount : 1.0;

    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: cs.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title & Badge
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.split_transactions_breakdown,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.call_split_rounded,
                        size: 14, color: cs.onPrimaryContainer),
                    const SizedBox(width: 4),
                    Text(
                      '${splits.length} ${l10n.split_transactions_title}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Summary Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.description.isNotEmpty
                            ? transaction.description
                            : l10n.add_transaction_expense,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${acc?.name ?? ''}  ·  ${DateFormat('EEEE, d MMM yyyy').format(transaction.date)}',
                        style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurface.withValues(alpha: 0.6)),
                      ),
                    ],
                  ),
                ),
                Text(
                  '-${formatAmount(transaction.amount, displayCurrency)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFC62828),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Split items list
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: splits.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final split = splits[i];
                final cat = app.categoryById(split.categoryId);
                final pct = ((split.amount / totalAmount) * 100).clamp(0, 100);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CategoryDot(category: cat, size: 36),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cat?.name ?? 'Category',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            if (split.note.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                split.note,
                                style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        cs.onSurface.withValues(alpha: 0.6)),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatAmount(split.amount, displayCurrency),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: cs.secondaryContainer.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${pct.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: cs.onSecondaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Edit Transaction Button
          FilledButton.tonalIcon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                ExpensySlideUpRoute(
                  builder: (_) => AddTransactionScreen(existing: transaction),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: Text(l10n.add_transaction_editTransaction),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }
}
