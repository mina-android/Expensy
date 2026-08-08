# AI Instructions for Expensy

This document contains critical project context, architectural guidelines, and specific rules that AI coding assistants (like Claude, Gemini, etc.) must follow when working on the Expensy codebase.

## 1. Project Context & Stack
- **Framework:** Flutter (Android only)
- **State Management:** `Provider`. Most global state and business logic lives in `AppProvider` (`lib/providers/app_provider.dart`).
- **Local Database:** `Isar` (NoSQL). The database is initialized and managed completely offline. No network calls should be added except for the existing exchange rate or gold price APIs.
- **Theming:** Material You (`dynamic_color` package) with custom seed colors. Supports AMOLED pure black themes.
- **Minimum Android Version:** Android 5.0 (API 21)
- **Null Safety:** 100% strictly enforced.

## 2. Core Architectural Rules

### 2.1 Separation of Concerns
- **UI Layer (`lib/screens`, `lib/widgets`):** Should only handle drawing pixels, managing local ephemeral state (like form inputs or animations), and listening to `AppProvider`.
- **Logic Layer (`lib/providers/app_provider.dart`):** Handles all database writes, currency formatting, balance calculations, and complex state mutations.
- **Do NOT** make direct `Isar` or `sqflite` database calls from UI widgets. Always route through `context.read<AppProvider>()`.

### 2.2 Theming and Colors
- **Never** hardcode generic colors (like `Colors.red`, `Colors.blue`) unless absolutely necessary for specific semantic meaning (e.g., error states or specific brand colors).
- **Always** use the `ColorScheme` from `Theme.of(context).colorScheme` (e.g., `cs.primary`, `cs.onPrimary`, `cs.surface`, `cs.error`).
- For text styles, leverage the `TextTheme` or rely on the global font settings defined in the provider.

### 2.3 Form Bottom Sheets and the Keyboard
- When implementing or modifying bottom sheets containing forms (`showModalBottomSheet`), **DO NOT** pass `useSafeArea: true` to the modal. It conflicts with keyboard insets.
- Always use native `TextInputAction.next` / `TextInputAction.done` combined with `onSubmitted: (_) => FocusScope.of(context).nextFocus()` or `onSubmitted: (_) => _submit()` for form navigation. DO NOT rely on manual FocusNode listeners to advance fields, as it can cause double-jumping.


### 2.4 Snackbars
- The app uses custom snackbars to provide undo actions and notifications.
- Android Accessibility services can cause native `SnackBar` widgets with actions to stay on screen indefinitely (ignoring their `duration`).
- **Always** use the custom utility `showAppSnackbar` located in `lib/utils/snackbar.dart`. This utility forces a 3-second auto-hide timeout and standardizes the floating behavior.

### 2.5 Haptic Feedback
- **Do not** use Flutter's raw `HapticFeedback` methods directly.
- **Always** use `AppHaptics.tap(context, HapticStrength.xyz)` or `AppHaptics.drag(...)` from `lib/utils/haptics.dart`. This ensures that haptics respect the user's global settings in `AppProvider`.

### 2.6 Global Navigation (Quick Add)
- The app uses a global `rootNavigatorKey` defined in `lib/main.dart` to push overlay screens (like the Quick Add Transaction screen triggered by the Home Screen widget) seamlessly over the current bottom navigation shell without losing context.

### 2.7 UI Patterns
- **Home Screen / Slivers:** The home screen uses a `Stack` within a `SliverToBoxAdapter` for the colored header. Ensure any modifications to the header respect the exact pixel height bounds to prevent clipping or touching other elements.
- **Cards & Corners:** Use `ClipRRect` and modern corner radii (e.g., 24px) for prominent elements like the bottom navigation bar and account cards.
- **Gestures:** Favor intuitive mobile gestures like swipe-to-delete (`Dismissible`) and click-to-edit over cluttered menus where possible.

## 3. Common Pitfalls & Fixes
- **`ambiguous_import` errors:** Be careful with classes like `Transaction`, `Category`, and `Border`. Expensy uses `AppTransaction` and `AppCategory`. Use `hide` in imports where necessary (e.g., `import 'package:sqflite/sqflite.dart' hide Transaction;`).
- **Stale Contexts:** When popping modal sheets or displaying snackbars after an async gap, always check `if (!context.mounted) return;`.
- **False Positive Success Messages:** In screens involving file pickers (like Export/Restore), ensure you check if the user actually selected a path or cancelled the dialog before showing a "Success" message.

## 4. Building the App
To build the app for deployment, always use split APKs to reduce bundle size:
```bash
flutter build apk --split-per-abi
```
Releases should produce `armeabi-v7a`, `arm64-v8a`, and `x86_64` APKs in the `build/app/outputs/flutter-apk/` directory.

---
*Keep these instructions in mind to maintain the structural integrity, visual aesthetics, and performance of Expensy.*
