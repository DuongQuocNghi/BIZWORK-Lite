package com.example.bizwork_lite

import android.app.Activity
import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

  private val CHANNEL = "com.example.bizwork_lite/platform_view"
  private val METHOD_SWITCH_VIEW = "switchSettingView"
  private val COUNT_REQUEST = 1
  private var resultCHANNEL : MethodChannel.Result? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      this.resultCHANNEL = result

      if (call.method == METHOD_SWITCH_VIEW) {
        onLaunchSettingScreen()
      } else {
        result.notImplemented()
      }
    }

  }

  private fun onLaunchSettingScreen() {
    val fullScreenIntent = Intent(this, SettingActivity::class.java)
    startActivityForResult(fullScreenIntent, COUNT_REQUEST)
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)
    if (resultCode == Activity.RESULT_OK) {
      resultCHANNEL?.success("ok")
//      resultCHANNEL?.success(data?.getIntExtra(SettingActivity.EXTRA_COUNTER, 0))
    } else {
      resultCHANNEL?.error("ACTIVITY_FAILURE", "Failed while launching activity", null)
    }
  }
}
