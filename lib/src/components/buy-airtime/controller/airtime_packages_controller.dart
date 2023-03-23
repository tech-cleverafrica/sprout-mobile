import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/model/biller_package_model.dart';
import 'package:sprout_mobile/src/components/pay-bills/service/pay_bills_service.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_formatter.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';

class AirtimePackagesController extends GetxController {
  final storage = GetStorage();
  var amountController = Rxn<MoneyMaskedTextController>();
  TextEditingController phoneNumberController = new TextEditingController();

  // arguments
  Biller? args;
  double? value;
  var biller = Rxn<Biller>();

  RxList<BillerPackage> packages = <BillerPackage>[].obs;
  List<BillerPackage> basePackages = <BillerPackage>[];
  var package = Rxn<BillerPackage>();
  RxBool loading = false.obs;
  RxBool showField = false.obs;
  double? userBalance;
  final AppFormatter formatter = Get.put(AppFormatter());

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments["biller"];
    value = Get.arguments["amount"];
    biller.value = args;
    amountController.value = new MoneyMaskedTextController(
        initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
    userBalance = storage.read("userBalance");
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
    String route = "airtime/packages";
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

  Future<dynamic> validateAirtime() async {
    if (double.parse(amountController.value!.text.split(",").join()) > 0 &&
        double.parse(amountController.value!.text.split(",").join()) <=
            200000 &&
        phoneNumberController.text.length == 11) {
      String route = "airtime/customer-lookup";
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
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("All fields are required"),
          backgroundColor: AppColors.errorRed));
    }
    return null;
  }

  buildRequestModel() {
    return {"id": biller.value!.id, "slug": biller.value!.slug};
  }

  buildLookupRequestModel() {
    return {
      "phoneNumber": phoneNumberController.text,
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
                                            initialValue: value ?? 0,
                                            decimalSeparator: ".",
                                            thousandSeparator: ",");
                                    if (value != 0) {
                                      showField.value = true;
                                    }
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
