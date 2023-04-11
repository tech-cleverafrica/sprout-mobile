import 'dart:developer';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/components/authentication/model/request_model.dart';
import 'package:sprout_mobile/src/components/authentication/model/response_model.dart';
import 'package:sprout_mobile/src/repository/preference_repository.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/constants.dart';
import 'package:device_information/device_information.dart';
import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';
import '../../../app.dart';
import '../../../public/widgets/custom_toast_notification.dart';
import '../../../reources/db_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/global_function.dart';
import '../../../utils/nav_function.dart';
import '../../home/view/bottom_nav.dart';
import '../service/auth_service.dart';

class SignInController extends GetxController {
  final storage = GetStorage();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  RxBool isFingerPrintEnabled = false.obs;
  DBProvider sharePreference = DBProvider();
  RxString fullname = "".obs;
  SignInRequestModel signInRequestModel =
      SignInRequestModel.login(username: "", password: "", agentDeviceId: '');
  bool isFaceId = false;
  bool hasBiometrics = false;
  late String platformVersion, modelName = '', manufacturer = '', deviceId = '';

  final PreferenceRepository preferenceRepository =
      Get.put(PreferenceRepository());
  final App app = Get.put(App());

  @override
  void onInit() async {
    checkIsFingerPrintEnabled();
    emailController.text =
        await preferenceRepository.getStringPref("storedMail");
    _checkBiometricType();
    initPlatformState();
    fullname.value = StringUtils.capitalize(storage.read("firstname") ?? "");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void initBiometricLogin(List isAuthenticated) async {
    if (isAuthenticated[0] == true) {
      String? username =
          await sharePreference.getInSharedPreference(SECURED_USER_MAIL);
      String? password =
          await sharePreference.getInSharedPreference(SECURED_PASSWORD);

      if (username != null && password != null) {
        debugPrint(username);
        debugPrint(password);
        signIn(buildRequestModel(username, password));
      } else {
        CustomToastNotification.show(
            "Please sign in with password at least  once",
            type: ToastType.error);
      }
    } else {
      CustomToastNotification.show("Biometric authentication cancelled",
          type: ToastType.error);
    }
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail,
    // so we use a try/catch PlatformException.
    try {
      platformVersion = await DeviceInformation.platformVersion;

      modelName = await DeviceInformation.deviceModel;
      manufacturer = await DeviceInformation.deviceManufacturer;
      deviceId = await DeviceInformation.deviceIMEINumber;
    } on PlatformException catch (e) {
      platformVersion = '${e.message}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    platformVersion = "Running on :$platformVersion";
    modelName = "$modelName-$manufacturer";
    manufacturer = manufacturer;
    log("Model Name is :::$modelName");
    log("Device name is :::$manufacturer");
  }

  Widget getBiometricIcon(bool isDark) {
    if (isFingerPrintEnabled.value && !Platform.isIOS) {
      return InkWell(
        highlightColor: AppColors.white,
        onTap: _initBiometricAuthentication,
        child: Container(
          height: 50.h,
          child: Image.asset(
            AppImages.biometric,
            color: isDark ? AppColors.white : AppColors.black,
          ),
        ),
      );
    } else if (isFingerPrintEnabled.value && Platform.isIOS) {
      return InkWell(
        highlightColor: AppColors.white,
        onTap: _initBiometricAuthentication,
        child: Container(
          height: 50.h,
          padding: EdgeInsets.all(10),
          child: Image.asset(
            "assets/images/faceId.png",
            color: isDark ? AppColors.white : AppColors.black,
          ),
        ),
      );
    }
    return Container();
  }

  void checkIsFingerPrintEnabled() async {
    bool? isEnabled = await sharePreference
        .getBooleanStoredInSharedPreference(useBiometricAuth);
    isFingerPrintEnabled.value = isEnabled == null ? false : isEnabled;
    bool isLoggedIn = await preferenceRepository.getBooleanPref(IS_LOGGED_IN);
    if (!isLoggedIn) {
      autoBiometrics();
    }
  }

  Future _initBiometricAuthentication() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List isAuthenticated = await initBiometricAuthentication(Get.context!);
      initBiometricLogin(isAuthenticated);
    });
  }

  Future _checkBiometricType() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List isAuthenticated = await checkAvailableBiometrics(Get.context!);
      print("WAHALA 2222");
      print(isAuthenticated);
      isFaceId = await isAuthenticated[0];
    });
  }

  autoBiometrics() async {
    bool autoShowBiometrics = await preferenceRepository
        .getBooleanPrefPositive(SHOW_BIOMETRICS_ON_LOGINPAGE);
    if (isFingerPrintEnabled.value && autoShowBiometrics) {
      _initBiometricAuthentication();
    }
  }

  saveLoginDetailsToSharePref(model) {
    preferenceRepository.setStringPref(SECURED_USER_MAIL, model["username"]);
    preferenceRepository.setStringPref(SECURED_PASSWORD, model["password"]);
  }

  onUsernameChanged(String? val) => signInRequestModel.username = val;
  onPasswordChanged(String? val) => signInRequestModel.password = val;

  buildRequestModel(username, password) {
    return {"username": username, "password": password};
  }

  validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please fill all empty fields"),
          backgroundColor: AppColors.errorRed));
    } else {
      signIn(buildRequestModel(emailController.text, passwordController.text));
    }
  }

  signIn(Map<String, dynamic> model) async {
    AppResponse<SignInResponseModel> response =
        await locator.get<AuthService>().signIn(model);
    if (response.status) {
      saveLoginDetailsToSharePref(model);
      preferenceRepository.setStringPref("storedMail", model['username']);
      setLoginStatus(true);
      getUserInfo();
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  getUserInfo() async {
    AppResponse response = await locator.get<AuthService>().getUserDetails();
    if (response.status) {
      setLoginStatus(true);
      pushUntil(page: BottomNav());
      CustomToastNotification.show(response.message, type: ToastType.success);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
