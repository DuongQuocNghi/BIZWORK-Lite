package com.example.bizwork_lite

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  private val CHANNEL = "com.example.bizwork_lite/battery"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      // Note: this method is invoked on the main thread.
      if (call.method == "getBatteryLevel") {

        result.success(2341232)
      } else {
        result.notImplemented()
      }
    }

  }
}
