import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startapp_sdk/startapp.dart';

import 'start_ads_state.dart';
import '../ads_consts.dart';

class StartAdsCtrl extends StateNotifier<StartAdsState> {
  var startAppSdk = StartAppSdk();

  StartAdsCtrl() : super(StartAdsState()) {
    init();
  }

  void init() {
    if (isMobile) {
      debugPrint('=====Initializing ads=====');
      _init();
      return;
    }
    debugPrint('=====Ads not Initializing(Platform not supported)=====');
  }

  void showInterstitialAd() {
    if (isMobile) {
      _showInterstitialAd();
      return;
    }
    debugPrint('=====Interstitial not showing(Platform not supported)=====');
  }

  void showRewardedAd() {
    if (isMobile) {
      _showRewardedAd();
      return;
    }
    debugPrint('=====Rewarded not showing(Platform not supported)=====');
  }

  Future<void> _init() async {
    if (kDebugMode) {
      // make sure to comment out this line before release
      startAppSdk.setTestAdsEnabled(true);

      // your app doesn't need to call this method unless for debug purposes
      await startAppSdk.getSdkVersion().then((value) {
        state = state.copyWith(skdVersion: value);
      });
    }
    _loadBanner();
    _loadInterstitialAd();
    _loadRewardedVideoAd();
  }

  void _loadBanner() {
    startAppSdk.loadBannerAd(
      StartAppBannerType.BANNER,
      onAdImpression: () {
        debugPrint('onAdImpression: banner');
      },
      onAdClicked: () {
        debugPrint('onAdClicked: banner');
      },
    ).then((bannerAd) {
      debugPrint('Banner ad loaded');
      state = state.copyWith(bannerAd: bannerAd);
    }).onError<StartAppException>((ex, stackTrace) {
      debugPrint("Error loading Banner ad: ${ex.message}");
    }).onError((error, stackTrace) {
      debugPrint("Error loading Banner ad: $error");
    });
  }

  void _loadInterstitialAd() {
    startAppSdk.loadInterstitialAd(
      onAdDisplayed: () {
        debugPrint('onAdDisplayed: interstitial');
      },
      onAdNotDisplayed: () {
        debugPrint('onAdNotDisplayed: interstitial');
        state.interstitialAd?.dispose();
        state = state.copyWith(interstitialAd: null);
      },
      onAdClicked: () {
        debugPrint('onAdClicked: interstitial');
      },
      onAdHidden: () {
        debugPrint('onAdHidden: interstitial');
        state.interstitialAd?.dispose();
        state = state.copyWith(interstitialAd: null);
      },
    ).then((interstitialAd) {
      state = state.copyWith(interstitialAd: interstitialAd);
    }).onError<StartAppException>((ex, stackTrace) {
      debugPrint("Error loading Interstitial ad: ${ex.message}");
    }).onError((error, stackTrace) {
      debugPrint("Error loading Interstitial ad: $error");
    });
  }

  void _loadRewardedVideoAd() {
    startAppSdk.loadRewardedVideoAd(
      onAdDisplayed: () {
        debugPrint('onAdDisplayed: rewarded video');
      },
      onAdNotDisplayed: () {
        debugPrint('onAdNotDisplayed: rewarded video');
        // NOTE rewarded video ad can be shown only once
        state.rewardedVideoAd?.dispose();
        state = state.copyWith(rewardedVideoAd: null);
      },
      onAdClicked: () {
        debugPrint('onAdClicked: rewarded video');
      },
      onAdHidden: () {
        debugPrint('onAdHidden: rewarded video');
        // NOTE rewarded video ad can be shown only once
        state.rewardedVideoAd?.dispose();
        state = state.copyWith(rewardedVideoAd: null);
      },
      onVideoCompleted: () {
        debugPrint(
          'onVideoCompleted: rewarded video completed, user gain a reward',
        );
        //TODO: Reward the user
      },
    ).then((rewardedVideoAd) {
      debugPrint("Loaded Rewarded Video ad");
      state = state.copyWith(rewardedVideoAd: rewardedVideoAd);
    }).onError<StartAppException>((ex, stackTrace) {
      debugPrint("Error loading Rewarded Video ad: ${ex.message}");
    }).onError((error, stackTrace) {
      debugPrint("Error loading Rewarded Video ad: $error");
    });
  }

  void _showInterstitialAd() {
    if (state.interstitialAd != null) {
      state.interstitialAd!.show().then((shown) {
        if (shown) {
          // NOTE interstitial ad can be shown only once
          state = state.copyWith(interstitialAd: null);
          // NOTE load again
          _loadInterstitialAd();
        }
        return null;
      }).onError((error, stackTrace) {
        debugPrint("Error showing Interstitial ad: $error");
      });
    }
  }

  void _showRewardedAd() {
    if (state.rewardedVideoAd != null) {
      state.rewardedVideoAd!.show().then((shown) {
        if (shown) {
          // NOTE RewardedVideo ad can be shown only once
          state = state.copyWith(rewardedVideoAd: null);
          // NOTE load again
          _loadRewardedVideoAd();
        }
        return null;
      }).onError((error, stackTrace) {
        debugPrint("Error showing Rewarded Video ad: $error");
        _loadRewardedVideoAd();
        return null;
      });
    }
  }
}

final startAdsCtrlProvider = StateNotifierProvider<StartAdsCtrl,StartAdsState >(
  (ref)=>StartAdsCtrl(),
);
