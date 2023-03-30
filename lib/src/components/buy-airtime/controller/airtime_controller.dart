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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';

class AirtimeController extends GetxController {
  final storage = GetStorage();
  List<Biller> baseBillers = <Biller>[];
  List<BillerPackage> basePackages = <BillerPackage>[];
  RxList<Biller> billers = <Biller>[].obs;
  RxList<BillerPackage> packages = <BillerPackage>[].obs;
  TextEditingController phoneNumberController = new TextEditingController();
  var amountController = Rxn<MoneyMaskedTextController>();
  var biller = Rxn<Biller>();
  var package = Rxn<BillerPackage>();

  double? userBalance;
  final AppFormatter formatter = Get.put(AppFormatter());

  RxBool loading = false.obs;
  RxBool canShowPackages = false.obs;

  @override
  void onInit() {
    getBillers();
    amountController.value = new MoneyMaskedTextController(
        initialValue: 0, decimalSeparator: ".", thousandSeparator: ",");
    userBalance = storage.read("userBalance");
    super.onInit();
  }

  getBillers() async {
    loading.value = true;
    AppResponse<List<Biller>> response =
        await locator.get<PayBillsService>().getBillers("airtime/biller");
    loading.value = false;
    if (response.status) {
      billers.assignAll(response.data);
      baseBillers.assignAll(response.data);
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

  getPackages() async {
    String route = "airtime/packages";
    AppResponse<List<BillerPackage>> response = await locator
        .get<PayBillsService>()
        .getPackages(buildRequestModel(), route, "Please wait");
    if (response.status) {
      canShowPackages.value = true;
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
            100000 &&
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
        double.parse(amountController.value!.text.split(",").join()) > 100000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Invalid amount"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.value!.text.split(",").join()) >
        double.parse(userBalance.toString().split(",").join())) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Amount is greater than wallet balance"),
          backgroundColor: AppColors.errorRed));
    } else if (double.parse(amountController.value!.text.split(",").join("")) >
        100000) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Maximum amount is 450,000"),
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
                                  if (packages[index].amount != null) {
                                    amountController.value =
                                        new MoneyMaskedTextController(
                                            initialValue: double.parse(
                                                packages[index]
                                                    .amount
                                                    .toString()),
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
