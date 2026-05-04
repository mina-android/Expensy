<?xml version="1.0" encoding="utf-8"?>
<!-- 
  Adaptive icon foreground layer.
  References the PNG foreground assets in mipmap-* folders.
  The PNG already has the correct 108dp canvas with content in the
  central 72dp safe zone (18dp inset on all sides).
-->
<level-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item>
        <bitmap
            android:src="@mipmap/ic_launcher_foreground"
            android:gravity="center"
            android:tileMode="disabled" />
    </item>
</level-list>
