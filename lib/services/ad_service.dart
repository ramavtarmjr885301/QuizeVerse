import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdService {
  static RewardedAd? _rewardedAd;
  static InterstitialAd? _interstitialAd;
  static const String _quizCountKey = 'quizzes_since_last_interstitial';
  static const int _adFrequency = 3;

  // Google's official TEST ad unit IDs — replace with real ones before release
  static const String _rewardedAdUnitId =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _interstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712';

  // ---------- REWARDED AD ----------
  static void loadRewardedAd({VoidCallback? onLoaded, VoidCallback? onFailed}) {
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          onLoaded?.call();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded ad failed to load: $error');
          _rewardedAd = null;
          onFailed?.call(); // NEW
        },
      ),
    );
  }

  static bool get isRewardedAdReady => _rewardedAd != null;

  static void showRewardedAd({
    required VoidCallback onUserEarnedReward,
    VoidCallback? onAdDismissed,
    VoidCallback? onAdFailedToShow,
  }) {
    if (_rewardedAd == null) {
      onAdFailedToShow?.call();
      return;
    }

    final ad = _rewardedAd!;
    _rewardedAd = null; // prevent double-show while this one is displaying

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        onAdDismissed?.call();
        loadRewardedAd(); // preload next one for future use
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        onAdFailedToShow?.call();
        loadRewardedAd();
      },
    );

    ad.show(
      onUserEarnedReward: (ad, reward) {
        onUserEarnedReward();
      },
    );
  }

  // ---------- INTERSTITIAL AD ----------
  static void loadInterstitialAd({VoidCallback? onLoaded}) {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          onLoaded?.call();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial ad failed to load: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  static bool get isInterstitialAdReady => _interstitialAd != null;

  // CRITICAL: agar ad load nahi hua ho, seedha onAdClosed() call karo —
  // user ko kabhi block/hang mat hone do result screen tak pahunchne se
  static void showInterstitialAd({required VoidCallback onAdClosed}) {
    if (_interstitialAd == null) {
      onAdClosed();
      return;
    }

    final ad = _interstitialAd!;
    _interstitialAd = null;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        onAdClosed();
        loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        onAdClosed();
        loadInterstitialAd();
      },
    );

    ad.show();
  }

  static Future<bool> shouldShowInterstitial() async {
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(_quizCountKey) ?? 0;
    final newCount = currentCount + 1;

    if (newCount >= _adFrequency) {
      await prefs.setInt(_quizCountKey, 0); // reset counter
      return true;
    } else {
      await prefs.setInt(_quizCountKey, newCount);
      return false;
    }
  }
}
