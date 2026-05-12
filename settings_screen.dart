<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- Storage permissions for export/backup on Android 12 and below -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"
        android:maxSdkVersion="32" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
        android:maxSdkVersion="29" />

    <!-- Media permissions for Android 13+ -->
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />

    <!-- Push notification permissions -->
    <!-- Required for Android 13+ (API 33+) -->
    <!-- Schedule exact alarms for precise notification timing (Android 12+) -->
    <!-- Keep device awake to deliver notifications -->
    <!-- Receive boot completed to reschedule notifications after reboot -->

    <application
        android:label="Expensy"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:enableOnBackInvokedCallback="true"
        android:allowBackup="false"
        android:theme="@style/LaunchTheme">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">

            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />

            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <!-- flutter_local_notifications: alarm receiver -->
        <receiver
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"
            android:exported="false" />

        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />

        <!-- FileProvider for share_plus -->
        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/file_paths" />
        </provider>
    </application>

    <!-- Allow file picker and share to query installed apps -->
    <queries>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="content" />
        </intent>
        <intent>
            <action android:name="android.intent.action.GET_CONTENT" />
        </intent>
        <intent>
            <action android:name="android.intent.action.SEND" />
            <data android:mimeType="*/*" />
        </intent>
    </queries>

</manifest>
