import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/utils/app_date_utilities.dart';

class AppController extends GetxController {
  AppDateUtil dateUtil = Get.put(AppDateUtil());
  // Repository repository = Get.put(Repository());
  // ApiProvider apiProvider = Get.put(ApiProvider());
  // final messangerKey = GlobalKey<ScaffoldMessengerState>();

  AppController({Key? key});
  String sessionTimeOut = "";

  Timer? _timer;
  bool isJailBroken = false;
  bool isRealDevice = false;

  @override
  Future<void> onInit() async {
    //setLoginStatus(false);
    // showAutoBiometricsOnLoginPage(true);
    //  startTimer();
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

  // void startTimer() async {
  //   checkTimerLogic();
  //   bool isLoggedIn = await preferenceRepository.getBooleanPref(IS_LOGGED_IN);
  //   String? expiresIn =
  //       await repository.getInSharedPreference(tokenTimestampKey);
  //   DateTime tokenExpiryTime = dateUtil.customDateTimeParser(expiresIn!);
  //   DateTime tokenExpiryTimeMinusOneMinute =
  //       tokenExpiryTime.subtract(Duration(minutes: 1));
  //   debugPrint("$tokenExpiryTime");
  //   debugPrint("$tokenExpiryTimeMinusOneMinute");
  //   if (isLoggedIn && DateTime.now().isAfter(tokenExpiryTimeMinusOneMinute)) {
  //     String? accessToken =
  //         await repository.getInSharedPreference(accessTokenKey);
  //     apiProvider.refreshToken(accessToken!).then((HTTPResponseModel value) {
  //       repository.storeInSharedPreference(
  //           accessTokenKey, value.data["access_token"]);
  //       repository.storeInSharedPreference(
  //           tokenTimestampKey, value.data["expires_in"]);
  //     });
  //   } else {
  //     checkTimerLogic();
  //   }

  //   _timer = Timer(Duration(seconds: 300), logOut);
  // }

  // logOut() async {
  //   bool isLoggedIn = await preferenceRepository.getBooleanPref(IS_LOGGED_IN);
  //   print(isLoggedIn);
  //   if (isLoggedIn) {
  //     Get.offAll(SignInScreen());
  //     accountBloc.logoutUser(showLoader: false);
  //     setLoginStatus(false);
  //     showAutoBiometricsOnLoginPage(false);
  //     CustomToastNotification.show("Idle Timeout", type: ToastType.error);
  //   }
  // }

  exitApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
