import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_in_screen.dart';
import 'package:sprout_mobile/src/components/profile/service/profile_service.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class ProfileController extends GetxController {
  final storage = GetStorage();
  RxString email = "".obs;
  RxString fullname = "".obs;
  RxString accountNumber = "".obs;
  RxString providusAccountNumber = "".obs;
  RxString wemaAccountNumber = "".obs;
  RxString accountNumberToUse = "".obs;
  RxString bankToUse = "".obs;
  RxString agentId = "".obs;
  RxString profileImage = "".obs;
  final picker = ImagePicker();
  late File profilePicture;
  RxBool uploadingProfilePicture = false.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = StringUtils.capitalize(storage.read("email") ?? "");
    fullname.value = inCaps(storage.read("firstname")) +
        " " +
        inCaps(storage.read("lastname"));
    accountNumber.value = storage.read("accountNumber") ?? "";
    providusAccountNumber.value = storage.read("providusAccount") ?? "";
    wemaAccountNumber.value = storage.read("wemaAccount") ?? "";
    bankToUse.value =
        providusAccountNumber.isEmpty ? "Wema Bank" : "Providus Bank";
    accountNumberToUse.value = providusAccountNumber.value.isEmpty
        ? wemaAccountNumber.value
        : providusAccountNumber.value;
    agentId.value = storage.read("agentId") ?? "";
    profileImage.value = storage.read("profilePicture") ?? "";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String inCaps(String str) {
    return str.length > 0 ? '${str[0].toUpperCase()}${str.substring(1)}' : '';
  }

  logout() async {
    AppResponse response =
        await locator.get<ProfileService>().logout({}, "Please wait");
    if (response.status) {
      setLoginStatus(false);
      showAutoBiometricsOnLoginPage(false);
      pushUntil(page: SignInScreen());
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  uploadAndCommit() async {
    uploadingProfilePicture.value = true;
    AppResponse response = await locator
        .get<SharedService>()
        .uploadAndCommit(profilePicture, "profilePicture", "Please wait");
    if (response.status) {
      uploadProfilePicture(response.data["data"]);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  uploadProfilePicture(String url) async {
    AppResponse response = await locator
        .get<ProfileService>()
        .updateProfilePicture(buildRequestModel(url));
    uploadingProfilePicture.value = false;
    if (response.status) {
      profileImage.value = url;
      storage.write('profilePicture', url);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  buildRequestModel(url) {
    return {"profilePicture": url};
  }
}
