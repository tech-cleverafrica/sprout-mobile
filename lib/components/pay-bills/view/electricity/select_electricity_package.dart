import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/pay-bills/controller/packages_controller.dart';
import 'package:sprout_mobile/components/pay-bills/view/bills_summary.dart';
import 'package:sprout_mobile/config/Config.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/global_function.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

import '../../../../public/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class SelectElectricityPackageScreen extends StatelessWidget {
  SelectElectricityPackageScreen({super.key});

  late PackagesController packagesController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    packagesController = Get.put(PackagesController());
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Continue",
              onTap: () {
                packagesController.validateDisco().then((value) => {
                      if (value != null)
                        {push(page: BillSummaryPage(), arguments: value)}
                    });
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeader(isDarkMode),
                  addVerticalSpace(15.h),
                  GestureDetector(
                    onTap: () =>
                        packagesController.showPackages(context, isDarkMode),
                    child: Obx(
                      () => CustomTextFormField(
                          label: "Select Package",
                          hintText: packagesController.package.value?.name ??
                              "Select Package",
                          required: true,
                          enabled: false,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          hintTextStyle:
                              packagesController.package.value == null
                                  ? null
                                  : TextStyle(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Obx((() => packagesController.package.value != null
                      ? CustomTextFormField(
                          controller: packagesController.amountController.value,
                          label: "Amount ($currencySymbol)",
                          hintText: "Enter Amount",
                          required: true,
                          enabled:
                              packagesController.package.value!.amount == null,
                          textInputType: TextInputType.phone,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Amount is required";
                            else if (double.parse(value.split(",").join("")) ==
                                0) {
                              return "Invalid amount";
                            } else if (double.parse(value.split(",").join("")) <
                                1) {
                              return "Invalid amount";
                            } else if (double.parse(value.split(",").join("")) >
                                MAXIMUM_DISCO_AMOUNT) {
                              return "Maximum amount is " +
                                  MAXIMUM_DISCO_AMOUNT_STRING;
                            }
                            return null;
                          },
                          onChanged: ((value) => {
                                if (double.parse(value.split(",").join("")) <
                                        1 ||
                                    double.parse(value.split(",").join("")) >
                                        MAXIMUM_DISCO_AMOUNT)
                                  {
                                    packagesController.showField.value = false,
                                  }
                                else
                                  {
                                    packagesController.showField.value = true,
                                  }
                              }),
                        )
                      : SizedBox())),
                  Obx((() => packagesController.showField.value
                      ? CustomTextFormField(
                          controller: packagesController.phoneNumberController,
                          label: "Phone Number",
                          hintText: "Enter Phone Number",
                          required: true,
                          maxLength: 11,
                          showCounterText: false,
                          maxLengthEnforced: true,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[0-9]*$'))
                          ],
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.phone,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Phone number is required";
                            else if (value.length < 11)
                              return "Phone number should be 11 digits";
                            return null;
                          })
                      : SizedBox())),
                  Obx((() => packagesController.showField.value
                      ? CustomTextFormField(
                          controller: packagesController.digitController,
                          label: "Meter Number",
                          hintText: "Enter Meter Number",
                          required: true,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[0-9]*$'))
                          ],
                          textInputAction: TextInputAction.go,
                          textInputType: TextInputType.phone,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Meter Number is required";
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            packagesController.validateDisco();
                          })
                      : SizedBox())),
                ],
              ),
            ),
          )),
    );
  }
}
