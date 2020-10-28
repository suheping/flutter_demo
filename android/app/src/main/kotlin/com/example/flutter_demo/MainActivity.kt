package com.example.flutter_demo

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.os.Build;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
import androidx.annotation.NonNull;
class MainActivity : FlutterFragmentActivity() {
   override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
       GeneratedPluginRegistrant.registerWith(flutterEngine)
   }
} 