import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/help/model/catergories_model.dart';
import 'package:sprout_mobile/src/components/help/model/issues_model.dart';
import 'package:sprout_mobile/src/components/help/model/overview_model.dart';
import 'package:sprout_mobile/src/components/help/service/help_service.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class HelpController extends GetxController {
  final storage = GetStorage();
  final ScrollController scrollController = new ScrollController();
  RxInt currentIndex = 0.obs;
  RxInt size = 15.obs;
  RxBool loading = false.obs;
  RxBool categoriesLoading = false.obs;
  RxBool pendingIssuesLoading = false.obs;
  RxBool resolvedIssuesLoading = false.obs;
  RxString status = "".obs;
  RxList<Categories> categories = <Categories>[].obs;
  var overview = {};
  RxString pending = "".obs;
  RxString resolved = "".obs;
  RxList<Issues> pendingIssues = <Issues>[].obs;
  RxList<Issues> resolvedIssues = <Issues>[].obs;
  String name = "";

  RxString uploadBillText = "Upload your preferred Utility Bill".obs;
  RxString uploadIdText = "Upload your preferred ID".obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        size.value = size.value + 10;
        if (status.value == 'PENDING') {
          getPendingIssues();
        } else {
          getIssues();
        }
      }
    });
    name = storage.read("firstname");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  validate() {}

  Future getCategories() async {
    categoriesLoading.value = true;
    AppResponse<List<Categories>> response =
        await locator.get<HelpService>().getCategories();
    categoriesLoading.value = false;
    if (response.status) {
      categories.assignAll(response.data!);
      getOverview();
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
      pop();
    }
  }

  Future getOverview() async {
    AppResponse<Overview> response =
        await locator.get<HelpService>().getOverview();
    if (response.status) {
      pending.value =
          (response.data!.data!.total! - response.data!.data!.resolved!)
              .toString();
      resolved.value = response.data!.data!.resolved!.toString();
    }
  }

  Future<void> getIssues() async {
    AppResponse<List<Issues>> response =
        await locator.get<HelpService>().getIssues(size.value, status.value);
    pendingIssuesLoading.value = false;
    resolvedIssuesLoading.value = false;
    resolvedIssues.clear();
    if (response.status) {
      print(response.data);
      resolvedIssues.assignAll(response.data!);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future<void> getPendingIssues() async {
    AppResponse<List<Issues>> response =
        await locator.get<HelpService>().getPendingIssues(size.value);
    pendingIssuesLoading.value = false;
    resolvedIssuesLoading.value = false;
    pendingIssues.clear();
    if (response.status) {
      print(response.data);
      pendingIssues.assignAll(response.data!);
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future uploadAndCommit(File? image, String fileType) async {}

  void processIdUpload(File file) {}

  void processUtilityUpload(File file) {}

  Future<void> submitIssue(issue) async {}

  buildRequestModel(bvn, identityCard, utilityBill) {
    return {
      "bvn": bvn,
      "identityCard": identityCard,
      "utilityBill": utilityBill
    };
  }

  DateTime localDate(String date) {
    return DateTime.parse(date).toLocal();
  }

  var oCcy = new NumberFormat("#,##0.00", "en_US");

  String inCaps(String str) {
    return str.length > 0 ? '${str[0].toUpperCase()}${str.substring(1)}' : '';
  }

  String toHrMin(var sla) {
    String response = locator.get<SharedService>().toHrMin(sla);
    return response;
  }
}
