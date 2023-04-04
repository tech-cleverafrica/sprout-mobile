import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/controller/customer_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class CreateCustomer extends StatelessWidget {
  CreateCustomer({super.key});

  late CustomerController customerController;

  @override
  Widget build(BuildContext context) {
    customerController = Get.put(CustomerController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                CustomTextFormField(
                  controller: customerController.customerNameController,
                  label: "Customer Name",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  controller: customerController.customerPhoneController,
                  label: "Phone Number",
                  textInputType: TextInputType.phone,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  controller: customerController.customerEmailController,
                  label: "Email",
                  textInputType: TextInputType.emailAddress,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  controller: customerController.customerAddressController,
                  label: "Address",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(40.h),
                CustomButton(
                  title: "Add Customer",
                  borderRadius: 30,
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
