import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/ads/controllers/start_ads_ctrl.dart';
import 'package:startapp_sdk/startapp.dart';

class StartAdsBannerAdView extends ConsumerWidget {
  const StartAdsBannerAdView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerAd = ref.watch(startAdsCtrlProvider).bannerAd;
    if (bannerAd != null) {
      return StartAppBanner(bannerAd);
    }
    return const SizedBox.shrink();
  }
}