import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/profile/controller/create_pin_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class CreatePin extends StatelessWidget {
  CreatePin({super.key});

  late CreatePinController createPinController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    createPinController = Get.put(CreatePinController());

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(25.h),
              Text(
                'Your PIN adds an extra layer of security to your Sprout account (a PIN is required to authorise transactions)',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Mont",
                    color: AppColors.inputLabelColor),
              ),
              addVerticalSpace(15.h),
              CustomTextFormField(
                controller: createPinController.pinController,
                label: "Enter your PIN",
                hintText: "****",
                maxLength: 4,
                maxLengthEnforced: true,
                obscured: true,
                showCounterText: false,
                textInputAction: TextInputAction.next,
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
                required: true,
                textInputType: TextInputType.phone,
                validator: (value) {
                  if (value!.length == 0)
                    return "PIN cannot be empty";
                  else if (value.length < 4) return "PIN must be 4 digits";
                  return null;
                },
              ),
              CustomTextFormField(
                controller: createPinController.confirmPinController,
                label: "Confirm PIN",
                hintText: "****",
                maxLength: 4,
                maxLengthEnforced: true,
                obscured: true,
                showCounterText: false,
                textInputAction: TextInputAction.next,
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
                required: true,
                textInputType: TextInputType.phone,
                validator: (value) {
                  if (value!.length == 0)
                    return "PIN cannot be empty";
                  else if (value.length < 4)
                    return "PIN must be 4 digits";
                  else if (value.length == 4 &&
                      value != createPinController.pinController.text)
                    return "PIN does not match";
                  return null;
                },
              ),
              addVerticalSpace(42.h),
              CustomButton(
                title: "Create PIN",
                onTap: () {
                  createPinController.validate();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
