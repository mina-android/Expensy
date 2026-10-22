import 'package:flutter_test/flutter_test.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';

void main() {
  group('Certificate Yield and Due Date Calculations', () {
    test('Calculates periodic payout and total expected return correctly', () {
      final certMonthly = Certificate(
        id: 'cert-1',
        name: 'High Yield Certificate',
        amount: 100000,
        currency: 'EGP',
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2026, 1, 1),
        interestRate: 24.0, // 24% annual
        collectionType: 'monthly',
        collectionDay: 1,
        accountId: 'acc-1',
      );

      // Monthly: (100,000 * 0.24) / 12 = 2,000
      expect(certMonthly.periodicPayout, closeTo(2000.0, 0.01));
      // 1 year: 24,000
      expect(certMonthly.totalExpectedReturn, closeTo(24000.0, 0.01));

      final certDaily = Certificate(
        id: 'cert-2',
        name: 'Daily Yield Certificate',
        amount: 365000,
        currency: 'EGP',
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2026, 1, 1),
        interestRate: 10.0, // 10% annual
        collectionType: 'daily',
        collectionDay: 1,
        accountId: 'acc-1',
      );

      // Daily: (365,000 * 0.10) / 365 = 100
      expect(certDaily.periodicPayout, closeTo(100.0, 0.01));

      final certYearly = Certificate(
        id: 'cert-3',
        name: 'Yearly Yield Certificate',
        amount: 50000,
        currency: 'USD',
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2028, 1, 1),
        interestRate: 5.0, // 5% annual
        collectionType: 'yearly',
        collectionDay: 15,
        accountId: 'acc-2',
      );

      // Yearly: 50,000 * 0.05 = 2,500
      expect(certYearly.periodicPayout, closeTo(2500.0, 0.01));
      // 3 years: 7,500
      expect(certYearly.totalExpectedReturn, closeTo(7500.0, 0.01));
    });

    test('Custom payout override takes precedence', () {
      final cert = Certificate(
        id: 'cert-custom',
        name: 'Promotional Certificate',
        amount: 100000,
        currency: 'EGP',
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2026, 1, 1),
        interestRate: 20.0,
        collectionType: 'monthly',
        collectionDay: 1,
        accountId: 'acc-1',
        customPayoutAmount: 1850.50,
      );

      expect(cert.periodicPayout, equals(1850.50));
    });

    test('Computes nextCollectionDate accurately', () {
      final cert = Certificate(
        id: 'cert-next',
        name: 'CD Account',
        amount: 10000,
        currency: 'EGP',
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime.now().add(const Duration(days: 365)),
        interestRate: 12.0,
        collectionType: 'monthly',
        collectionDay: 15,
        accountId: 'acc-1',
        lastCollectedDate: DateTime(2025, 3, 15),
      );

      final nextDate = cert.nextCollectionDate;
      expect(nextDate, isNotNull);
      expect(nextDate!.day, equals(15));
      expect(nextDate.isAfter(DateTime(2025, 3, 15)), isTrue);
    });
  });

  group('Debit Card Balance Redirection and Exclusions', () {
    test('Debit card transactions reflect directly on parent bank balance', () {
      final provider = AppProvider();
      final bank = Account(
        id: 'bank-101',
        name: 'Checking Bank',
        type: 'bank',
        balance: 10000.0,
        colorValue: 0xFF1972E8,
        currency: 'USD',
      );
      final debitCard = Account(
        id: 'card-101',
        name: 'Debit Platinum',
        type: 'debit',
        balance: 0.0,
        linkedAccountId: 'bank-101',
        colorValue: 0xFF1972E8,
        currency: 'USD',
      );

      provider.accounts = [bank, debitCard];

      // Initial effective balances
      expect(provider.getEffectiveBalance(bank), 10000.0);
      expect(provider.getEffectiveBalance(debitCard), 10000.0);
      // Net worth total balance must not double count debit card
      expect(provider.totalBalance, 10000.0);
      expect(provider.totalLiquidAccountsValue, 10000.0);
    });

    test('isCard correctly partitions accounts for home accounts vs cards tabs', () {
      final bank = Account(id: '1', name: 'Bank', type: 'bank', balance: 1000, colorValue: 0, currency: 'USD');
      final cash = Account(id: '2', name: 'Cash', type: 'cash', balance: 500, colorValue: 0, currency: 'USD');
      final debit = Account(id: '3', name: 'Debit', type: 'debit', balance: 0, colorValue: 0, currency: 'USD');
      final credit = Account(id: '4', name: 'Credit', type: 'credit', balance: 0, colorValue: 0, currency: 'USD');
      final prepaid = Account(id: '5', name: 'Prepaid', type: 'prepaid', balance: 200, colorValue: 0, currency: 'USD');

      final all = [bank, cash, debit, credit, prepaid];
      final nonCards = all.where((a) => !a.isCard).map((a) => a.id).toList();
      final cards = all.where((a) => a.isCard).map((a) => a.id).toList();

      expect(nonCards, equals(['1', '2']));
      expect(cards, equals(['3', '4', '5']));
    });

    test('Certificate reminderEarlyEnabled serialization and copyWith', () {
      final cert = Certificate(
        id: 'cert-notif',
        name: 'Notification Certificate',
        amount: 50000,
        currency: 'USD',
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2026, 1, 1),
        interestRate: 15.0,
        collectionType: 'monthly',
        collectionDay: 1,
        accountId: 'acc-1',
        reminderTime: '09:00',
        reminderEarlyEnabled: true,
      );

      final map = cert.toMap();
      expect(map['reminder_early_enabled'], equals(1));

      final restored = Certificate.fromMap(map);
      expect(restored.reminderEarlyEnabled, isTrue);
      expect(restored.reminderTime, equals('09:00'));

      final modified = restored.copyWith(reminderEarlyEnabled: false);
      expect(modified.reminderEarlyEnabled, isFalse);
    });
  });
}
