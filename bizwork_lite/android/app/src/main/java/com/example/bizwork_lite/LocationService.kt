package com.example.bizwork_lite

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.location.Location
import android.location.LocationManager
import android.os.Binder
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import android.util.Log
import android.widget.Toast
import androidx.annotation.RequiresApi


class LocationService : Service() {
    private val binder = LocationServiceBinder()
    private val TAG = "LocationService"
    private var mLocationListener: LocationListener? = null
    private var mLocationManager: LocationManager? = null

    private val LOCATION_INTERVAL = 500
    private val LOCATION_DISTANCE = 10

    private val notification: Notification
        @RequiresApi(Build.VERSION_CODES.O)
        get() {

            val channel = NotificationChannel("channel_01", "My Channel", NotificationManager.IMPORTANCE_DEFAULT)

            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager!!.createNotificationChannel(channel)

            val builder = Notification.Builder(applicationContext, "channel_01").setAutoCancel(true)
            return builder.build()
        }

    override fun onBind(intent: Intent): IBinder? {
        return binder
    }

    private inner class LocationListener(provider: String) : android.location.LocationListener {
        private val TAG = "LocationListener"
        private var mLastLocation: Location? = null

        init {
            mLastLocation = Location(provider)
        }

        override fun onLocationChanged(location: Location) {
            mLastLocation = location
            Toast.makeText(applicationContext, "LocationChanged: " + location.latitude + " -- " + location.longitude, Toast.LENGTH_SHORT).show()
            Log.i(TAG, "LocationChanged: " + location.latitude + " -- " + location.longitude)
        }

        override fun onProviderDisabled(provider: String) {
            Log.e(TAG, "onProviderDisabled: $provider")
        }

        override fun onProviderEnabled(provider: String) {
            Log.e(TAG, "onProviderEnabled: $provider")
        }

        override fun onStatusChanged(provider: String, status: Int, extras: Bundle) {
            Log.e(TAG, "onStatusChanged: $status")
        }
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        super.onStartCommand(intent, flags, startId)
        return Service.START_NOT_STICKY
    }

    override fun onCreate() {
        Log.i(TAG, "onCreate")
    }

    override fun onDestroy() {
        super.onDestroy()
        if (mLocationManager != null) {
            try {
                mLocationManager!!.removeUpdates(mLocationListener)
                Toast.makeText(applicationContext, "remove location listners", Toast.LENGTH_SHORT).show()
            } catch (ex: Exception) {
                Log.i(TAG, "fail to remove location listners, ignore", ex)
            }

        }
    }

    private fun initializeLocationManager() {
        if (mLocationManager == null) {
            mLocationManager = applicationContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        }
    }

    fun startTracking() {
        startForeground(12345678, notification)
        initializeLocationManager()
        mLocationListener = LocationListener(LocationManager.GPS_PROVIDER)

        try {
            mLocationManager!!.requestLocationUpdates(LocationManager.GPS_PROVIDER, LOCATION_INTERVAL.toLong(), LOCATION_DISTANCE.toFloat(), mLocationListener)

        } catch (ex: java.lang.SecurityException) {
            // Log.i(TAG, "fail to request location update, ignore", ex);
        } catch (ex: IllegalArgumentException) {
            // Log.d(TAG, "gps provider does not exist " + ex.getMessage());
        }

    }

    fun stopTracking() {
        this.stopForeground(true)
        this.stopSelf()
        this.onDestroy()
    }

    inner class LocationServiceBinder : Binder() {
        val service: LocationService
            get() = this@LocationService
    }

}
