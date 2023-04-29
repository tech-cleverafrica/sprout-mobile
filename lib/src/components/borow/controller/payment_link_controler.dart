import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/borow/model/payment_link_model.dart';
import 'package:sprout_mobile/src/components/borow/service/borrow_service.dart';
import 'package:sprout_mobile/src/components/borow/view/success_payment_link.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_detail_model.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/public/model/date_range.dart';
import 'package:sprout_mobile/src/public/services/date_service.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api-setup/api_setup.dart';

class PaymentLinkController extends GetxController {
  final storage = GetStorage();
  final AppFormatter formatter = Get.put(AppFormatter());
  TextEditingController searchController = new TextEditingController();

  late MoneyMaskedTextController amountController =
      new MoneyMaskedTextController();
  TextEditingController paymentNameController = new TextEditingController();
  TextEditingController paymentDescriptionController =
      new TextEditingController();

  RxList<PaymentLink> paymentLinks = <PaymentLink>[].obs;
  RxList<PaymentLink> basePaymentLinks = <PaymentLink>[].obs;

  InvoiceDetail? invoiceDetail;
  RxBool isPaymentLinksLoading = false.obs;
  RxBool showMain = false.obs;

  List<String> statuses = ["All", "Paid", "Not Paid"];
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
  String statusFilter = "";
  Map<String, dynamic> timeFilter = {"startDate": null, "endDate": null};
  RxString errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    amountController = formatter.getMoneyController();
    fetchPaymentLinks(false);
  }

  fetchPaymentLinks(bool refresh) async {
    reset();
    if (!refresh) {
      isPaymentLinksLoading.value = true;
    }
    AppResponse<List<PaymentLink>> response = await locator
        .get<BorrowService>()
        .getPaymentLinks(statusFilter, timeFilter);
    isPaymentLinksLoading.value = false;
    if (response.status) {
      paymentLinks.assignAll(response.data!);
      basePaymentLinks.assignAll(response.data!);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        fetchPaymentLinks(refresh);
      }
    }
  }

  createPaymentLink() async {
    AppResponse<dynamic> response =
        await locator.get<BorrowService>().createPaymentLink(buildRequest());
    if (response.status) {
      print(response.data);
      pushUntil(page: SuccessfulPaymentLink(), arguments: {
        "name": paymentNameController.text,
        "data": response.data
      });
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        createPaymentLink();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  filterPaymentLinks(String value) {
    paymentLinks.value = value == ""
        ? basePaymentLinks
        : basePaymentLinks
            .where((i) =>
                i.fullName!.toLowerCase().contains(value.toLowerCase()) ||
                i.description!.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }

  reset() {
    searchController = new TextEditingController(text: "");
    paymentLinks.value = basePaymentLinks;
  }

  validate() {
    if (double.parse(amountController.text.split(",").join()) >= 10 &&
        paymentNameController.text.length > 2 &&
        paymentDescriptionController.text.length > 5) {
      createPaymentLink();
    } else if (double.parse(amountController.text.split(",").join("")) == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid amount"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.text.split(",").join("")) < 10) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is too small"),
          backgroundColor: AppColors.errorRed));
    } else if (paymentNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Payment name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (paymentNameController.text.length < 3) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Payment name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (paymentDescriptionController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Payment description is required"),
          backgroundColor: AppColors.errorRed));
    } else if (paymentDescriptionController.text.length < 6) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Payment description is too short"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  buildRequest() {
    String email = storage.read("email");
    return {
      "amount": amountController.text.split(",").join(),
      "currency": "NGN",
      "name": paymentNameController.text,
      "email": email,
      "description": paymentDescriptionController.text,
    };
  }

  showStatusList(context, isDarkMode, theme) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.greyDot : AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 17.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 20.w),
                            child: Text(
                              "Select Status",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: statuses.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                  onTap: () {
                                    pop();
                                    status.value = statuses[index];
                                    if (statuses[index] == "All") {
                                      statusFilter = "";
                                    } else if (statuses[index] == "Paid") {
                                      statusFilter = "true";
                                    } else if (statuses[index] == "Not Paid") {
                                      statusFilter = "false";
                                    }
                                    fetchPaymentLinks(true);
                                  },
                                  child: Obx((() => Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode
                                                ? AppColors.inputBackgroundColor
                                                : AppColors.grey,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 16.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      statuses[index],
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontSize: 12.sp,
                                                          fontWeight: status
                                                                          .value !=
                                                                      "" &&
                                                                  status.value ==
                                                                      statuses[
                                                                          index]
                                                              ? FontWeight.w700
                                                              : FontWeight.w600,
                                                          color: isDarkMode
                                                              ? AppColors
                                                                  .mainGreen
                                                              : AppColors
                                                                  .primaryColor),
                                                    ),
                                                  ],
                                                ),
                                                status.value != "" &&
                                                        status.value ==
                                                            statuses[index]
                                                    ? SvgPicture.asset(
                                                        AppSvg.mark_green,
                                                        height: 20,
                                                        color: isDarkMode
                                                            ? AppColors
                                                                .mainGreen
                                                            : AppColors
                                                                .primaryColor,
                                                      )
                                                    : SizedBox()
                                              ],
                                            )),
                                      )))),
                            );
                          }))),
                ],
              )),
            ),
          );
        });
  }

  showTimeList(context, isDarkMode, theme) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.greyDot : AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 17.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 20.w),
                            child: Text(
                              "Select Period",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: times.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                  onTap: () {
                                    pop();
                                    time.value = times[index];
                                    if (times[index] != "All Time") {
                                      DateRange dateFilter = locator
                                          .get<DateService>()
                                          .dateRangeFormatter(times[index]);
                                      timeFilter = {
                                        "startDate": dateFilter.startDate,
                                        "endDate": dateFilter.endDate
                                      };
                                    } else {
                                      timeFilter = {
                                        "startDate": null,
                                        "endDate": null
                                      };
                                    }
                                    fetchPaymentLinks(true);
                                  },
                                  child: Obx((() => Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode
                                                ? AppColors.inputBackgroundColor
                                                : AppColors.grey,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 16.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      times[index],
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontSize: 12.sp,
                                                          fontWeight: time.value !=
                                                                      "" &&
                                                                  time.value ==
                                                                      times[
                                                                          index]
                                                              ? FontWeight.w700
                                                              : FontWeight.w600,
                                                          color: isDarkMode
                                                              ? AppColors
                                                                  .mainGreen
                                                              : AppColors
                                                                  .primaryColor),
                                                    ),
                                                  ],
                                                ),
                                                time.value != "" &&
                                                        time.value ==
                                                            times[index]
                                                    ? SvgPicture.asset(
                                                        AppSvg.mark_green,
                                                        height: 20,
                                                        color: isDarkMode
                                                            ? AppColors
                                                                .mainGreen
                                                            : AppColors
                                                                .primaryColor,
                                                      )
                                                    : SizedBox()
                                              ],
                                            )),
                                      )))),
                            );
                          }))),
                ],
              )),
            ),
          );
        });
  }

  Future share(String text) async {
    try {
      await locator.get<SharedService>().shareText(text);
    } catch (e) {
      print(e);
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
