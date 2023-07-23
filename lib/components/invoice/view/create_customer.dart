import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/invoice/controller/customer_controller.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class CreateCustomer extends StatelessWidget {
  CreateCustomer({super.key});

  late CustomerController customerController;

  @override
  Widget build(BuildContext context) {
    customerController = Get.put(CustomerController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                CustomTextFormField(
                  controller: customerController.customerNameController,
                  label: "Customer Name",
                  hintText: "Enter Customer Name",
                  textInputAction: TextInputAction.next,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Customer Name is required";
                    else if (value.length < 2)
                      return "Customer Name is too short";
                    return null;
                  },
                ),
                CustomTextFormField(
                    controller: customerController.customerPhoneController,
                    label: "Phone Number",
                    hintText: "Enter Phone Number",
                    maxLength: 11,
                    showCounterText: false,
                    maxLengthEnforced: true,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))
                    ],
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    validator: (value) {
                      if (value!.length == 0)
                        return "Phone number is required";
                      else if (value.length < 11)
                        return "Phone number should be 11 digits";
                      return null;
                    }),
                CustomTextFormField(
                  controller: customerController.customerEmailController,
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
                  controller: customerController.customerAddressController,
                  maxLines: 2,
                  maxLength: 250,
                  label: "Enter Address",
                  hintText: "Address",
                  maxLengthEnforced: true,
                  validator: (value) {
                    if (value!.length == 0)
                      return "Address is required";
                    else if (value.length < 6) return "Address is too short";
                    return null;
                  },
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(40.h),
                CustomButton(
                  title: "Add Customer",
                  onTap: () {
                    customerController.validate();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
