// lib/screens/wrapped_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../utils/haptics.dart';

class WrappedScreen extends StatefulWidget {
  final DateTime? initialMonth;

  const WrappedScreen({super.key, this.initialMonth});

  @override
  State<WrappedScreen> createState() => _WrappedScreenState();
}

class _WrappedScreenState extends State<WrappedScreen>
    with SingleTickerProviderStateMixin {
  late DateTime _selectedMonth;
  late final PageController _pageController;
  late final AnimationController _animController;
  int _currentPage = 0;
  static const int _slideCount = 5;
  static const int _slideDurationMs = 5000;
  bool _obscureAmounts = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = widget.initialMonth ??
        (now.day <= 5
            ? DateTime(now.year, now.month - 1, 1)
            : DateTime(now.year, now.month, 1));

    _pageController = PageController();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _slideDurationMs),
    );

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_currentPage < _slideCount - 1) {
          _nextPage();
        }
      }
    });

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slideCount - 1) {
      AppHaptics.tap(context);
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animController.reset();
      if (_currentPage < _slideCount - 1) {
        _animController.forward();
      }
      setState(() {});
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      AppHaptics.tap(context);
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animController.reset();
      _animController.forward();
      setState(() {});
    }
  }

  void _restart() {
    AppHaptics.tap(context);
    _currentPage = 0;
    _pageController.jumpToPage(0);
    _animController.reset();
    _animController.forward();
    setState(() {});
  }

  void _pause() {
    if (!_isPaused) {
      _isPaused = true;
      _animController.stop();
    }
  }

  void _resume() {
    if (_isPaused) {
      _isPaused = false;
      _animController.forward();
    }
  }

  String _formatAmount(double amount, AppProvider app) {
    if (_obscureAmounts) return '***';
    return formatAmount(amount, app.settings.currency);
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final wrappedData = app.getWrappedData(_selectedMonth);
    final monthName = DateFormat('MMMM yyyy').format(_selectedMonth);

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Stack(
          children: [
            // ── Slides PageView ──────────────────────────────────────────
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _BigPictureSlide(
                  data: wrappedData,
                  monthName: monthName,
                  formatAmount: (amt) => _formatAmount(amt, app),
                ),
                _TopCategorySlide(
                  data: wrappedData,
                  monthName: monthName,
                  formatAmount: (amt) => _formatAmount(amt, app),
                ),
                _BiggestSplurgeSlide(
                  data: wrappedData,
                  monthName: monthName,
                  formatAmount: (amt) => _formatAmount(amt, app),
                ),
                _HeroHabitSlide(
                  data: wrappedData,
                  monthName: monthName,
                ),
                _ReceiptSummarySlide(
                  data: wrappedData,
                  monthName: monthName,
                  obscureAmounts: _obscureAmounts,
                  onToggleObscure: () {
                    AppHaptics.tap(context);
                    setState(() => _obscureAmounts = !_obscureAmounts);
                  },
                  onReplay: _restart,
                  formatAmount: (amt) => _formatAmount(amt, app),
                ),
              ],
            ),

            // ── Story Tap Overlay (Slides 0-3) ───────────────────────────
            if (_currentPage < _slideCount - 1)
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      flex: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _prevPage,
                        onLongPressStart: (_) => _pause(),
                        onLongPressEnd: (_) => _resume(),
                      ),
                    ),
                    Expanded(
                      flex: 65,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _nextPage,
                        onLongPressStart: (_) => _pause(),
                        onLongPressEnd: (_) => _resume(),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Header: Progress Indicators & Close Button ───────────────
              Positioned(
                top: 10,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Row(
                      children: List.generate(_slideCount, (index) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.5),
                            child: _ProgressSegment(
                              index: index,
                              currentIndex: _currentPage,
                              animController: _animController,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: cs.primaryContainer.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.auto_awesome_rounded,
                                  size: 16, color: cs.primary),
                              const SizedBox(width: 6),
                              Text(
                                l10n.wrapped_title,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: cs.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close_rounded),
                          style: IconButton.styleFrom(
                            backgroundColor:
                                cs.surfaceContainerHighest.withValues(alpha: 0.8),
                            foregroundColor: cs.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}

class _ProgressSegment extends StatelessWidget {
  final int index;
  final int currentIndex;
  final AnimationController animController;

  const _ProgressSegment({
    required this.index,
    required this.currentIndex,
    required this.animController,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Container(
        height: 3.5,
        color: cs.onSurface.withValues(alpha: 0.15),
        child: AnimatedBuilder(
          animation: animController,
          builder: (context, child) {
            double value = 0.0;
            if (index < currentIndex) {
              value = 1.0;
            } else if (index == currentIndex) {
              value = animController.value;
            }
            return FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value,
              child: Container(color: cs.primary),
            );
          },
        ),
      ),
    );
  }
}

// ── Slide 1: The Big Picture ────────────────────────────────────────────────
class _BigPictureSlide extends StatelessWidget {
  final ExpensyWrappedData data;
  final String monthName;
  final String Function(double) formatAmount;

  const _BigPictureSlide({
    required this.data,
    required this.monthName,
    required this.formatAmount,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 76, 24, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.account_balance_wallet_rounded,
                size: 40, color: cs.primary),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.wrapped_theBigPicture,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.wrapped_howMoneyMoved(monthName),
            style: TextStyle(
              fontSize: 14,
              color: cs.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          _MetricCard(
            title: l10n.wrapped_totalInflow,
            amount: formatAmount(data.totalInflow),
            color: const Color(0xFF2E7D32),
            icon: Icons.arrow_downward_rounded,
          ),
          const SizedBox(height: 12),
          _MetricCard(
            title: l10n.wrapped_totalOutflow,
            amount: formatAmount(data.totalOutflow),
            color: const Color(0xFFC62828),
            icon: Icons.arrow_upward_rounded,
          ),
          const SizedBox(height: 12),
          _MetricCard(
            title: l10n.wrapped_netSavings,
            amount: formatAmount(data.netSaved),
            color: data.netSaved >= 0 ? cs.primary : const Color(0xFFE65100),
            icon: data.netSaved >= 0 ? Icons.savings_rounded : Icons.money_off_rounded,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: cs.primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stars_rounded, color: cs.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  l10n.wrapped_savingsRate(data.savingsRate.toStringAsFixed(1)),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: cs.primary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final IconData icon;

  const _MetricCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: cs.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Slide 2: Top Spending Category ──────────────────────────────────────────
class _TopCategorySlide extends StatelessWidget {
  final ExpensyWrappedData data;
  final String monthName;
  final String Function(double) formatAmount;

  const _TopCategorySlide({
    required this.data,
    required this.monthName,
    required this.formatAmount,
  });

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    final cat = data.topCategoryId != null
        ? app.categoryById(data.topCategoryId!)
        : null;
    final catName = cat?.name ?? l10n.insights_other;
    final catColor = cat != null ? Color(cat.colorValue) : cs.primary;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 76, 24, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: catColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: catColor, width: 2),
            ),
            child: Icon(
              Icons.pie_chart_outline_rounded,
              size: 44,
              color: catColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.wrapped_topCategoryTitle,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.wrapped_topCategorySub(catName),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: cs.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: catColor.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Text(
                  formatAmount(data.topCategoryAmount),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: catColor,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (data.topCategoryPercent / 100).clamp(0.0, 1.0),
                    minHeight: 10,
                    backgroundColor: cs.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(catColor),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: catColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    l10n.wrapped_topCategoryShare(
                        data.topCategoryPercent.toStringAsFixed(1)),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: catColor,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Slide 3: Biggest Splurge ────────────────────────────────────────────────
class _BiggestSplurgeSlide extends StatelessWidget {
  final ExpensyWrappedData data;
  final String monthName;
  final String Function(double) formatAmount;

  const _BiggestSplurgeSlide({
    required this.data,
    required this.monthName,
    required this.formatAmount,
  });

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    final splurge = data.biggestSplurge;
    final cat = (splurge != null && splurge.categoryId.isNotEmpty)
        ? app.categoryById(splurge.categoryId)
        : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 76, 24, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8F00).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.local_fire_department_rounded,
                size: 44, color: Color(0xFFFF8F00)),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.wrapped_biggestSplurgeTitle,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.wrapped_biggestSplurgeSub,
            style: TextStyle(
              fontSize: 14,
              color: cs.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          if (splurge != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                    color: const Color(0xFFFF8F00).withValues(alpha: 0.4)),
              ),
              child: Column(
                children: [
                  Text(
                    splurge.description.isNotEmpty
                        ? splurge.description
                        : (cat?.name ?? l10n.insights_other),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    formatAmount(data.biggestSplurgeAmount),
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFE65100),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${DateFormat('EEEE, MMM d').format(splurge.date)} • ${cat?.name ?? l10n.insights_other}',
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.sentiment_very_satisfied_rounded,
                      color: Color(0xFF2E7D32), size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l10n.wrapped_noSplurge,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ── Slide 4: Hero Habit (Zero-Spend Days) ────────────────────────────────────
class _HeroHabitSlide extends StatelessWidget {
  final ExpensyWrappedData data;
  final String monthName;

  const _HeroHabitSlide({
    required this.data,
    required this.monthName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 76, 24, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF2E7D32), width: 2),
            ),
            child: const Icon(Icons.military_tech_rounded,
                size: 48, color: Color(0xFF2E7D32)),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.wrapped_heroHabitTitle,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.wrapped_zeroSpendAchieved(data.zeroSpendDays),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2E7D32),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Text(
                  '${data.zeroSpendDays}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Text(
                  'of ${data.totalDaysInMonth} days with zero spend',
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (data.zeroSpendDays / data.totalDaysInMonth)
                        .clamp(0.0, 1.0),
                    minHeight: 10,
                    backgroundColor: cs.surfaceContainerHighest,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.wrapped_heroHabitDesc(data.zeroSpendDays),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: cs.onSurface.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Slide 5: Receipt Summary Card ───────────────────────────────────────────
class _ReceiptSummarySlide extends StatelessWidget {
  final ExpensyWrappedData data;
  final String monthName;
  final bool obscureAmounts;
  final VoidCallback onToggleObscure;
  final VoidCallback onReplay;
  final String Function(double) formatAmount;

  const _ReceiptSummarySlide({
    required this.data,
    required this.monthName,
    required this.obscureAmounts,
    required this.onToggleObscure,
    required this.onReplay,
    required this.formatAmount,
  });

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    final cat = data.topCategoryId != null
        ? app.categoryById(data.topCategoryId!)
        : null;
    final catName = cat?.name ?? l10n.insights_other;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 76, 24, 32),
      child: Column(
        children: [
          // ── Receipt Card ─────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: cs.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EXPENSY',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900,
                        color: cs.primary,
                      ),
                    ),
                    Text(
                      monthName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.wrapped_receiptTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                Divider(color: cs.outlineVariant, thickness: 1),
                const SizedBox(height: 12),
                _ReceiptRow(
                  label: l10n.wrapped_totalInflow,
                  value: formatAmount(data.totalInflow),
                  valueColor: const Color(0xFF2E7D32),
                ),
                const SizedBox(height: 10),
                _ReceiptRow(
                  label: l10n.wrapped_totalOutflow,
                  value: formatAmount(data.totalOutflow),
                  valueColor: const Color(0xFFC62828),
                ),
                const SizedBox(height: 10),
                _ReceiptRow(
                  label: l10n.wrapped_netSavings,
                  value: formatAmount(data.netSaved),
                  valueColor: cs.primary,
                ),
                const SizedBox(height: 10),
                _ReceiptRow(
                  label: 'Savings Rate',
                  value: '${data.savingsRate.toStringAsFixed(1)}%',
                ),
                const SizedBox(height: 10),
                _ReceiptRow(
                  label: 'Top Category',
                  value: '$catName (${formatAmount(data.topCategoryAmount)})',
                ),
                const SizedBox(height: 10),
                _ReceiptRow(
                  label: 'Zero-Spend Days',
                  value: '${data.zeroSpendDays} / ${data.totalDaysInMonth}',
                ),
                const SizedBox(height: 14),
                Divider(color: cs.outlineVariant, thickness: 1),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    '★ Private & Offline Financial Mastery ★',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Controls ─────────────────────────────────────────────────────
          ActionChip(
            avatar: Icon(
              obscureAmounts
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              size: 18,
            ),
            label: Text(
              obscureAmounts
                  ? l10n.wrapped_showToggle
                  : l10n.wrapped_obscureToggle,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            onPressed: onToggleObscure,
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onReplay,
            icon: const Icon(Icons.replay_rounded),
            label: Text(l10n.wrapped_replay),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _ReceiptRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: cs.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: valueColor ?? cs.onSurface,
          ),
        ),
      ],
    );
  }
}
