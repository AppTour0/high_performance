import 'dart:io';

import 'package:high_performance/app/shared/utils/constants.dart';

class AdManager {
  Constants constants = Constants();

  String get appId {
    if (Platform.isAndroid) {
      return constants.ADMOB;
    } else if (Platform.isIOS) {
      return constants.ADMOB;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return constants.BANNER;
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return constants.FULL_SCREEN;
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
