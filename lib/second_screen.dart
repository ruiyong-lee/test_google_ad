import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState<T> extends State<SecondScreen> {
  final String _adUnitId =
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/1044960115' : 'ca-app-pub-3940256099942544/3986624511';
  NativeAd? _nativeAd;

  /// Load an AppOpenAd.
  void loadAd() {
    NativeAd(
            adUnitId: _adUnitId,
            listener: NativeAdListener(
              onAdLoaded: (ad) {
                debugPrint('$NativeAd loaded.');
                setState(() {
                  _nativeAd = ad as NativeAd?;
                });
              },
              onAdFailedToLoad: (ad, error) {
                // Dispose the ad here to free resources.
                debugPrint('$NativeAd failed to load: $error');
                ad.dispose();
              },
            ),
            request: const AdRequest(),
            // Styling
            nativeTemplateStyle: NativeTemplateStyle(
                // Required: Choose a template.
                templateType: TemplateType.medium,
                // Optional: Customize the ad's style.
                mainBackgroundColor: Colors.purple,
                cornerRadius: 10.0,
                callToActionTextStyle: NativeTemplateTextStyle(
                    textColor: Colors.cyan,
                    backgroundColor: Colors.red,
                    style: NativeTemplateFontStyle.monospace,
                    size: 16.0),
                primaryTextStyle: NativeTemplateTextStyle(
                    textColor: Colors.red,
                    backgroundColor: Colors.cyan,
                    style: NativeTemplateFontStyle.italic,
                    size: 16.0),
                secondaryTextStyle: NativeTemplateTextStyle(
                    textColor: Colors.green,
                    backgroundColor: Colors.black,
                    style: NativeTemplateFontStyle.bold,
                    size: 16.0),
                tertiaryTextStyle: NativeTemplateTextStyle(
                    textColor: Colors.brown,
                    backgroundColor: Colors.amber,
                    style: NativeTemplateFontStyle.normal,
                    size: 16.0)))
        .load();
  }

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_nativeAd == null)
              const Text(
                'NativeAd loading...',
                style: TextStyle(fontSize: 30),
              ),
            if (_nativeAd != null)
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 320, // minimum recommended width
                  minHeight: 320, // minimum recommended height
                  maxWidth: 400,
                  maxHeight: 400,
                ),
                child: AdWidget(ad: _nativeAd!),
              ),
          ],
        ),
      ),
    );
  }
}
