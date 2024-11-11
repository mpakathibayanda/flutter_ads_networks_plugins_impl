import 'package:startapp_sdk/startapp.dart';

class StartAdsState {
  final StartAppBannerAd ? bannerAd;
  final StartAppInterstitialAd? interstitialAd;
  final StartAppRewardedVideoAd? rewardedVideoAd;
  final String skdVersion;

  StartAdsState({
    this.bannerAd,
    this.interstitialAd,
    this.rewardedVideoAd,
    this.skdVersion = '',
  });

  StartAdsState copyWith({
    StartAppBannerAd ? bannerAd,
    StartAppInterstitialAd? interstitialAd,
    StartAppRewardedVideoAd? rewardedVideoAd,
    String? skdVersion,
  }) {
    return StartAdsState(
      bannerAd: bannerAd?? this.bannerAd,
      interstitialAd: interstitialAd ?? this.interstitialAd,
      rewardedVideoAd: rewardedVideoAd ?? this.rewardedVideoAd,
      skdVersion: skdVersion ?? this.skdVersion,
    );
  }

  
}
