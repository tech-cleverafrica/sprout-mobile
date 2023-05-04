import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/save/model/saving_model.dart';
import 'package:sprout_mobile/src/components/save/model/savings_model.dart';
import 'package:sprout_mobile/src/components/save/service/savings_service.dart';
import 'package:sprout_mobile/src/components/save/view/savings_approval_screen.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';

class SavingsDetailsController extends GetxController {
  final storage = GetStorage();
  final AppFormatter formatter = Get.put(AppFormatter());

  // arguments
  var args;
  var savings = Rxn<Savings>();

  RxBool loading = false.obs;
  RxBool isChecked = false.obs;

  @override
  void onInit() {
    storage.remove("removeAll");
    super.onInit();
    args = Get.arguments;
    savings.value = args;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    storage.write('removeAll', "1");
    super.onClose();
  }

  Future createSavings(Map<String, dynamic> requestBody) async {
    AppResponse<dynamic> response =
        await locator.get<SavingsService>().createSavings(requestBody);
    if (response.status) {
      Saving saving = Saving.fromJson(response.data);
      Get.to(() => SavingsApprovalScreen(
            saving: saving,
          ));
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        createSavings(requestBody);
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future<dynamic> validateSavings() async {
    createSavings(buildTargetSavingsRequestModel());
    return null;
  }

  buildTargetSavingsRequestModel() {
    return {};
  }
}
