import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/models.dart';
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
    const androidInit =
        AndroidInitializationSettings('ic_notification');
    const initSettings = InitializationSettings(android: androidInit);
    await _plugin.initialize(initSettings);
    _initialized = true;
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
      Budget budget, AppCategory category, double spentAmount) async {
    if (!(await hasPermission())) return;
    final overAmount = spentAmount - budget.amount;
    if (overAmount <= 0) return;

    final nf = NumberFormat.currency(symbol: '');
    final amountStr = nf.format(overAmount).trim();

    // Stable ID that resets daily so budget alerts don't spam.
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final id = ('budget_${budget.id}_$today').hashCode & 0x7FFFFFFF;

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

    await _plugin.show(
      id,
      '🚨 Over Budget',
      '${category.name} — $amountStr over your ${budget.period} limit',
      details,
    );
  }

  Future<void> showGoalCompleted(SavingsGoal goal) async {
    if (!(await hasPermission())) return;

    final nf = NumberFormat.currency(symbol: '');
    final amountStr = nf.format(goal.targetAmount).trim();

    // Stable ID that resets daily.
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final id = ('goal_${goal.id}_$today').hashCode & 0x7FFFFFFF;

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

    await _plugin.show(
      id,
      '🎉 Goal Reached',
      'You reached your goal of $amountStr for ${goal.name}!',
      details,
    );
  }
}
