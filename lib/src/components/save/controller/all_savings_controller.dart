import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/save/model/savings_model.dart';
import 'package:sprout_mobile/src/components/save/service/savings_service.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';

class AllSavingsController extends GetxController {
  final storage = GetStorage();
  final AppFormatter formatter = Get.put(AppFormatter());
  TextEditingController searchController = new TextEditingController();
  RxList<Savings> savings = <Savings>[].obs;
  RxList<Savings> baseSavings = <Savings>[].obs;

  RxBool isSavingsLoading = false.obs;

  @override
  void onInit() {
    fetchPlans(false);
    super.onInit();
    storage.remove("removeAll");
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
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        fetchPlans(refresh);
      }
    }
  }

  filterSavings(String value) {
    savings.value = value == ""
        ? baseSavings
        : baseSavings
            .where((i) =>
                i.portfolioName!.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }

  reset() {
    searchController = new TextEditingController(text: "");
    savings.value = baseSavings;
  }

  setVisibility(String id) {
    List<Savings> newSavings = [];
    for (int i = 0; i < savings.length; i++) {
      if (savings[i].id == id) {
        savings[i].visible = !savings[i].visible!;
        newSavings.add(savings[i]);
      } else {
        newSavings.add(savings[i]);
      }
    }
    savings.value = newSavings;
    List<Savings> newBaseSavings = [];
    for (int i = 0; i < baseSavings.length; i++) {
      if (baseSavings[i].id == id) {
        baseSavings[i].visible = !baseSavings[i].visible!;
        newBaseSavings.add(baseSavings[i]);
      } else {
        newBaseSavings.add(baseSavings[i]);
      }
    }
    baseSavings.value = newBaseSavings;
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
}
