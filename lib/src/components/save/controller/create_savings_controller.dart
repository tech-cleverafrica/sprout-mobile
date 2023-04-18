import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/save/service/savings_service.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';

class CreateSavingsController extends GetxController {
  final AppFormatter formatter = Get.put(AppFormatter());
  RxList<dynamic> rates = <dynamic>[].obs;

  @override
  void onInit() {
    fetchRateOptions();
    super.onInit();
  }

  fetchRateOptions() async {
    AppResponse response = await locator.get<SavingsService>().getRateOptions();
    if (response.status) {
      print(response.data);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator<AuthService>().refreshUserToken();
      if (res.status) {
        fetchRateOptions();
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
