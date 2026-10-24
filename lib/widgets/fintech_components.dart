// lib/widgets/fintech_components.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../utils/haptics.dart';

/// Modern edge-to-edge transparent top header that respects system status bar padding.
/// Matches the styling of the redesigned Home screen header.
class FintechHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;

  const FintechHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.titleWidget,
    this.actions,
    this.leading,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final topPadding = MediaQuery.of(context).padding.top;

    return Padding(
      padding: padding ??
          EdgeInsets.only(
            top: topPadding + 14,
            left: 20,
            right: 16,
            bottom: 10,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                titleWidget ??
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                          ),
                    ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: cs.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

/// Circular frosted tactile button used in Fintech headers for actions.
class FintechCircleButton extends StatelessWidget {
  final IconData? icon;
  final Widget? child;
  final VoidCallback? onPressed;
  final VoidCallback? onTap;
  final String? tooltip;
  final Color? color;
  final Color? iconColor;
  final double size;

  const FintechCircleButton({
    super.key,
    this.icon,
    this.child,
    this.onPressed,
    this.onTap,
    this.tooltip,
    this.color,
    this.iconColor,
    this.size = 40,
  }) : assert(icon != null || child != null);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;
    final action = onPressed ?? onTap;

    final defaultBg = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.05);

    Widget btn = Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: action == null
            ? null
            : () {
                AppHaptics.tap(context, HapticStrength.light);
                action();
              },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color ?? defaultBg,
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.07)
                  : Colors.black.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: child ??
              Icon(
                icon,
                size: size * 0.5,
                color: iconColor ?? cs.onSurface.withValues(alpha: 0.85),
              ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: btn);
    }
    return btn;
  }
}

/// Modern pill-shaped segmented control replacing old underlined TabBars.
class FintechSegmentedControl<T> extends StatelessWidget {
  final List<FintechSegmentItem<T>> items;
  final T selectedValue;
  final ValueChanged<T> onValueChanged;
  final Color? activeColor;
  final Color? activeTextColor;

  const FintechSegmentedControl({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onValueChanged,
    this.activeColor,
    this.activeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? cs.surfaceContainerHighest.withValues(alpha: 0.35)
            : cs.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
        ),
      ),
      child: Row(
        children: items.map((item) {
          final isSelected = item.value == selectedValue;
          final itemColor = activeColor ?? cs.primary;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (!isSelected) {
                  AppHaptics.tap(context, HapticStrength.selection);
                  onValueChanged(item.value);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? itemColor.withValues(alpha: 0.25) : itemColor)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(
                          color: isDark
                              ? itemColor.withValues(alpha: 0.4)
                              : Colors.transparent,
                        )
                      : null,
                  boxShadow: isSelected && !isDark
                      ? [
                          BoxShadow(
                            color: itemColor.withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (item.icon != null) ...[
                      Icon(
                        item.icon,
                        size: 16,
                        color: isSelected
                            ? (isDark
                                ? itemColor
                                : (activeTextColor ?? Colors.white))
                            : cs.onSurface.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Flexible(
                      child: Text(
                        item.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? (isDark
                                  ? itemColor
                                  : (activeTextColor ?? Colors.white))
                              : cs.onSurface.withValues(alpha: 0.65),
                        ),
                      ),
                    ),
                    if (item.badge != null && item.badge!.isNotEmpty) ...[
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark
                                  ? itemColor.withValues(alpha: 0.3)
                                  : Colors.white.withValues(alpha: 0.25))
                              : cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          item.badge!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? (isDark
                                    ? itemColor
                                    : (activeTextColor ?? Colors.white))
                                : cs.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FintechSegmentItem<T> {
  final T value;
  final String label;
  final IconData? icon;
  final String? badge;

  const FintechSegmentItem({
    required this.value,
    required this.label,
    this.icon,
    this.badge,
  });
}

/// Contained grouped ledger container (matching Home recent activity ledger).
/// Encloses grouped items inside a sleek rounded card with hairline borders.
class FintechContainedLedger extends StatelessWidget {
  final Widget? header;
  final List<Widget> children;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool showDividers;
  final double dividerIndent;

  const FintechContainedLedger({
    super.key,
    this.header,
    required this.children,
    this.margin,
    this.padding,
    this.showDividers = true,
    this.dividerIndent = 68,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: cs.surfaceContainer.withValues(alpha: isDark ? 0.45 : 0.65),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) header!,
          if (children.isNotEmpty)
            ListView.separated(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: children.length,
              separatorBuilder: (_, __) => showDividers
                  ? Divider(
                      height: 1,
                      indent: dividerIndent,
                      endIndent: 16,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.black.withValues(alpha: 0.04),
                    )
                  : const SizedBox.shrink(),
              itemBuilder: (_, index) => children[index],
            ),
        ],
      ),
    );
  }
}

/// Modern elevated hero card with multi-stop gradients and glassmorphism.
class FintechHeroCard extends StatelessWidget {
  final Widget child;
  final Color? accentColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final VoidCallback? onTap;

  const FintechHeroCard({
    super.key,
    required this.child,
    this.accentColor,
    this.padding,
    this.margin,
    this.borderRadius = 24,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;
    final color = accentColor ?? cs.primary;

    Widget content = child;
    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      );
    }

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: onTap != null ? EdgeInsets.zero : (padding ?? const EdgeInsets.all(20)),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  color.withValues(alpha: 0.22),
                  cs.surfaceContainerHigh.withValues(alpha: 0.8),
                  cs.surfaceContainer.withValues(alpha: 0.6),
                ]
              : [
                  color.withValues(alpha: 0.08),
                  color.withValues(alpha: 0.03),
                  cs.surface,
                ],
        ),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : color.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: isDark ? 0.08 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: content,
    );
  }
}

/// Modern squircle Fintech FAB for secondary screens and sub-pages.
class FintechFab extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color? color;
  final Color? foregroundColor;
  final String? tooltip;
  final double size;

  const FintechFab({
    super.key,
    required this.onPressed,
    this.icon = Icons.add_rounded,
    this.color,
    this.foregroundColor,
    this.tooltip,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = color ?? cs.primary;
    final fg = foregroundColor ?? (isDark ? Colors.white : Colors.white);

    Widget btn = Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          AppHaptics.tap(context, HapticStrength.light);
          onPressed();
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                bg,
                Color.lerp(bg, Colors.black, isDark ? 0.25 : 0.15)!,
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: isDark ? 0.25 : 0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: bg.withValues(alpha: isDark ? 0.45 : 0.35),
                blurRadius: 18,
                spreadRadius: 0,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: fg, size: 26),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: btn);
    }
    return btn;
  }
}

/// Modern extended pill Fintech FAB with an icon and label.
class FintechExtendedFab extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color? color;
  final Color? foregroundColor;

  const FintechExtendedFab({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.color,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = color ?? cs.primary;
    final fg = foregroundColor ?? Colors.white;

    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          AppHaptics.tap(context, HapticStrength.light);
          onPressed();
        },
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                bg,
                Color.lerp(bg, Colors.black, isDark ? 0.25 : 0.15)!,
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: isDark ? 0.25 : 0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: bg.withValues(alpha: isDark ? 0.45 : 0.35),
                blurRadius: 18,
                spreadRadius: 0,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: fg, size: 22),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable Fintech Components (Item 4 & 8) ──────────────────────────────────

/// Standardized modern fintech reminder toggle container with leading icon,
/// title, optional subtitle, switch, and collapsible child content.
class FintechReminderToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? activeColor;
  final Widget? expandedContent;

  const FintechReminderToggle({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.icon = Icons.notifications_active_outlined,
    this.activeColor,
    this.expandedContent,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = activeColor ?? cs.primary;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainer.withValues(alpha: isDark ? 0.35 : 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value
              ? accent.withValues(alpha: 0.35)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.black.withValues(alpha: 0.04)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile.adaptive(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            secondary: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: (value ? accent : cs.onSurface).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: value ? accent : cs.onSurface.withValues(alpha: 0.6),
                size: 20,
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withValues(alpha: 0.6),
                    ),
                  )
                : null,
            activeTrackColor: accent,
            value: value,
            onChanged: (v) {
              AppHaptics.tap(context, HapticStrength.light);
              onChanged(v);
            },
          ),
          if (value && expandedContent != null) ...[
            Divider(
              height: 1,
              thickness: 1,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.black.withValues(alpha: 0.04),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: expandedContent!,
            ),
          ],
        ],
      ),
    );
  }
}

/// Standardized date field button matching LoansScreen InputDecoration style.
class FintechDateField extends StatelessWidget {
  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final IconData prefixIcon;
  final DateFormat? formatter;

  const FintechDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onDateSelected,
    this.firstDate,
    this.lastDate,
    this.prefixIcon = Icons.calendar_today_outlined,
    this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    final fmt = formatter ?? DateFormat('MMM dd, yyyy');
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        AppHaptics.tap(context, HapticStrength.light);
        final picked = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: firstDate ?? DateTime(2000),
          lastDate: lastDate ?? DateTime(2100),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon, size: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        child: Text(
          fmt.format(value),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// Metric summary chip with tinted surface container, colored border, and
/// uppercase label matching LoansScreen design.
class FintechSummaryChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const FintechSummaryChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isDark ? 0.15 : 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Auto-formats MM/YY expiry dates, auto-inserting the slash after 2 digits.
class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll('/', '');
    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Modern standardized Fintech confirmation or informational dialog.
class FintechDialog extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final bool isDestructive;

  const FintechDialog({
    super.key,
    this.icon,
    required this.title,
    required this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.isDestructive = false,
  });

  static Future<bool?> show(
    BuildContext context, {
    Widget? icon,
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => FintechDialog(
        icon: icon,
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        isDestructive: isDestructive,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      elevation: 10,
      icon: icon != null
          ? Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isDestructive ? cs.error : cs.primary)
                      .withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: icon,
              ),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        textAlign: icon != null ? TextAlign.center : TextAlign.start,
      ),
      content: Text(
        content,
        style: TextStyle(
          color: cs.onSurface.withValues(alpha: 0.75),
          height: 1.4,
          fontSize: 14,
        ),
        textAlign: icon != null ? TextAlign.center : TextAlign.start,
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        if (cancelText != null)
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              cancelText!,
              style: TextStyle(
                color: cs.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (confirmText != null)
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: isDestructive ? cs.error : cs.primary,
              foregroundColor: isDestructive ? cs.onError : cs.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              Navigator.pop(context, true);
              onConfirm?.call();
            },
            child: Text(
              confirmText!,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }
}


