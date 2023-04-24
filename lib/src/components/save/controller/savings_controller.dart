import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/save/service/savings_service.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';

class SavingsController extends GetxController {
  final AppFormatter formatter = Get.put(AppFormatter());
  RxList<dynamic> savings = <dynamic>[].obs;
  RxList<dynamic> baseSavings = <dynamic>[].obs;

  RxBool isSavingsLoading = false.obs;
  RxBool showMain = false.obs;
  RxBool showAmount = true.obs;
  RxString type = "".obs;

  List<String> statuses = ["All", "Partial Payment", "Paid", "Not Paid"];
  List<String> times = [
    "All Time",
    "Today",
    "Yesterday",
    "This week",
    "Last week",
    "This month",
    "Last month"
  ];
  RxString status = "All".obs;
  RxString time = "All Time".obs;
  String statusFilter = "all";
  Map<String, dynamic> timeFilter = {"startDate": null, "endDate": null};

  @override
  void onInit() {
    fetchPlans(false);
    super.onInit();
  }

  fetchPlans(bool refresh) async {
    if (!refresh) {
      isSavingsLoading.value = true;
    }
    AppResponse response = await locator.get<SavingsService>().getPlans();
    isSavingsLoading.value = false;
    if (response.status) {
      print(response.data);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        fetchPlans(refresh);
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
