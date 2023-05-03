import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/save/model/savings_model.dart';
import 'package:sprout_mobile/src/components/save/service/savings_service.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';

class SavingsController extends GetxController {
  final storage = GetStorage();
  final AppFormatter formatter = Get.put(AppFormatter());
  RxList<Savings> savings = <Savings>[].obs;
  RxList<Savings> baseSavings = <Savings>[].obs;

  RxBool isSavingsLoading = false.obs;
  RxBool showMain = false.obs;
  RxBool showAmount = true.obs;
  RxString type = "".obs;
  RxBool isApproved = false.obs;
  RxBool inReview = false.obs;

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
    String approvalStatus = storage.read("approvalStatus");
    isApproved.value = approvalStatus == "APPROVED" ? true : false;
    inReview.value = approvalStatus == "IN_REVIEW" ? true : false;
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
      savings.assignAll(response.data!);
      baseSavings.assignAll(response.data!);
      print(savings[0].portfolioName);
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
