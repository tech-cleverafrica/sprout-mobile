import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_detail_model.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/public/model/date_range.dart';
import 'package:sprout_mobile/src/public/services/date_service.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api-setup/api_setup.dart';

class PaymentLinkController extends GetxController {
  final AppFormatter formatter = Get.put(AppFormatter());
  TextEditingController searchController = new TextEditingController();

  TextEditingController updateCustomerNameController =
      new TextEditingController();
  TextEditingController updateCustomerPhoneController =
      new TextEditingController();
  TextEditingController updateCustomerEmailController =
      new TextEditingController();
  TextEditingController updateCustomerAddressController =
      new TextEditingController();

  RxList<InvoiceRespose> paymentLinksResponse = <InvoiceRespose>[].obs;
  RxList<Invoice> paymentLinks = <Invoice>[].obs;
  RxList<Invoice> basePaymentLinks = <Invoice>[].obs;

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
  String statusFilter = "all";
  Map<String, dynamic> timeFilter = {"startDate": null, "endDate": null};

  @override
  void onInit() {
    super.onInit();
    Invoice none = Invoice(
      id: "",
      invoiceNo: "12345",
      userID: "123rt",
      businessInfo: null,
      customer: null,
      customerID: "",
      invoiceContent: null,
      dueDate: "",
      invoiceDate: "",
      note: "",
      paymentAccountNumber: "",
      tax: 100,
      discount: 100,
      subTotal: 100,
      total: 100,
      partialPaidAmount: 100,
      paymentHistory: null,
      paymentStatus: "PAID",
      invoicePDFUrl: "sjsjsjsjs",
      downloaded: true,
      createdAt: "2021-10-12T17:57:51+0000",
      updatedAt: "2021-10-12T17:57:51+0000",
      expired: false,
    );
    paymentLinks.add(none);
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
                                      statusFilter = "all";
                                    } else if (statuses[index] ==
                                        "Partial Payment") {
                                      statusFilter = "PARTIAL_PAYMENT";
                                    } else if (statuses[index] == "Paid") {
                                      statusFilter = "PAID";
                                    } else if (statuses[index] == "Not Paid") {
                                      statusFilter = "NOT_PAID";
                                    }
                                    // fetchUserInvoices(true);
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
                                    // fetchUserInvoices(true);
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
