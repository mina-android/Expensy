// lib/utils/nav_metrics.dart
import 'package:flutter/material.dart';

/// Single source of truth for floating navigation bar metrics, FAB positioning,
/// and tab screen scroll padding.
class NavMetrics {
  static const double barHeight = 64.0;
  static const double barBottomGap = 16.0;
  static const double barSideMargin = 20.0;
  static const double fabGap = 12.0;
  static const double fabHeight = 48.0;
  static const double fabSideMargin = 20.0;
  static const double scrollExtraGap = 16.0;

  /// Returns the unconsumed system bottom inset (from gesture bar or 3-button nav).
  static double systemInset(BuildContext context) =>
      MediaQuery.viewPaddingOf(context).bottom;

  /// Distance from the bottom of the screen to the bottom edge of the floating bar.
  static double barBottomOffset(BuildContext context) =>
      systemInset(context) + barBottomGap;

  /// Distance from the bottom of the screen to the top edge of the floating bar.
  static double barTopOffset(BuildContext context) =>
      barBottomOffset(context) + barHeight;

  /// Distance from the bottom of the screen to the bottom edge of the FAB,
  /// guaranteeing a consistent 12px gap above the floating bar.
  static double fabBottomOffset(BuildContext context) =>
      barTopOffset(context) + fabGap;

  /// Scroll padding required for tab list views to ensure the final item clears
  /// both the floating bar and the FAB.
  static double scrollBottomPadding(BuildContext context) =>
      fabBottomOffset(context) + fabHeight + scrollExtraGap;
}

/// Positions the floating bottom navigation bar using [NavMetrics.barBottomOffset]
/// and neutralizes internal NavigationBar insets so metrics are counted exactly once.
class NavBarFrame extends StatelessWidget {
  final Widget child;
  const NavBarFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        NavMetrics.barSideMargin,
        0,
        NavMetrics.barSideMargin,
        NavMetrics.barBottomOffset(context),
      ),
      child: SizedBox(
        height: NavMetrics.barHeight,
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: child,
        ),
      ),
    );
  }
}

/// Custom [FloatingActionButtonLocation] that positions the FAB exactly
/// [bottomOffset] pixels above the bottom of the screen, with RTL awareness.
class NavAwareFabLocation extends FloatingActionButtonLocation {
  final double bottomOffset;
  const NavAwareFabLocation({required this.bottomOffset});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final isLtr = scaffoldGeometry.textDirection == TextDirection.ltr;
    final fabWidth = scaffoldGeometry.floatingActionButtonSize.width;
    final fabHeight = scaffoldGeometry.floatingActionButtonSize.height;

    final double fabX = isLtr
        ? scaffoldGeometry.scaffoldSize.width -
            fabWidth -
            NavMetrics.fabSideMargin
        : NavMetrics.fabSideMargin;
    final double fabY = scaffoldGeometry.scaffoldSize.height -
        bottomOffset -
        fabHeight;
    return Offset(fabX, fabY);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavAwareFabLocation &&
          runtimeType == other.runtimeType &&
          bottomOffset == other.bottomOffset;

  @override
  int get hashCode => bottomOffset.hashCode;
}
