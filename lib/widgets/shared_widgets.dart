// lib/widgets/shared_widgets.dart
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

// ─── Category colour dot ──────────────────────────────────────────────────
class CategoryDot extends StatelessWidget {
  final Category? category;
  final double size;

  const CategoryDot({super.key, this.category, this.size = 42});

  @override
  Widget build(BuildContext context) {
    final cs     = Theme.of(context).colorScheme;
    final colour = category != null ? Color(category!.colorValue) : cs.primary;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Center(
        child: Container(
          width: size * 0.38,
          height: size * 0.38,
          decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

// ─── Account type icon ────────────────────────────────────────────────────
class AccountTypeIcon extends StatelessWidget {
  final String type;
  final double size;
  final Color? color;

  const AccountTypeIcon({super.key, required this.type, this.size = 20, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.onPrimary;
    final IconData icon;
    switch (type) {
      case 'cash':
        icon = Icons.payments_outlined;
        break;
      case 'savings':
        icon = Icons.savings_outlined;
        break;
      case 'credit':
        icon = Icons.credit_card_outlined;
        break;
      case 'wallet':
        icon = Icons.account_balance_wallet_outlined;
        break;
      default:
        icon = Icons.account_balance_outlined;
    }
    return Icon(icon, size: size, color: c);
  }
}

// ─── Section header ───────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// ─── Amount display ───────────────────────────────────────────────────────
class AmountText extends StatelessWidget {
  final double amount;
  final String currencyCode;
  final bool isIncome;
  final double fontSize;
  final bool showSign;

  const AmountText({
    super.key,
    required this.amount,
    required this.currencyCode,
    this.isIncome = true,
    this.fontSize = 16,
    this.showSign = true,
  });

  @override
  Widget build(BuildContext context) {
    final sign = showSign ? (isIncome ? '+' : '-') : '';
    return Text(
      '$sign${formatAmount(amount, currencyCode)}',
      style: TextStyle(
        color: isIncome ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
      ),
    );
  }
}

// ─── Empty state ──────────────────────────────────────────────────────────
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? subMessage;

  const EmptyState({
    super.key,
    required this.icon,
    required this.message,
    this.subMessage,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: cs.primary.withValues(alpha: 0.3)),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: cs.onSurface.withValues(alpha: 0.6),
                  ),
              textAlign: TextAlign.center,
            ),
            if (subMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                subMessage!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.4),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Pill badge ───────────────────────────────────────────────────────────
class PillBadge extends StatelessWidget {
  final String label;
  final Color color;
  const PillBadge({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }
}

// ─── Progress bar ─────────────────────────────────────────────────────────
class LinearProgressCard extends StatelessWidget {
  final double value;
  final Color? color;
  final double height;

  const LinearProgressCard({super.key, required this.value, this.color, this.height = 7});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: height,
        backgroundColor: cs.surfaceContainerHighest,
        color: color ?? cs.primary,
      ),
    );
  }
}

// ─── Confirmation dialog ──────────────────────────────────────────────────
Future<bool> showDeleteConfirm(BuildContext context, String item) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete'),
      content: Text('Delete "$item"? This cannot be undone.'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  return result ?? false;
}

// ─── Snackbar helpers ─────────────────────────────────────────────────────
void showSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: const Color(0xFF2E7D32),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: const Color(0xFFC62828),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
