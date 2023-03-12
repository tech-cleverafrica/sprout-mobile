import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/authentication/view/sign_in_screen.dart';
import 'package:sprout_mobile/src/components/profile/service/profile_service.dart';
import 'package:sprout_mobile/src/public/screens/approval_page.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
}
