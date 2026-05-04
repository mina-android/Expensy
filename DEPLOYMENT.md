# Expensy v2.0 — Complete Deployment Guide

## Project Structure

```
expensy_v2/
├── pubspec.yaml                          ← Dependencies
├── lib/
│   ├── main.dart                         ← App entry point + theme
│   ├── models/
│   │   └── models.dart                   ← All 5 data models
│   ├── database/
│   │   └── db_helper.dart               ← SQLite CRUD (all entities)
│   ├── providers/
│   │   └── app_provider.dart            ← State management (ChangeNotifier)
│   ├── theme/
│   │   └── app_theme.dart               ← Material You themes + currencies
│   ├── widgets/
│   │   └── shared_widgets.dart          ← Reusable UI components
│   └── screens/
│       ├── main_shell.dart              ← Bottom nav shell
│       ├── onboarding_screen.dart       ← 4-step landing/setup
│       ├── home_screen.dart             ← Dashboard
│       ├── transactions_screen.dart     ← History, search, filter, edit
│       ├── add_transaction_screen.dart  ← Add / edit transaction
│       ├── statistics_screen.dart       ← Bar + Pie charts
│       ├── accounts_screen.dart         ← Multi-account management
│       ├── transfer_screen.dart         ← Transfer between accounts
│       ├── more_screen.dart             ← Hub screen
│       ├── recurring_screen.dart        ← Recurring payments + reminders
│       ├── wishlist_screen.dart         ← Wishlist tracker
│       ├── lended_screen.dart           ← Money lending tracker
│       ├── categories_screen.dart       ← Custom categories
│       ├── settings_screen.dart         ← Theme/currency/notifications
│       ├── export_screen.dart           ← CSV export
│       └── backup_screen.dart           ← JSON backup & restore
└── android/
    ├── app/
    │   ├── build.gradle
    │   └── src/main/
    │       ├── AndroidManifest.xml
    │       ├── kotlin/com/example/expensy/MainActivity.kt
    │       └── res/
    │           ├── values/styles.xml
    │           ├── drawable/launch_background.xml
    │           └── xml/file_paths.xml
    ├── build.gradle
    ├── settings.gradle
    ├── gradle.properties
    └── gradle/wrapper/gradle-wrapper.properties
```

---

## Features

| Feature | Details |
|---|---|
| Onboarding | 4-step setup: name → currency → accounts |
| Multiple Accounts | bank, cash, savings, credit, e-wallet |
| Account Transfer | With balance preview and transaction records |
| Transactions | Add, edit, delete, search, filter by type/account |
| Categories | Custom income/expense categories with colours |
| Statistics | 6-month bar chart + expense pie chart |
| Recurring Payments | End-date based, any frequency (X days/weeks/months/years) |
| Payment Reminders | Per-payment reminder toggle |
| Wishlist | Priority tracking, mark purchased |
| Lended Money | Track lent/borrowed, due dates, settle |
| Export | CSV via share sheet |
| Backup/Restore | Full JSON backup |
| Settings | Theme seed (6 colours), dark mode, currency (8), notifications |
| Offline | 100% local SQLite — no internet needed |

---

## Prerequisites

1. **Flutter SDK 3.3+** — https://flutter.dev/docs/get-started/install
2. **Android Studio** — https://developer.android.com/studio  
3. **Java JDK 17** — https://adoptium.net/
4. Verify with: `flutter doctor` (all items should be ✓)

---

## Step 1 — Create Flutter project

```bash
flutter create expensy
cd expensy
```

## Step 2 — Replace project files

```bash
# Copy everything from the zip into your project folder
# Replace: lib/, android/, pubspec.yaml
cp -r /path/to/expensy_v2/lib ./
cp -r /path/to/expensy_v2/android ./
cp /path/to/expensy_v2/pubspec.yaml .
```

## Step 3 — Install dependencies

```bash
flutter pub get
```

## Step 4 — Run in development

```bash
# On connected Android device or emulator
flutter run

# List connected devices
flutter devices
```

## Step 5 — Build release APK

```bash
# Debug APK (for testing, no signing needed)
flutter build apk --debug

# Release APK (optimised)
flutter build apk --release

# Split APKs by CPU architecture (smaller download size)
flutter build apk --split-per-abi --release

# App Bundle for Google Play Store
flutter build appbundle --release
```

Output locations:
- Debug APK: `build/app/outputs/flutter-apk/app-debug.apk`
- Release APK: `build/app/outputs/flutter-apk/app-release.apk`
- Split APKs: `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` etc.

## Step 6 — Install on device via USB

```bash
adb install build/app/outputs/flutter-apk/app-debug.apk

# Or for release
adb install build/app/outputs/flutter-apk/app-release.apk
```

## Step 7 — Side-load without USB

1. Transfer APK to phone (email, Google Drive, USB)
2. On phone: **Settings → Security → Install Unknown Apps**
3. Enable for your file manager or browser
4. Tap the APK file

---

## Signing for Play Store (Optional)

### Generate keystore
```bash
keytool -genkey -v -keystore ~/expensy.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias expensy
```

### Create android/key.properties
```
storePassword=YOUR_PASSWORD
keyPassword=YOUR_PASSWORD
keyAlias=expensy
storeFile=/home/YOUR_USER/expensy.jks
```

### Update android/app/build.gradle
```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### Build signed bundle
```bash
flutter build appbundle --release
```

---

## Troubleshooting

### Gradle build fails
```bash
cd android && ./gradlew clean && cd ..
flutter clean
flutter pub get
flutter run
```

### License errors
```bash
flutter doctor --android-licenses
# Accept all with 'y'
```

### SDK version issues
```bash
# Check your SDK version
flutter --version
# Minimum: Flutter 3.3.0, Dart 3.3.0
```

### `adb: command not found`
Add Android SDK platform-tools to PATH:
```bash
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"
```

---

## Minimum Requirements

- Android 5.0 (API 21) and above
- ~25 MB storage for app
- No internet connection required
- SQLite database (included in Android)
