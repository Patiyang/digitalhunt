import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeBannerAd extends StatefulWidget {
  const NativeBannerAd({super.key, this.onAdInfoPressed});

  final VoidCallback? onAdInfoPressed;

  @override
  State<NativeBannerAd> createState() => _NativeBannerAdState();
}

class _NativeBannerAdState extends State<NativeBannerAd> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',

      factoryId: 'nativeBanner',

      request: const AdRequest(),

      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (!mounted) return;

          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();

          if (!mounted) return;

          setState(() {
            _nativeAd = null;
            _isLoaded = false;
          });

          debugPrint('Native ad failed: $error');
        },
      ),
    );

    _nativeAd!.load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _nativeAd == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // Container(
        //   width: 350,
        //   height: 200,
        //   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).colorScheme.surface,
        //     borderRadius: BorderRadius.circular(12),
        //     border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.15)),
        //   ),
        //   clipBehavior: Clip.antiAlias,
        //   child: AdWidget(ad: _nativeAd!),
        // ),
        Container(
          width: double.infinity,
          height: 300,
          child: AdWidget(ad: _nativeAd!),
        ),
        Positioned(
          top: 8,
          right: 18,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onAdInfoPressed,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black.withValues(alpha: 0.12))],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ad',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.info_outline, size: 12, color: Colors.black87),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
