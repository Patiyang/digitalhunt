// package com.digitalhunt.app

// import android.content.Context
// import android.view.LayoutInflater
// import android.view.View
// import android.widget.ImageView
// import android.widget.TextView

// import com.google.android.gms.ads.nativead.NativeAd
// import com.google.android.gms.ads.nativead.NativeAdView

// import io.flutter.plugins.googlemobileads.NativeAdFactory

// class DigitalHuntNativeAdFactory(
//     private val context: Context
// ) : NativeAdFactory {

//     override fun createNativeAd(
//         nativeAd: NativeAd,
//         customOptions: MutableMap<String, Any>?
//     ): NativeAdView {

//         val adView = LayoutInflater
//             .from(context)
//             .inflate(
//                 R.layout.native_banner_ad,
//                 null
//             ) as NativeAdView

//         val headlineView =
//             adView.findViewById<TextView>(R.id.ad_headline)

//         val bodyView =
//             adView.findViewById<TextView>(R.id.ad_body)

//         val advertiserView =
//             adView.findViewById<TextView>(R.id.ad_advertiser)

//         val iconView =
//             adView.findViewById<ImageView>(R.id.ad_app_icon)

//         val callToActionView =
//             adView.findViewById<TextView>(R.id.ad_call_to_action)

//         // Headline
//         headlineView.text = nativeAd.headline
//         adView.headlineView = headlineView

//         // Body
//         if (nativeAd.body != null) {
//             bodyView.text = nativeAd.body
//             bodyView.visibility = View.VISIBLE
//             adView.bodyView = bodyView
//         } else {
//             bodyView.visibility = View.GONE
//         }

//         // Advertiser
//         if (nativeAd.advertiser != null) {
//             advertiserView.text = nativeAd.advertiser
//             advertiserView.visibility = View.VISIBLE
//             adView.advertiserView = advertiserView
//         } else {
//             advertiserView.visibility = View.GONE
//         }

//         // Icon
//         if (nativeAd.icon != null) {
//             iconView.setImageDrawable(
//                 nativeAd.icon!!.drawable
//             )

//             iconView.visibility = View.VISIBLE
//             adView.iconView = iconView
//         } else {
//             iconView.visibility = View.GONE
//         }

//         // Call to action
//         if (nativeAd.callToAction != null) {
//             callToActionView.text = nativeAd.callToAction
//             callToActionView.visibility = View.VISIBLE
//             adView.callToActionView = callToActionView
//         } else {
//             callToActionView.visibility = View.GONE
//         }

//         adView.setNativeAd(nativeAd)

//         return adView
//     }
// }


package com.digitalhunt.app

import android.content.Context
import android.view.LayoutInflater

import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView

import io.flutter.plugins.googlemobileads.NativeAdFactory

class DigitalHuntNativeAdFactory(
    private val context: Context
) : NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {

        val adView = LayoutInflater
            .from(context)
            .inflate(
                R.layout.native_banner_ad,
                null
            ) as NativeAdView

        val mediaView =
            adView.findViewById<MediaView>(R.id.ad_media)

        adView.mediaView = mediaView

        adView.setNativeAd(nativeAd)

        return adView
    }
}