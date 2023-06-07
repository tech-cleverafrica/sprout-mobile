import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/save/model/savings_model.dart';
import 'package:sprout_mobile/components/save/service/savings_service.dart';
import 'package:sprout_mobile/utils/app_formatter.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';

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
  RxDouble total = 0.0.obs;

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
      savings.assignAll(response.data!);
      baseSavings.assignAll(response.data!);
      computeTotal();
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        fetchPlans(refresh);
      }
    }
  }

  computeTotal() {
    num currentAmount = 0;
    num interestAccrued = 0;
    baseSavings.forEach((e) {
      currentAmount += e.currentAmount!;
      interestAccrued += e.interestAccrued!;
    });
    total.value = (currentAmount + interestAccrued).toDouble();
  }

  Future<void> refreshData() async {
    try {
      fetchPlans(true);
    } catch (err) {
      rethrow;
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
