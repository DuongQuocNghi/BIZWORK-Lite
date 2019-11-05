package com.example.bizwork_lite

import android.app.Activity
import android.os.Bundle
import android.content.Intent
import android.view.View
import android.widget.Button



class SettingActivity : Activity() {


    internal var btn_start: Button? = null
    internal var btn_stop: Button? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_setting)

        btn_start = findViewById<View>(R.id.btnStart) as Button
        btn_stop = findViewById<View>(R.id.btnStop) as Button


        btn_start?.setOnClickListener {
            startService(Intent(this, BizworkService::class.java))
        }


        btn_stop?.setOnClickListener {

            stopService(Intent(this, BizworkService::class.java))
        }


    }
}
