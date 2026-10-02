import 'package:flutter/material.dart';
import '../utils/haptics.dart';

/// Helper to safely evaluate simple arithmetic expressions (+, -, *, /)
/// with standard operator precedence.
class ExpressionEvaluator {
  static double? evaluate(String raw) {
    if (raw.trim().isEmpty) return null;

    final trimmed = raw.trim();
    if (trimmed.endsWith('%')) {
      return calculatePercentage(trimmed);
    }

    // Normalize operators and decimals
    var expr = raw
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('−', '-')
        .replaceAll(',', '.')
        .replaceAll(' ', '');

    // Trim trailing operators if incomplete
    while (expr.isNotEmpty && (expr.endsWith('+') || expr.endsWith('-') || expr.endsWith('*') || expr.endsWith('/'))) {
      expr = expr.substring(0, expr.length - 1);
    }
    if (expr.isEmpty) return null;

    try {
      final tokens = _tokenize(expr);
      if (tokens.isEmpty) return null;
      return _parseExpression(tokens);
    } catch (_) {
      return null;
    }
  }

  static List<String> _tokenize(String expr) {
    final tokens = <String>[];
    var current = StringBuffer();

    for (int i = 0; i < expr.length; i++) {
      final char = expr[i];
      if (char == '+' || char == '-' || char == '*' || char == '/') {
        // Handle negative numbers at start or after another operator
        if (char == '-' && (current.isEmpty && (tokens.isEmpty || _isOp(tokens.last)))) {
          current.write(char);
          continue;
        }
        if (current.isNotEmpty) {
          tokens.add(current.toString());
          current.clear();
        }
        tokens.add(char);
      } else {
        current.write(char);
      }
    }
    if (current.isNotEmpty) {
      tokens.add(current.toString());
    }
    return tokens;
  }

  static bool _isOp(String token) =>
      token == '+' || token == '-' || token == '*' || token == '/';

  static double? _parseExpression(List<String> tokens) {
    // Two-pass parsing for operator precedence:
    // Pass 1: handle * and /
    final pass1 = <String>[];
    int i = 0;
    while (i < tokens.length) {
      final token = tokens[i];
      if (token == '*' || token == '/') {
        if (pass1.isEmpty || i + 1 >= tokens.length) return null;
        final left = double.tryParse(pass1.removeLast());
        final right = double.tryParse(tokens[i + 1]);
        if (left == null || right == null) return null;
        if (token == '/' && right == 0) return null; // Avoid division by zero
        final res = token == '*' ? left * right : left / right;
        pass1.add(res.toString());
        i += 2;
      } else {
        pass1.add(token);
        i++;
      }
    }

    // Pass 2: handle + and -
    if (pass1.isEmpty) return null;
    double total = double.tryParse(pass1[0]) ?? 0.0;
    int j = 1;
    while (j < pass1.length) {
      final op = pass1[j];
      if (j + 1 >= pass1.length) break;
      final val = double.tryParse(pass1[j + 1]);
      if (val == null) return null;
      if (op == '+') {
        total += val;
      } else if (op == '-') {
        total -= val;
      }
      j += 2;
    }
    return total;
  }

  /// Formats result removing trailing zero decimals (e.g. 50.0 -> "50", 50.25 -> "50.25")
  static String formatResult(double value) {
    if (value.isInfinite || value.isNaN) return '0';
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    // Limit to 4 decimal places without unnecessary trailing zeros
    final str = value.toStringAsFixed(4);
    final trimmed = str.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    return trimmed;
  }

  /// Calculates percentage on the current numeric input or expression.
  /// Examples:
  /// - "50" -> 0.5 (50 / 100)
  /// - "200 * 15" -> 30 (15% of 200)
  /// - "100 + 15" -> 115 (100 + 15% markup)
  /// - "100 - 20" -> 80 (100 - 20% discount)
  /// - "100 / 50" -> 200 (100 / 50%)
  static double? calculatePercentage(String raw) {
    if (raw.trim().isEmpty) return null;

    final trimmedRaw = raw.trim();
    // Do not calculate on incomplete trailing operators
    if (trimmedRaw.endsWith('+') ||
        trimmedRaw.endsWith('-') ||
        trimmedRaw.endsWith('×') ||
        trimmedRaw.endsWith('÷') ||
        trimmedRaw.endsWith('*') ||
        trimmedRaw.endsWith('/')) {
      return null;
    }

    var expr = raw
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('−', '-')
        .replaceAll(',', '.')
        .replaceAll(' ', '')
        .replaceAll('%', '');

    if (expr.isEmpty) return null;

    try {
      final tokens = _tokenize(expr);
      if (tokens.isEmpty) return null;

      if (tokens.length == 1) {
        final val = double.tryParse(tokens[0]);
        if (val == null) return null;
        return val / 100.0;
      }

      final lastNum = double.tryParse(tokens.last);
      if (lastNum == null) return null;

      final op = tokens[tokens.length - 2];
      final baseTokens = tokens.sublist(0, tokens.length - 2);
      if (baseTokens.isEmpty) {
        return lastNum / 100.0;
      }

      final base = _parseExpression(baseTokens);
      if (base == null) return null;

      if (op == '*' || op == '×') {
        return base * (lastNum / 100.0);
      } else if (op == '/' || op == '÷') {
        if (lastNum == 0) return null;
        return base / (lastNum / 100.0);
      } else if (op == '+') {
        return base + (base * (lastNum / 100.0));
      } else if (op == '-') {
        return base - (base * (lastNum / 100.0));
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}

/// A custom, permanently-docked tactile numeric keypad and in-app calculator.
/// Replaces the system soft-keyboard for amount & numeric fields.
class AppNumericKeypad extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onDone;
  final ValueChanged<String>? onChanged;
  final bool showDoneButton;
  final bool compact;

  const AppNumericKeypad({
    super.key,
    required this.controller,
    this.onDone,
    this.onChanged,
    this.showDoneButton = true,
    this.compact = false,
  });

  void _onKeyPress(BuildContext context, String key) {
    AppHaptics.tap(context, HapticStrength.light);

    String current = controller.text;

    if (key == 'C') {
      controller.text = '';
      onChanged?.call('');
      return;
    }

    if (key == '⌫') {
      if (current.isNotEmpty) {
        // If ends with " + " etc., remove the whole operator and spaces
        if (current.endsWith(' ')) {
          current = current.trimRight();
          if (current.isNotEmpty) {
            current = current.substring(0, current.length - 1);
          }
          current = current.trimRight();
        } else {
          current = current.substring(0, current.length - 1);
        }
        controller.text = current;
        onChanged?.call(current);
      }
      return;
    }

    if (key == '=') {
      final res = ExpressionEvaluator.evaluate(current);
      if (res != null) {
        final formatted = ExpressionEvaluator.formatResult(res);
        controller.text = formatted;
        onChanged?.call(formatted);
      }
      return;
    }

    if (key == '%') {
      final res = ExpressionEvaluator.calculatePercentage(current);
      if (res != null) {
        final formatted = ExpressionEvaluator.formatResult(res);
        controller.text = formatted;
        onChanged?.call(formatted);
      }
      return;
    }

    if (key == '✓') {
      // Evaluate if needed then trigger onDone
      final res = ExpressionEvaluator.evaluate(current);
      if (res != null) {
        controller.text = ExpressionEvaluator.formatResult(res);
      }
      onDone?.call();
      return;
    }

    // Operators: +, -, ×, ÷
    if (key == '+' || key == '-' || key == '×' || key == '÷') {
      if (current.isEmpty) {
        if (key == '-') {
          controller.text = '-';
          onChanged?.call('-');
        }
        return;
      }
      // If ends with an operator, replace it
      final trimmed = current.trimRight();
      if (trimmed.endsWith('+') || trimmed.endsWith('-') || trimmed.endsWith('×') || trimmed.endsWith('÷')) {
        controller.text = '${trimmed.substring(0, trimmed.length - 1)}$key ';
      } else {
        controller.text = '$current $key ';
      }
      onChanged?.call(controller.text);
      return;
    }

    // Decimal point
    if (key == '.') {
      if (current.isEmpty || current.endsWith(' ')) {
        controller.text = '${current}0.';
      } else {
        // Check if last operand already has a dot
        final parts = current.split(RegExp(r'[\s\+\-×÷]+'));
        final lastPart = parts.isNotEmpty ? parts.last : '';
        if (!lastPart.contains('.')) {
          controller.text = '$current.';
        }
      }
      onChanged?.call(controller.text);
      return;
    }

    // Double zero
    if (key == '00') {
      if (current.isEmpty || current == '0') {
        controller.text = '0';
      } else {
        // Check leading zero in current operand
        final parts = current.split(RegExp(r'[\s\+\-×÷]+'));
        final lastPart = parts.isNotEmpty ? parts.last : '';
        if (lastPart == '0') {
          // Keep single 0
        } else {
          controller.text = '$current$key';
        }
      }
      onChanged?.call(controller.text);
      return;
    }

    // Digits 0-9
    if (current == '0' && key != '0') {
      controller.text = key;
    } else {
      // Check if last part is just "0"
      final parts = current.split(' ');
      if (parts.isNotEmpty && parts.last == '0' && key != '0') {
        parts[parts.length - 1] = key;
        controller.text = parts.join(' ');
      } else {
        controller.text = '$current$key';
      }
    }
    onChanged?.call(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isAmoled = Theme.of(context).scaffoldBackgroundColor == Colors.black;
    final double vSpacing = compact ? 3.0 : 6.0;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 8,
      ),
      decoration: BoxDecoration(
        color: isAmoled ? Colors.black : cs.surface,
        border: Border(
          top: BorderSide(
            color: cs.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(context, ['C', '÷', '×', '⌫']),
          SizedBox(height: vSpacing),
          _buildRow(context, ['7', '8', '9', '-']),
          SizedBox(height: vSpacing),
          _buildRow(context, ['4', '5', '6', '+']),
          SizedBox(height: vSpacing),
          _buildRow(context, ['1', '2', '3', '=']),
          SizedBox(height: vSpacing),
          _buildRow(context, ['00', '0', '.', '%']),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<String> keys) {
    return Row(
      children: keys.map((k) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: compact ? 2 : 3),
            child: _buildKeyButton(context, k),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeyButton(BuildContext context, String key) {
    final cs = Theme.of(context).colorScheme;
    final isAmoled = Theme.of(context).scaffoldBackgroundColor == Colors.black;

    // Determine button style
    Color bgColor;
    Color fgColor;
    bool isPrimaryAction = false;

    if (key == '✓') {
      bgColor = cs.primary;
      fgColor = cs.onPrimary;
      isPrimaryAction = true;
    } else if (key == '=' || key == '+' || key == '-' || key == '×' || key == '÷' || key == '%') {
      bgColor = cs.primaryContainer.withValues(alpha: isAmoled ? 0.35 : 0.8);
      fgColor = cs.primary;
    } else if (key == 'C') {
      bgColor = cs.errorContainer.withValues(alpha: isAmoled ? 0.3 : 0.6);
      fgColor = cs.error;
    } else if (key == '⌫') {
      bgColor = isAmoled ? const Color(0xFF1E1E1E) : cs.surfaceContainerHighest.withValues(alpha: 0.5);
      fgColor = cs.onSurface;
    } else {
      // Numbers: 0-9, 00, .
      bgColor = isAmoled ? const Color(0xFF161616) : cs.surfaceContainerLow;
      fgColor = cs.onSurface;
    }

    Widget content;
    if (key == '⌫') {
      content = Icon(Icons.backspace_outlined, size: compact ? 17 : 20, color: fgColor);
    } else if (key == '✓') {
      content = Icon(Icons.check, size: compact ? 20 : 24, color: fgColor);
    } else {
      content = Text(
        key,
        style: TextStyle(
          fontSize: (key == '÷' || key == '×' || key == '+' || key == '-' || key == '=' || key == '%')
              ? (compact ? 19 : 22)
              : (compact ? 17 : 19),
          fontWeight: isPrimaryAction ? FontWeight.w800 : FontWeight.w600,
          color: fgColor,
        ),
      );
    }

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(compact ? 10 : 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _onKeyPress(context, key),
        splashColor: cs.primary.withValues(alpha: 0.2),
        highlightColor: cs.primary.withValues(alpha: 0.1),
        child: Container(
          height: compact ? 36 : 44,
          alignment: Alignment.center,
          child: content,
        ),
      ),
    );
  }
}
