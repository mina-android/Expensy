// test/wishlist_goal_bridge_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:drift/native.dart';
import 'package:expensy/database/app_database.dart';
import 'package:expensy/models/models.dart';
import 'package:expensy/providers/app_provider.dart';
import 'package:expensy/screens/wishlist_screen.dart';
import 'package:expensy/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    AppDatabase.setInstanceForTesting(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Wishlist-to-Savings Goal Model Tests', () {
    test('WishlistItem correctly serializes and deserializes goalId', () {
      final item = WishlistItem(
        id: 'w1',
        name: 'MacBook Pro',
        targetPrice: 2000.0,
        priority: 'high',
        isPurchased: false,
        notes: 'For development',
        goalId: 'g123',
      );

      final map = item.toMap();
      expect(map['goal_id'], 'g123');

      final deserialized = WishlistItem.fromMap(map);
      expect(deserialized.id, 'w1');
      expect(deserialized.name, 'MacBook Pro');
      expect(deserialized.targetPrice, 2000.0);
      expect(deserialized.priority, 'high');
      expect(deserialized.goalId, 'g123');
    });

    test('WishlistItem copyWith updates and clears goalId correctly', () {
      final item = WishlistItem(
        id: 'w1',
        name: 'Camera',
        targetPrice: 800.0,
        priority: 'medium',
        goalId: 'g1',
      );

      final updated = item.copyWith(goalId: 'g2');
      expect(updated.goalId, 'g2');

      final cleared = updated.copyWith(clearGoalId: true);
      expect(cleared.goalId, isNull);
    });

    test('SavingsGoal correctly serializes and deserializes wishlistItemId', () {
      final goal = SavingsGoal(
        id: 'g1',
        name: 'New Camera',
        targetAmount: 800.0,
        currentAmount: 200.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
        wishlistItemId: 'w100',
      );

      final map = goal.toMap();
      expect(map['wishlist_item_id'], 'w100');

      final deserialized = SavingsGoal.fromMap(map);
      expect(deserialized.id, 'g1');
      expect(deserialized.name, 'New Camera');
      expect(deserialized.targetAmount, 800.0);
      expect(deserialized.currentAmount, 200.0);
      expect(deserialized.wishlistItemId, 'w100');
    });

    test('SavingsGoal copyWith updates and clears wishlistItemId correctly', () {
      final goal = SavingsGoal(
        id: 'g1',
        name: 'Desk',
        targetAmount: 300.0,
        currency: 'USD',
        colorValue: 0xFF1565C0,
        wishlistItemId: 'w1',
      );

      final updated = goal.copyWith(wishlistItemId: 'w2');
      expect(updated.wishlistItemId, 'w2');

      final cleared = updated.copyWith(clearWishlistItemId: true);
      expect(cleared.wishlistItemId, isNull);
    });
  });

  group('Provider Dream & Fund Bridge Business Logic Tests', () {
    test('createGoalForWishlist connects both entities and persists', () async {
      final app = AppProvider();
      final item = WishlistItem(
        id: 'item_drone',
        name: 'DJI Drone',
        targetPrice: 900.0,
        priority: 'high',
      );
      await app.addWishlist(item);

      final goal = SavingsGoal(
        id: 'goal_drone',
        name: 'DJI Drone',
        targetAmount: 900.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
      );

      await app.createGoalForWishlist(item, goal);

      // Verify in-memory state
      final savedItem = app.wishlist.firstWhere((w) => w.id == 'item_drone');
      expect(savedItem.goalId, 'goal_drone');

      final savedGoal = app.savingsGoals.firstWhere((g) => g.id == 'goal_drone');
      expect(savedGoal.wishlistItemId, 'item_drone');

      // Verify resolution helpers
      expect(app.goalForWishlist(savedItem)?.id, 'goal_drone');
      expect(app.wishlistForGoal(savedGoal)?.id, 'item_drone');
    });

    test('unlinkWishlistAndGoal clears associations from both sides', () async {
      final app = AppProvider();
      final item = WishlistItem(
        id: 'item_tablet',
        name: 'iPad Pro',
        targetPrice: 1100.0,
        priority: 'high',
      );
      final goal = SavingsGoal(
        id: 'goal_tablet',
        name: 'iPad Pro',
        targetAmount: 1100.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
      );

      await app.addWishlist(item);
      await app.createGoalForWishlist(item, goal);

      await app.unlinkWishlistAndGoal(
        wishlistItemId: 'item_tablet',
        goalId: 'goal_tablet',
      );

      final unlinkedItem = app.wishlist.firstWhere((w) => w.id == 'item_tablet');
      final unlinkedGoal =
          app.savingsGoals.firstWhere((g) => g.id == 'goal_tablet');

      expect(unlinkedItem.goalId, isNull);
      expect(unlinkedGoal.wishlistItemId, isNull);
    });

    test('deleteWishlist unlinks linked savings goal automatically', () async {
      final app = AppProvider();
      final item = WishlistItem(
        id: 'item_headset',
        name: 'Headset',
        targetPrice: 150.0,
        priority: 'medium',
      );
      final goal = SavingsGoal(
        id: 'goal_headset',
        name: 'Headset',
        targetAmount: 150.0,
        currency: 'USD',
        colorValue: 0xFF1565C0,
      );

      await app.addWishlist(item);
      await app.createGoalForWishlist(item, goal);

      await app.deleteWishlist('item_headset');

      expect(app.wishlist.where((w) => w.id == 'item_headset'), isEmpty);
      final remainingGoal =
          app.savingsGoals.firstWhere((g) => g.id == 'goal_headset');
      expect(remainingGoal.wishlistItemId, isNull);
    });

    test('deleteSavingsGoal unlinks linked wishlist item automatically', () async {
      final app = AppProvider();
      final item = WishlistItem(
        id: 'item_monitor',
        name: '4K Monitor',
        targetPrice: 400.0,
        priority: 'high',
      );
      final goal = SavingsGoal(
        id: 'goal_monitor',
        name: '4K Monitor',
        targetAmount: 400.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
      );

      await app.addWishlist(item);
      await app.createGoalForWishlist(item, goal);

      await app.deleteSavingsGoal('goal_monitor');

      expect(app.savingsGoals.where((g) => g.id == 'goal_monitor'), isEmpty);
      final remainingItem =
          app.wishlist.firstWhere((w) => w.id == 'item_monitor');
      expect(remainingItem.goalId, isNull);
    });

    test('purchaseWishlistItem records expense transaction and completes goal', () async {
      final app = AppProvider();
      final acc = Account(
        id: 'acc_main',
        name: 'Checking',
        type: 'bank',
        balance: 1500.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final cat = AppCategory(
        id: 'cat_shop',
        name: 'Shopping',
        type: 'expense',
        colorValue: 0xFF7D5260,
      );

      final item = WishlistItem(
        id: 'item_watch',
        name: 'Smart Watch',
        targetPrice: 350.0,
        priority: 'high',
      );
      final goal = SavingsGoal(
        id: 'goal_watch',
        name: 'Smart Watch',
        targetAmount: 350.0,
        currentAmount: 350.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
        isCompleted: false,
      );

      await app.addAccount(acc);
      await app.addCategory(cat);
      await app.addWishlist(item);
      await app.createGoalForWishlist(item, goal);

      // Execute purchase with account deduction
      final itemWithGoal = app.wishlist.firstWhere((w) => w.id == 'item_watch');
      await app.purchaseWishlistItem(
        item: itemWithGoal,
        accountId: 'acc_main',
        categoryId: 'cat_shop',
        amount: 350.0,
      );

      // 1. Wishlist item marked as purchased
      final purchasedItem = app.wishlist.firstWhere((w) => w.id == 'item_watch');
      expect(purchasedItem.isPurchased, isTrue);

      // 2. Goal marked as completed
      final completedGoal =
          app.savingsGoals.firstWhere((g) => g.id == 'goal_watch');
      expect(completedGoal.isCompleted, isTrue);
      expect(completedGoal.completedAt, isNotNull);

      // 3. Transaction created and balance deducted
      final tx = app.transactions
          .where((t) => t.description == 'Smart Watch')
          .firstOrNull;
      expect(tx, isNotNull);
      expect(tx!.amount, 350.0);
      expect(tx.accountId, 'acc_main');

      final updatedAcc = app.accountById('acc_main');
      expect(updatedAcc!.balance, 1150.0); // 1500 - 350
    });
  });

  group('WishlistScreen Widget & UI Tests', () {
    Widget createTestApp(AppProvider app) {
      return ChangeNotifierProvider<AppProvider>.value(
        value: app,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: WishlistScreen(),
        ),
      );
    }

    testWidgets('Renders Fund Item button for unlinked unpurchased item',
        (tester) async {
      final app = AppProvider();
      final item = WishlistItem(
        id: 'w_unlinked',
        name: 'Espresso Machine',
        targetPrice: 600.0,
        priority: 'high',
      );
      app.wishlist = [item];

      await tester.pumpWidget(createTestApp(app));
      await tester.pumpAndSettle();

      expect(find.text('Espresso Machine'), findsOneWidget);
      expect(find.text('Fund Item'), findsOneWidget);
      expect(find.byIcon(Icons.savings_outlined), findsOneWidget);
    });

    testWidgets('Renders progress bar when linked to active savings goal',
        (tester) async {
      final app = AppProvider();
      final item = WishlistItem(
        id: 'w_linked',
        name: 'Electric Bike',
        targetPrice: 1000.0,
        priority: 'high',
        goalId: 'g_bike',
      );
      final goal = SavingsGoal(
        id: 'g_bike',
        name: 'Electric Bike',
        targetAmount: 1000.0,
        currentAmount: 400.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
        wishlistItemId: 'w_linked',
      );
      app.wishlist = [item];
      app.savingsGoals = [goal];

      await tester.pumpWidget(createTestApp(app));
      await tester.pumpAndSettle();

      expect(find.text('Electric Bike'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.textContaining('40% funded'), findsOneWidget);
    });

    testWidgets(
        'Renders celebration badge and Buy Now button when goal is achieved',
        (tester) async {
      final app = AppProvider();
      final item = WishlistItem(
        id: 'w_achieved',
        name: 'Leather Jacket',
        targetPrice: 250.0,
        priority: 'medium',
        goalId: 'g_jacket',
      );
      final goal = SavingsGoal(
        id: 'g_jacket',
        name: 'Leather Jacket',
        targetAmount: 250.0,
        currentAmount: 250.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
        wishlistItemId: 'w_achieved',
        isCompleted: true,
      );
      app.wishlist = [item];
      app.savingsGoals = [goal];

      await tester.pumpWidget(createTestApp(app));
      await tester.pumpAndSettle();

      expect(find.text('Leather Jacket'), findsOneWidget);
      expect(find.text('Goal Achieved — Ready to Buy!'), findsOneWidget);
      expect(find.text('Buy Now'), findsOneWidget);
      expect(find.byIcon(Icons.celebration_rounded), findsWidgets);
    });

    testWidgets('Tapping Buy Now opens purchase dialog', (tester) async {
      final app = AppProvider();
      final acc = Account(
        id: 'acc1',
        name: 'Checking',
        type: 'bank',
        balance: 500.0,
        currency: 'USD',
        colorValue: 0xFF1E88E5,
      );
      final cat = AppCategory(
        id: 'cat1',
        name: 'Shopping',
        type: 'expense',
        colorValue: 0xFF7D5260,
      );
      final item = WishlistItem(
        id: 'w_buy',
        name: 'Sneakers',
        targetPrice: 120.0,
        priority: 'low',
        goalId: 'g_sneakers',
      );
      final goal = SavingsGoal(
        id: 'g_sneakers',
        name: 'Sneakers',
        targetAmount: 120.0,
        currentAmount: 120.0,
        currency: 'USD',
        colorValue: 0xFF2E7D32,
        isCompleted: true,
      );
      app.accounts = [acc];
      app.categories = [cat];
      app.wishlist = [item];
      app.savingsGoals = [goal];

      await tester.pumpWidget(createTestApp(app));
      await tester.pumpAndSettle();

      // Tap Buy Now
      await tester.tap(find.text('Buy Now'));
      await tester.pumpAndSettle();

      // Verify purchase dialog popped up
      expect(find.text('Purchase Wishlist Item'), findsOneWidget);
      expect(find.text('Record & Deduct'), findsOneWidget);
      expect(find.text('Mark Purchased Only'), findsOneWidget);
    });
  });
}
