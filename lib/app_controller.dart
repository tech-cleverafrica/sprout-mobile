import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/authentication/view/sign_in_screen.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/reources/repository.dart';
import 'package:sprout_mobile/utils/app_date_utilities.dart';
import 'package:sprout_mobile/utils/constants.dart';
import 'package:sprout_mobile/utils/global_function.dart';

import 'components/authentication/service/auth_service.dart';

class AppController extends GetxController {
  AppDateUtil dateUtil = Get.put(AppDateUtil());
  Repository repository = Get.put(Repository());
  AuthService authService = Get.put(AuthService());
  final messangerKey = GlobalKey<ScaffoldMessengerState>();

  AppController({Key? key});
  String sessionTimeOut = "";

  Timer? _timer;
  bool isJailBroken = false;
  bool isRealDevice = false;

  @override
  Future<void> onInit() async {
    setLoginStatus(false);
    showAutoBiometricsOnLoginPage(true);
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    checkTimerLogic();
    super.dispose();
  }

  checkTimerLogic() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void startTimer() async {
    bool isLoggedIn = await preferenceRepository.getBooleanPref(IS_LOGGED_IN);
    if (isLoggedIn) {
      print("STARTED");
      checkTimerLogic();
      // String? expiresTime = await repository.getInSharedPreference(expiresIn);
      // DateTime tokenExpiryTime = dateUtil.customDateTimeParser(expiresTime!);
      // DateTime tokenExpiryTimeMinusOneMinute =
      //     tokenExpiryTime.subtract(Duration(minutes: 1));
      // debugPrint(" it will expire in$expiresIn");
      // debugPrint("$tokenExpiryTime");
      // debugPrint("$tokenExpiryTimeMinusOneMinute");
      // if (isLoggedIn && DateTime.now().isAfter(tokenExpiryTimeMinusOneMinute)) {
      //   String? accessToken =
      //       await repository.getInSharedPreference(accessTokenKey);
      //   authService.refreshUserToken();
      // } else {
      //   checkTimerLogic();
      // }

      // idleness logout after 5mins
      print(isLoggedIn);
      _timer = Timer(Duration(seconds: 300), logOut);
    }
  }

  logOut() async {
    bool isLoggedIn = await preferenceRepository.getBooleanPref(IS_LOGGED_IN);
    print(isLoggedIn);
    if (isLoggedIn) {
      Get.offAll(SignInScreen());
      setLoginStatus(false);
      showAutoBiometricsOnLoginPage(false);
      CustomToastNotification.show(
          "Looks like you have been away for too long. Please login to continue.",
          type: ToastType.error);
    }
  }

  exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
