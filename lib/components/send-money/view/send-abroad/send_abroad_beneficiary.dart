import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/send-money/controller/send_abroad_controller.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

import '../../../../public/widgets/custom_text_form_field.dart';
import '../../../../utils/app_colors.dart';

// ignore: must_be_immutable
class SendAbroadBeneficiary extends StatelessWidget {
  SendAbroadBeneficiary({super.key});

  late SendAbroadController sendAbroadController;

  @override
  Widget build(BuildContext context) {
    sendAbroadController = Get.put(SendAbroadController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Continue",
              onTap: () {
                sendAbroadController.validateBeneficiaryFields();
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
                  CustomTextFormField(
                    controller:
                        sendAbroadController.beneficiaryFirstNameController,
                    label: "Beneficiary First name",
                    hintText: "Enter Beneficiary First name",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    validator: (value) {
                      if (value!.length == 0)
                        return "Beneficiary First name is required";
                      else if (value.length < 2)
                        return "Beneficiary First name is too short";
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextFormField(
                    controller:
                        sendAbroadController.beneficiaryLastNameController,
                    label: "Beneficiary Last name",
                    hintText: "Enter Beneficiary Last name",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    validator: (value) {
                      if (value!.length == 0)
                        return "Beneficiary Last name is required";
                      else if (value.length < 2)
                        return "Beneficiary Last name is too short";
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextFormField(
                    controller:
                        sendAbroadController.beneficiaryBankNameController,
                    label: "Beneficiary Bank name",
                    hintText: "Enter Beneficiary Bank name",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    validator: (value) {
                      if (value!.length == 0)
                        return "Beneficiary Bank name is required";
                      else if (value.length < 2)
                        return "Beneficiary Bank name is too short";
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextFormField(
                    controller: sendAbroadController.swiftOrBicCodeController,
                    label: "SWIFT/BIC Code",
                    hintText: "Enter SWIFT/BIC Code",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    validator: (value) {
                      if (value!.length == 0)
                        return "SWIFT/BIC Code is required";
                      else if (value.length < 2)
                        return "SWIFT/BIC Code is too short";
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextFormField(
                    controller: sendAbroadController.accountNumberController,
                    label: "IBAN/Account number",
                    hintText: "Enter IBAN/Account number",
                    maxLength: 10,
                    maxLengthEnforced: true,
                    showCounterText: false,
                    textInputType: TextInputType.phone,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    validator: (value) {
                      if (value!.length == 0)
                        return "IBAN/Account number is required";
                      else if (value.length < 10)
                        return "IBAN/Account number should be 10 digits";
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
