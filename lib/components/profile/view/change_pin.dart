import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/profile/controller/change_pin_controller.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class ChangePin extends StatelessWidget {
  ChangePin({super.key});

  late ChangePinController changePinController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    changePinController = Get.put(ChangePinController());

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              CustomTextFormField(
                controller: changePinController.currentPinController,
                label: "Enter Current PIN",
                hintText: "****",
                maxLength: 4,
                maxLengthEnforced: true,
                obscured: true,
                textInputAction: TextInputAction.next,
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
                required: true,
                textInputType: TextInputType.phone,
                showCounterText: false,
                validator: (value) {
                  if (value!.length == 0)
                    return "Current PIN cannot be empty";
                  else if (value.length < 4) return "PIN must be 4 digits";
                  return null;
                },
              ),
              CustomTextFormField(
                controller: changePinController.newPinController,
                label: "New PIN",
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
                controller: changePinController.confirmPinController,
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
                      value != changePinController.newPinController.text)
                    return "PIN does not match";
                  return null;
                },
              ),
              addVerticalSpace(42.h),
              CustomButton(
                title: "Change PIN",
                onTap: () {
                  changePinController.validate();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
