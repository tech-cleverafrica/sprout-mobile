import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/controller/billers_controller.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_package_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/service/pay_bills_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';

class PackagesController extends GetxController {
  final BillersController billersController = Get.put(BillersController());
  var amountController = Rxn<MoneyMaskedTextController>();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController beneficiaryNameController = new TextEditingController();
  TextEditingController digitController = new TextEditingController();

  // arguments
  Biller? args;
  var biller = Rxn<Biller>();

  RxList<BillerPackage> packages = <BillerPackage>[].obs;
  List<BillerPackage> basePackages = <BillerPackage>[];
  var package = Rxn<BillerPackage>();
  RxBool loading = false.obs;
  RxBool showField = false.obs;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    biller.value = args;
    amountController.value = new MoneyMaskedTextController(
        initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
    getPackages();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getPackages() async {
    loading.value = true;
    String route = buildRoute();
    AppResponse<List<BillerPackage>> response = await locator
        .get<PayBillsService>()
        .getPackages(buildRequestModel(), route, "Please wait");
    loading.value = false;
    if (response.status) {
      packages.assignAll(response.data!);
      basePackages.assignAll(response.data);
    }
  }

  Future<dynamic> lookup(Map<String, dynamic> requestBody, String route,
      String loadingMessage) async {
    loading.value = true;
    AppResponse response = await locator
        .get<PayBillsService>()
        .lookup(requestBody, route, loadingMessage);
    loading.value = false;
    if (response.status) {
      String x = amountController.value!.text.split(",").join();
      var minPayableAmount = double.parse(
          response.data["responseData"]["minPayableAmount"].toString());
      var inputAmount = double.parse(x);
      if (inputAmount < minPayableAmount) {
        CustomToastNotification.show(
            'Amount is less than minimum payable amount of ' +
                minPayableAmount.toString(),
            type: ToastType.error);
      } else {
        return response.data["responseData"];
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
    return null;
  }

  Future<dynamic> validateDisco() async {
    if (double.parse(amountController.value!.text.split(",").join()) > 0 &&
        double.parse(amountController.value!.text.split(",").join()) <=
            200000 &&
        phoneNumberController.text.length == 11 &&
        digitController.text.isNotEmpty) {
      String route = getLookupRoute();
      var response =
          await lookup(buildLookupRequestModel(), route, "Please wait");
      return response;
    } else if (amountController.value!.text.isEmpty ||
        double.parse(amountController.value!.text.split(",").join()) == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is required"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.value!.text.split(",").join()) <
            1 ||
        double.parse(amountController.value!.text.split(",").join()) > 200000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invalid amount"),
          backgroundColor: AppColors.errorRed));
    } else if (phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number is required"),
          backgroundColor: AppColors.errorRed));
    } else if (phoneNumberController.text.length < 11) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number must be 11 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (digitController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Meter number is required"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  Future<dynamic> validateCable() async {
    if ((double.parse(amountController.value!.text.split(",").join()) > 0 &&
            double.parse(amountController.value!.text.split(",").join()) <=
                200000 &&
            digitController.text.isNotEmpty &&
            biller.value!.slug != "SHOWMAX") ||
        (double.parse(amountController.value!.text.split(",").join()) > 0 &&
            double.parse(amountController.value!.text.split(",").join()) <=
                200000 &&
            beneficiaryNameController.text.isNotEmpty &&
            digitController.text.isNotEmpty &&
            biller.value!.slug == "SHOWMAX" &&
            beneficiaryNameController.text.isNotEmpty)) {
      if (biller.value!.slug == "SHOWMAX") {
        CustomLoader.show(message: "Please wait");
        await Future.delayed(
            Duration(microseconds: 2000),
            () => {
                  CustomLoader.dismiss(),
                });
        return true;
      } else {
        String route = getLookupRoute();
        var response =
            await lookup(buildLookupRequestModel(), route, "Please wait");
        return response;
      }
    } else if (amountController.value!.text.isEmpty ||
        double.parse(amountController.value!.text.split(",").join()) == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is required"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.value!.text.split(",").join()) <
            1 ||
        double.parse(amountController.value!.text.split(",").join()) > 200000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invalid amount"),
          backgroundColor: AppColors.errorRed));
    } else if (beneficiaryNameController.text.isEmpty &&
        biller.value!.slug == "SHOWMAX") {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Beneficiary name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (digitController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Smartcard number is required"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  Future<dynamic> validateData() async {
    if ((double.parse(amountController.value!.text.split(",").join()) > 0 &&
            double.parse(amountController.value!.text.split(",").join()) <=
                200000 &&
            digitController.text.isNotEmpty &&
            biller.value!.slug != "SPECTRANET") ||
        (double.parse(amountController.value!.text.split(",").join()) > 0 &&
            double.parse(amountController.value!.text.split(",").join()) <=
                200000 &&
            beneficiaryNameController.text.isNotEmpty &&
            digitController.text.isNotEmpty &&
            biller.value!.slug == "SPECTRANET" &&
            beneficiaryNameController.text.isNotEmpty)) {
      if (biller.value!.slug == "SPECTRANET") {
        CustomLoader.show(message: "Please wait");
        await Future.delayed(
            Duration(microseconds: 2000),
            () => {
                  CustomLoader.dismiss(),
                });
        return true;
      } else {
        String route = getLookupRoute();
        var response =
            await lookup(buildLookupRequestModel(), route, "Please wait");
        return response;
      }
    } else if (amountController.value!.text.isEmpty ||
        double.parse(amountController.value!.text.split(",").join()) == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is required"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.value!.text.split(",").join()) <
            1 ||
        double.parse(amountController.value!.text.split(",").join()) > 200000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invalid amount"),
          backgroundColor: AppColors.errorRed));
    } else if (beneficiaryNameController.text.isEmpty &&
        biller.value!.slug == "SPECTRANET") {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Beneficiary name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (digitController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number is required"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  Future<dynamic> validateBetting() async {
    if (double.parse(amountController.value!.text.split(",").join()) > 0 &&
        double.parse(amountController.value!.text.split(",").join()) <=
            200000 &&
        digitController.text.isNotEmpty) {
      String route = getLookupRoute();
      var response =
          await lookup(buildLookupRequestModel(), route, "Please wait");
      return response;
    } else if (amountController.value!.text.isEmpty ||
        double.parse(amountController.value!.text.split(",").join()) == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is required"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.value!.text.split(",").join()) <
            1 ||
        double.parse(amountController.value!.text.split(",").join()) > 200000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invalid amount"),
          backgroundColor: AppColors.errorRed));
    } else if (digitController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("User ID is required"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  filterPackages(String value) {
    packages.value = value == ""
        ? basePackages
        : basePackages
            .where((i) => i.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }

  String buildRoute() {
    switch (billersController.group) {
      case "ELECTRIC_DISCO":
        return "discos/packages";
      case "DISCO":
        return "discos/packages";
      case "PAID_TV":
        return "cables/packages";
      case "PAY_TV":
        return "cables/packages";
      case "AIRTIME_AND_DATA":
        return "data/packages";
      case "AIRTIME":
        return "airtime/packages";
      case "BETTING_AND_LOTTERY":
        return "bettings/packages";
      case "TRANSPORT_AND_TOLL_PAYMENT":
        return "utilitypayments/packages";
    }
    return "";
  }

  String getDigitKey() {
    switch (billersController.group) {
      case 'DISCO':
        return 'meterNumber';
      case 'ELECTRIC_DISCO':
        return 'meterNumber';
      case 'PAID_TV':
        return 'smartCardNumber';
      case 'PAY_TV':
        return 'smartCardNumber';
      case 'AIRTIME_AND_DATA':
        return 'phoneNumber';
      case 'AIRTIME':
        return 'phoneNumber';
      case 'BETTING_AND_LOTTERY':
        return 'accountNumber';
      case 'TRANSPORT_AND_TOLL_PAYMENT':
        return 'accountNumber';
    }
    return "";
  }

  String getLookupRoute() {
    switch (billersController.group) {
      case 'DISCO':
        return 'discos/customer-lookup';
      case 'ELECTRIC_DISCO':
        return 'discos/customer-lookup';
      case 'PAID_TV':
        return 'cables/customer-lookup';
      case 'PAY_TV':
        return 'cables/customer-lookup';
      case 'AIRTIME_AND_DATA':
        return 'data/customer-lookup';
      case 'AIRTIME':
        return 'airtime/customer-lookup';
      case 'BETTING_AND_LOTTERY':
        return 'bettings/customer-lookup';
      case 'TRANSPORT_AND_TOLL_PAYMENT':
        return 'utilitypayments/customer-lookup';
    }
    return "";
  }

  String getPaymentRoute() {
    switch (billersController.group) {
      case 'DISCO':
        return 'discos/mobile/purchase';
      case 'ELECTRIC_DISCO':
        return 'discos/mobile/purchase';
      case 'PAID_TV':
        return 'cables/mobile/purchase';
      case 'PAY_TV':
        return 'cables/mobile/purchase';
      case 'AIRTIME_AND_DATA':
        return 'data/mobile/purchase';
      case 'AIRTIME':
        return 'airtime/mobile/purchase';
      case 'BETTING_AND_LOTTERY':
        return 'bettings/mobile/purchase';
      case 'TRANSPORT_AND_TOLL_PAYMENT':
        return 'utilitypayments/mobile/purchase';
    }
    return "";
  }

  buildRequestModel() {
    return {"id": biller.value!.id, "slug": biller.value!.slug};
  }

  buildLookupRequestModel() {
    String digitKey = getDigitKey();
    return {
      digitKey: digitController.text,
      "billerSlug": biller.value!.slug,
      "productName": package.value!.slug,
    };
  }

  showPackages(context, isDarkMode) {
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
                    child: Column(children: [
                      SizedBox(
                        height: 17.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        child: Text(
                          billersController.group == "AIRTIME_AND_DATA"
                              ? "Select Bundle"
                              : "Select Package",
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode
                                  ? AppColors.mainGreen
                                  : AppColors.primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: packages.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  package.value = packages[index];
                                  showField.value = false;
                                  if (packages[index].amount != null) {
                                    amountController.value =
                                        new MoneyMaskedTextController(
                                            initialValue: double.parse(
                                                packages[index]
                                                    .amount
                                                    .toString()),
                                            decimalSeparator: ".",
                                            thousandSeparator: ",");
                                    showField.value = true;
                                  } else {
                                    amountController.value =
                                        new MoneyMaskedTextController(
                                            initialValue: 0,
                                            decimalSeparator: ".",
                                            thousandSeparator: ",");
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? AppColors.inputBackgroundColor
                                          : AppColors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 16.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          packages[index].name!,
                                          style: TextStyle(
                                              fontFamily: "DMSans",
                                              fontSize: 12.sp,
                                              fontWeight:
                                                  package.value != null &&
                                                          package.value?.id ==
                                                              packages[index].id
                                                      ? FontWeight.w700
                                                      : FontWeight.w600,
                                              color: isDarkMode
                                                  ? AppColors.mainGreen
                                                  : AppColors.primaryColor),
                                        ),
                                        package.value != null &&
                                                package.value?.id ==
                                                    packages[index].id
                                            ? SvgPicture.asset(
                                                AppSvg.mark_green,
                                                height: 20,
                                                color: isDarkMode
                                                    ? AppColors.mainGreen
                                                    : AppColors.primaryColor,
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })))
                ],
              )),
            ),
          );
        });
  }
}
