import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/constants.dart';
import '../repository/preference_repository.dart';

final PreferenceRepository preferenceRepository =
    Get.put(PreferenceRepository());

Future<List> initBiometricAuthentication(BuildContext context) async {
  LocalAuthentication localAuth = LocalAuthentication();
  try {
    bool authenticateWithBiometricsResponse = await localAuth.authenticate(
        localizedReason: "Authenticate biometric login");
    // useErrorDialogs: false,
    // stickyAuth: true

    final List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();

    // if (availableBiometrics.isNotEmpty) {
    //   // Some biometrics are enrolled.
    // }

    // if (availableBiometrics.contains(BiometricType.strong) ||
    //     availableBiometrics.contains(BiometricType.face)) {
    //   // Specific types of biometrics are available.
    //   // Use checks like this with caution!
    // }

    return [authenticateWithBiometricsResponse, null];
  } on PlatformException catch (e) {
    return [false, e.message];
  }
}

deleteGetxController<T>() {
  Get.delete<T>(force: true);
}

setLoginStatus(bool status) {
  preferenceRepository.setBooleanPref(IS_LOGGED_IN, status);
}

const currencySymbol = "₦";

showAutoBiometricsOnLoginPage(bool status) {
  preferenceRepository.setBooleanPref(SHOW_BIOMETRICS_ON_LOGINPAGE, status);
}

Future<List> checkAvailableBiometrics(BuildContext context) async {
  LocalAuthentication localAuth = LocalAuthentication();
  bool isFaceId = false;
  try {
    final List<BiometricType> availableBiometrics =
        await localAuth.getAvailableBiometrics();

    // if (availableBiometrics.isNotEmpty) {
    //   // Some biometrics are enrolled.
    // }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      isFaceId = true;
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }

    return [isFaceId];
  } on PlatformException catch (e) {
    return [false, e.message];
  }
}

Future<DateTime?> showRangeDatePicker() async {
  return await showDatePicker(
    context: Get.context!,
    initialDate:
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          // colorScheme: ColorScheme.light(
          //   primary:, // <-- SEE HERE
          //   onPrimary: AppColors.white, // <-- SEE HERE
          //   onSurface: AppColors.greyText, // <-- SEE HERE
          // ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: AppColors.mainGreen, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}