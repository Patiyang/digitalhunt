// package com.digitalhunt.app

// import io.flutter.embedding.android.FlutterActivity

// class MainActivity : FlutterActivity()


// package com.example.myapp

package com.digitalhunt.app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterActivity() {

    private lateinit var nativeAdFactory: DigitalHuntNativeAdFactory

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        nativeAdFactory = DigitalHuntNativeAdFactory(this)

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine!!,
            "nativeBanner",
            nativeAdFactory
        )
    }

    override fun onDestroy() {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(
            flutterEngine!!,
            "nativeBanner"
        )

        super.onDestroy()
    }
}