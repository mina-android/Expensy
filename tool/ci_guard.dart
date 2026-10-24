// tool/ci_guard.dart
// note: CI guard script to audit code hygiene, hard-coded colors, UI DB imports, and raw dialogs.

import 'dart:io';

void main(List<String> args) {
  final enforce = args.contains('--enforce');
  stdout.writeln('=== Expensy Code Hygiene & CI Guard (Mode: ${enforce ? "ENFORCE" : "REPORT-ONLY"}) ===\n');

  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    stderr.writeln('Error: lib/ directory not found.');
    exit(1);
  }

  int hardcodedColorCount = 0;
  int isDarkCount = 0;
  int dbImportInUiCount = 0;
  int rawAlertDialogCount = 0;

  final files = libDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));

  for (final file in files) {
    final path = file.path.replaceAll('\\', '/');
    final content = file.readAsStringSync();
    final lines = content.split('\n');

    final isTheme = path.contains('/theme/');
    final isScreen = path.contains('/screens/');
    final isWidget = path.contains('/widgets/');

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (line.trim().startsWith('//')) continue;

      // 1. Hardcoded colors outside lib/theme/
      if (!isTheme && (line.contains('Color(0x') || line.contains('Color(0X'))) {
        hardcodedColorCount++;
      }

      // 2. isDark ternaries in screens/widgets
      if ((isScreen || isWidget) && line.contains('isDark ?')) {
        isDarkCount++;
      }

      // 3. UI importing DB layer
      if (isScreen || isWidget) {
        if (line.contains("import '../database/") ||
            line.contains('import "package:expensy/database/') ||
            line.contains("import 'package:expensy/database/")) {
          dbImportInUiCount++;
          stdout.writeln('  [DB in UI] $path:${i + 1}: ${line.trim()}');
        }
      }

      // 4. Raw AlertDialog
      if ((isScreen || isWidget) && line.contains('AlertDialog(')) {
        rawAlertDialogCount++;
      }
    }
  }

  stdout.writeln('\n--- Audit Summary ---');
  stdout.writeln('Hardcoded Color(0x...) outside theme: $hardcodedColorCount');
  stdout.writeln('isDark ? ternaries in UI:             $isDarkCount');
  stdout.writeln('DB layer imports directly in UI:      $dbImportInUiCount');
  stdout.writeln('Raw AlertDialog uses:                 $rawAlertDialogCount');

  if (enforce) {
    final failed = dbImportInUiCount > 0;
    if (failed) {
      stderr.writeln('\nFAILED: CI guard enforcement failed on rule violations.');
      exit(1);
    }
  }

  stdout.writeln('\nCI guard completed successfully.');
}
