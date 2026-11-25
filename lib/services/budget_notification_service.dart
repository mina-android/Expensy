import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../utils/service_localizations.dart';
import 'package:intl/intl.dart';

class BudgetNotificationService {
  static final BudgetNotificationService _instance =
      BudgetNotificationService._internal();
  factory BudgetNotificationService() => _instance;
  BudgetNotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      const androidInit =
          AndroidInitializationSettings('ic_notification');
      const initSettings = InitializationSettings(android: androidInit);
      await _plugin.initialize(settings: initSettings);
      _initialized = true;
    } catch (_) {}
  }

  Future<void> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
  }

  Future<bool> hasPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return (await android?.areNotificationsEnabled()) ?? false;
  }

  Future<void> showBudgetExceeded(
      Budget budget, AppCategory category, double spentAmount,
      [double? allowanceAmount]) async {
    if (!(await hasPermission())) return;
    final limit = allowanceAmount ?? budget.amount;
    final overAmount = spentAmount - limit;
    if (overAmount <= 0) return;

    final nf = NumberFormat.currency(symbol: '');
    final amountStr = nf.format(overAmount).trim();

    // Stable ID that resets daily so budget alerts don't spam (range 4,000,000..4,399,999).
    final today = DateFormat('yyyy-MM-dd', 'en_US').format(DateTime.now());
    final id = 4000000 + ((('budget_${budget.id}_$today').hashCode & 0x0FFFFFFF) % 400000);

    const androidDetails = AndroidNotificationDetails(
      'expensy_budget',
      'Budget & Goal Alerts',
      channelDescription:
          'Immediate alerts for exceeded budgets and completed goals.',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
      enableVibration: true,
      playSound: true,
      styleInformation: BigTextStyleInformation(''),
    );
    const details = NotificationDetails(android: androidDetails);

    final loc = ServiceLocalizations.current;
    final catName = AppProvider.localizeCategoryName(category, loc);
    final periodStr =
        budget.period == 'weekly' ? loc.budget_weekly : loc.budget_monthly;

    await _plugin.show(
      id: id,
      title: loc.notif_overBudgetTitle,
      body: loc.notif_overBudgetBody(catName, amountStr, periodStr),
      notificationDetails: details,
    );
  }

  Future<void> showGoalCompleted(SavingsGoal goal) async {
    if (!(await hasPermission())) return;

    final nf = NumberFormat.currency(symbol: '');
    final amountStr = nf.format(goal.targetAmount).trim();

    // Stable ID that resets daily (range 4,000,000..4,399,999).
    final today = DateFormat('yyyy-MM-dd', 'en_US').format(DateTime.now());
    final id = 4000000 + ((('goal_${goal.id}_$today').hashCode & 0x0FFFFFFF) % 400000);

    const androidDetails = AndroidNotificationDetails(
      'expensy_budget',
      'Budget & Goal Alerts',
      channelDescription:
          'Immediate alerts for exceeded budgets and completed goals.',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
      enableVibration: true,
      playSound: true,
      styleInformation: BigTextStyleInformation(''),
    );
    const details = NotificationDetails(android: androidDetails);

    final loc = ServiceLocalizations.current;
    await _plugin.show(
      id: id,
      title: loc.notif_goalReachedTitle,
      body: loc.notif_goalReachedBody(amountStr, goal.name),
      notificationDetails: details,
    );
  }
}
