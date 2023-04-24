import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/api-setup/api_setup.dart';
import 'package:sprout_mobile/src/api/api_response.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';
import 'package:sprout_mobile/src/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class InvoiceDetailsController extends GetxController {
  var args;
  var invoice = Rxn<Invoice>();
  RxDouble amountDue = 0.0.obs;
  RxBool loading = false.obs;
  RxString screenStatus = "".obs;
  RxString status = "".obs;

  late InvoiceController invoiceController;

  late MoneyMaskedTextController amountController =
      new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");

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

  buildPaymentModel() {
    return {
      "amountPaid": amountController.text.split(",").join(),
      "invoiceID": invoice.value?.id,
    };
  }

  buildInvoiceEmailModel() {
    return {
      "invoiceID": invoice.value?.id,
      "message": "Dear " +
          invoice.value!.customer!.fullName! +
          ", \n\nAn invoice has been generated for you by Crossover.\n\nPlease click on the button below to view the invoice\n       \nBest regards,\nClever Digital Limited. \n      ",
      "subject": invoice.value?.note,
      "to": invoice.value?.customer?.email
    };
  }

  markInvoiceAsPaid() async {
    AppResponse<Invoice> response = await locator
        .get<InvoiceService>()
        .markInvoiceAsPaid(invoice.value!.id!);
    if (response.status) {
      invoice.value = Invoice.fromJson(response.data);
      setStatus();
      invoiceController.fetchUserInvoices(true);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        markInvoiceAsPaid();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  markInvoiceAsPartialPaid() async {
    AppResponse<Invoice> response = await locator
        .get<InvoiceService>()
        .markInvoiceAsPartialPaid(buildPaymentModel());
    if (response.status) {
      invoice.value = Invoice.fromJson(response.data);
      setStatus();
      computeAmountDue();
      invoiceController.fetchUserInvoices(true);
      pop();
      amountController = new MoneyMaskedTextController(
          initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        markInvoiceAsPartialPaid();
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
      invoiceController.fetchUserInvoices(true);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        markInvoiceAsPaid();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  sendInvoice() async {
    AppResponse response = await locator
        .get<InvoiceService>()
        .sendInvoice(buildInvoiceEmailModel());
    if (response.status) {
      CustomToastNotification.show(response.message, type: ToastType.success);
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        sendInvoice();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  setStatus() {
    if (invoice.value?.paymentStatus == "PAID") {
      status.value = "Mark as paid";
      screenStatus.value = "Paid";
    } else if (invoice.value?.paymentStatus == "PARTIAL_PAYMENT") {
      status.value = "Mark as partially paid";
      screenStatus.value = "Partially Paid";
    } else {
      status.value = "Mark as not paid";
      screenStatus.value = "Not Paid";
    }
  }

  validatePartialPayment() {
    if (double.parse(amountController.text.split(",").join()) > 0 &&
        double.parse(amountController.text.split(",").join()) <=
            amountDue.value) {
      markInvoiceAsPartialPaid();
    } else if (amountController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is required"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.text.split(",").join("")) == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount cannot be 0"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.text.split(",").join("")) >
        amountDue.value) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount cannot be more than amount due"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
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
                                    if (statuses[index] == "Mark as paid") {
                                      markInvoiceAsPaid();
                                    } else if (statuses[index] ==
                                        "Mark as partially paid") {
                                      showAmountUpdate(
                                          context, isDarkMode, theme);
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

  showAmountUpdate(context, isDarkMode, theme) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return Dialog(
            backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Input Amount Paid",
                              style: theme.textTheme.headline6,
                            ),
                            InkWell(
                                onTap: () => Get.back(),
                                child: SvgPicture.asset(
                                  AppSvg.cancel,
                                  height: 18.h,
                                ))
                          ],
                        ),
                        addVerticalSpace(10.h),
                        CustomTextFormField(
                          controller: amountController,
                          label: "Please enter amount ($currencySymbol)",
                          textInputType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Amount is required";
                            else if (double.parse(value.split(",").join("")) ==
                                0) {
                              return "Amount cannot be 0";
                            } else if (double.parse(value.split(",").join("")) >
                                amountDue.value) {
                              return "Amount cannot be more than amount due";
                            }
                            return null;
                          },
                        ),
                        addVerticalSpace(25.h),
                        CustomButton(
                          title: "Submit",
                          onTap: () => {
                            validatePartialPayment(),
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          );
        }));
  }
}
