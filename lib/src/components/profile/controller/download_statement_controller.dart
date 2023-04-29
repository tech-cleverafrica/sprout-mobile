import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/home/service/home_service.dart';
import 'package:sprout_mobile/src/public/screens/approval_page.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class DownloadStatementController extends GetxController {
  final storage = GetStorage();
  TextEditingController startDateController = new TextEditingController();
  TextEditingController endDateController = new TextEditingController();
  RxString startDate = "YYYY / MM / DAY".obs;
  RxString endDate = "YYYY / MM / DAY".obs;
  DateTime? pickedStartDate;
  DateTime? pickedEndDate;

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
    storage.write('removeAll', "1");
    super.onClose();
  }

  selectStartDate() async {
    pickedStartDate = await showRangeDatePicker(lastDate: pickedEndDate);
    if (pickedStartDate != null) {
      startDate.value = DateFormat('yyyy-MM-dd').format(pickedStartDate!);
    }
  }

  selectEndDate() async {
    pickedEndDate = await showRangeDatePicker(
        firstDate: pickedStartDate, initialDate: pickedEndDate);
    if (pickedEndDate != null) {
      endDate.value = DateFormat('yyyy-MM-dd').format(pickedEndDate!);
    }
  }

  validate() {
    if (startDate.value != "YYYY / MM / DAY" &&
        endDate.value != "YYYY / MM / DAY") {
      downloadStatement();
    } else if (startDate.value == "YYYY / MM / DAY") {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Start Date is required"),
          backgroundColor: AppColors.errorRed));
    } else if (endDate.value == "YYYY / MM / DAY") {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("End Date is required"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  downloadStatement() async {
    String userId = storage.read("userId");
    String filters =
        '?startDate=${pickedStartDate?.toIso8601String()}&endDate=${pickedStartDate?.toIso8601String()}&userID=$userId';
    AppResponse response =
        await locator.get<HomeService>().downloadTransactionRecords(filters);
    if (response.status) {
      pushUntil(
          page: ApprovalScreen(
        containShare: false,
        heading: "Successful",
        messages: response.message,
      ));
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        downloadStatement();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }
}
