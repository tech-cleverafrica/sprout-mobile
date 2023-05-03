import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/borow/controller/payment_link_controler.dart';
import 'package:sprout_mobile/src/components/borow/view/success_payment_link.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class RequestPayment extends StatelessWidget {
  RequestPayment({super.key});

  late PaymentLinkController paymentLinkController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    paymentLinkController = Get.put(PaymentLinkController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(40.h),
                Text(
                  "Enter Amount ($currencySymbol)",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? AppColors.white : AppColors.black),
                ),
                Container(
                  child: TextFormField(
                    controller: paymentLinkController.amountController,
                    enabled: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Mont",
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? AppColors.white : AppColors.black),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {},
                    onSaved: (val) {},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length == 0)
                        return "Amount is required";
                      else if (double.parse(value.split(",").join("")) == 0) {
                        return "Invalid amount";
                      } else if (double.parse(value.split(",").join("")) < 10) {
                        return "Amount too small";
                      }
                      return null;
                    },
                  ),
                ),
                addVerticalSpace(20.h),
                CustomTextFormField(
                  controller: paymentLinkController.paymentNameController,
                  label: "Name",
                  hintText: "Enter Payment Name",
                  validator: (value) {
                    if (value!.length == 0)
                      return "Name is required";
                    else if (value.length < 3) return "Name is too short";
                    return null;
                  },
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  controller: paymentLinkController.senderEmailController,
                  label: "Email",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  hintText: "davejossy9@gmail.com",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) => EmailValidator.validate(value ?? "")
                      ? null
                      : "Please enter a valid email",
                ),
                CustomTextFormField(
                  controller:
                      paymentLinkController.paymentDescriptionController,
                  maxLines: 4,
                  maxLength: 250,
                  label: "Description",
                  hintText: "Enter Payment Description",
                  maxLengthEnforced: true,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Description is required";
                    else if (value.length < 6)
                      return "Description is too short";
                    return null;
                  },
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(83.h),
                DecisionButton(
                  isDarkMode: isDarkMode,
                  buttonText: "Continue",
                  onTap: () {
                    paymentLinkController.validate();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
