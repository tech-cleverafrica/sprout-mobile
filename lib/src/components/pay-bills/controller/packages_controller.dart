import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/controller/billers_controller.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_package_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/service/pay_bills_service.dart';
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

  Future<dynamic> lookupDisco(Map<String, dynamic> requestBody, String route,
      String loadingMessage) async {
    loading.value = true;
    AppResponse response = await locator
        .get<PayBillsService>()
        .lookup(requestBody, route, loadingMessage);
    loading.value = false;
    if (response.status) {
      return response;
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
      var response = await lookupDisco(
          buildDiscoLookupRequestModel(), route, "Please wait");
      return response;
    } else if (amountController.value!.text.isEmpty ||
        double.parse(amountController.value!.text.split(",").join()) == 0) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is required"),
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

  buildRequestModel() {
    return {"id": biller.value!.id, "slug": biller.value!.slug};
  }

  buildDiscoLookupRequestModel() {
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
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 17.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: Text(
                      "Select Package",
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
                  ListView.builder(
                      itemCount: packages.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                          child: GestureDetector(
                            onTap: () {
                              pop();
                              package.value = packages[index];
                              if (packages[index].amount != null) {
                                amountController.value =
                                    new MoneyMaskedTextController(
                                        initialValue: 200,
                                        decimalSeparator: ".",
                                        thousandSeparator: ",");
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      packages[index].name!,
                                      style: TextStyle(
                                          fontFamily: "DMSans",
                                          fontSize: 12.sp,
                                          fontWeight: package.value != null &&
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
                      }))
                ],
              )),
            ),
          );
        });
  }
}
