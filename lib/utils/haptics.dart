import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import '../providers/app_provider.dart';

enum HapticStrength { selection, light, medium, heavy }

class AppHaptics {
  static void tap(BuildContext context,
      [HapticStrength strength = HapticStrength.light]) {
    final enabled = context.read<AppProvider>().settings.hapticsEnabled;
    if (!enabled) return;

    switch (strength) {
      case HapticStrength.selection:
        HapticFeedback.selectionClick();
        break;
      case HapticStrength.light:
        HapticFeedback.lightImpact();
        break;
      case HapticStrength.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticStrength.heavy:
        HapticFeedback.heavyImpact();
        break;
    }
  }
}
