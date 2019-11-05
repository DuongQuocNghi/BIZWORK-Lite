package com.example.bizwork_lite

import android.app.Activity
import android.content.ComponentName
import android.content.Context
import android.os.Bundle
import android.content.Intent
import android.content.ServiceConnection
import android.os.IBinder
import android.view.View
import android.widget.Button
import android.widget.Toast


class SettingActivity : Activity() {

    internal var btn_start: Button? = null
    internal var btn_stop: Button? = null

    var gpsService: LocationService? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_setting)

        btn_start = findViewById<View>(R.id.btnStart) as Button
        btn_stop = findViewById<View>(R.id.btnStop) as Button


        val intent = Intent(this.application, LocationService::class.java)
        this.application.startService(intent)
        this.application.bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE)

        btn_start?.setOnClickListener {
            gpsService?.startTracking()
            Toast.makeText(applicationContext, "Start Tracking GPS", Toast.LENGTH_SHORT).show()
        }


        btn_stop?.setOnClickListener {
            gpsService?.stopTracking()
            Toast.makeText(applicationContext, "Stop Tracking GPS", Toast.LENGTH_SHORT).show()
        }

    }

    private val serviceConnection = object : ServiceConnection {
        override fun onServiceConnected(className: ComponentName, service: IBinder) {
            val name = className.className
            if (name.endsWith("LocationService")) {
                gpsService = (service as LocationService.LocationServiceBinder).service
                Toast.makeText(applicationContext, "GPS Ready", Toast.LENGTH_SHORT).show()
            }
        }

        override fun onServiceDisconnected(className: ComponentName) {
            if (className.className == "LocationService") {
                gpsService = null
            }
        }
    }
}
