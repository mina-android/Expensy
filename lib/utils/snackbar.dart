import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

void showAppSnackbar(BuildContext context, String message,
    {VoidCallback? onUndo}) {
  final scaffold = ScaffoldMessenger.of(context);
  final undoLabel = AppLocalizations.of(context)?.common_undo ?? 'Undo';
  scaffold.hideCurrentSnackBar();

  final controller = scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      action: onUndo != null
          ? SnackBarAction(label: undoLabel, onPressed: onUndo)
          : null,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ),
  );

  // Forcefully close the snackbar after 3 seconds to override accessibility services
  // keeping the snackbar open indefinitely when it has an action.
  Future.delayed(const Duration(seconds: 3), () {
    try {
      controller.close();
    } catch (_) {}
  });
}
