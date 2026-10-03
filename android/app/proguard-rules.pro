# Flutter rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.provider.** { *; }

# flutter_local_notifications keep rules
-keepattributes *Annotation*
-keepattributes Signature
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keep class com.google.gson.** { *; }
-keep class com.google.android.gms.internal.** { *; }

# Sqflite rules
-keep class com.tekartik.sqflite.** { *; }

# Flutter Play Core / Deferred Components
-dontwarn com.google.android.play.core.**
-dontwarn io.flutter.embedding.engine.deferredcomponents.**

# home_widget rules
-keep class es.antonborri.home_widget.** { *; }
-dontwarn es.antonborri.home_widget.**

# Drift & sqlite3_flutter_libs native FFI rules
-keep class com.simonbinder.sqlite3_flutter_libs.** { *; }
-dontwarn com.simonbinder.sqlite3_flutter_libs.**
-keep class net.sqlcipher.** { *; }
-dontwarn net.sqlcipher.**
