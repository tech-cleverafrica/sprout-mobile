import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class InvoiceDetailsController extends GetxController {
  var args;
  var invoice = Rxn<Invoice>();
  RxDouble amountDue = 0.0.obs;
  RxBool loading = false.obs;
  RxString screenStatus = "".obs;
  RxString status = "".obs;

  late InvoiceController invoiceController;

  List<String> statuses = [
    "Mark as paid",
    "Mark as partially paid",
    "Mark as not paid"
  ];

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    invoice.value = args;
    computeAmountDue();
    setStatus();
    invoiceController = Get.put(InvoiceController());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  computeAmountDue() {
    double amount = 0.0;
    for (int i = 0; i < invoice.value!.paymentHistory!.length; i++) {
      amount = amount +
          double.parse(invoice.value!.paymentHistory![i].amount.toString());
    }
    amountDue.value = invoice.value!.total! - amount;
  }

  markInvoiceAsPaid() async {
    AppResponse<Invoice> response = await locator
        .get<InvoiceService>()
        .markInvoiceAsPaid(invoice.value!.id!);
    if (response.status) {
      invoice.value = Invoice.fromJson(response.data);
      setStatus();
      invoiceController.fetchUserInvoices();
    } else if (response.statusCode == 999) {
      AppResponse res = await locator<AuthService>().refreshUserToken();
      if (res.status) {
        markInvoiceAsPaid();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  markInvoiceAsNotPaid() async {
    AppResponse<Invoice> response = await locator
        .get<InvoiceService>()
        .markInvoiceAsNotPaid(invoice.value!.id!);
    if (response.status) {
      invoice.value = Invoice.fromJson(response.data);
      setStatus();
      invoiceController.fetchUserInvoices();
    } else if (response.statusCode == 999) {
      AppResponse res = await locator<AuthService>().refreshUserToken();
      if (res.status) {
        markInvoiceAsPaid();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  setStatus() {
    if (invoice.value?.paymentStatus == "PAID") {
      status.value = "Mark as paid";
      screenStatus.value = "Paid";
    } else if (invoice.value?.paymentStatus == "PAID") {
      status.value = "Mark as partially paid";
      screenStatus.value = "Partially Paid";
    } else {
      status.value = "Mark as not paid";
      screenStatus.value = "Not Paid";
    }
  }

  showStatusList(context, isDarkMode) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
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
                                  fontFamily: "DMSans",
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
                                    if (statuses[index] == "Mark as paid") {
                                      markInvoiceAsPaid();
                                    } else if (statuses[index] ==
                                        "Mark as partially paid") {
                                      print("Partial Paid action");
                                    } else {
                                      markInvoiceAsNotPaid();
                                    }
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
                                                          fontFamily: "DMSans",
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
}
