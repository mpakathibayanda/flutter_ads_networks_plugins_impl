import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/ads/controllers/start_ads_ctrl.dart';
import 'package:myapp/ads/views/start_ads_banner_ad_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2967002804.
    return MaterialApp(
      title: 'Flutter StartAds Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Ads Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                final ref = ProviderContainer();
                ref.read(startAdsCtrlProvider.notifier).showInterstitialAd();
              },
              child: const Text('Show interstitial ad'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                final ref = ProviderContainer();
                ref.read(startAdsCtrlProvider.notifier).showInterstitialAd();
              },
              child: const Text('Show rewarded video ad'),
            )
          ],
        ),
      ),
      bottomNavigationBar: const StartAdsBannerAdView(),
    );
  }
}
