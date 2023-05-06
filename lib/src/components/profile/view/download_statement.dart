import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/profile/controller/download_statement_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class DownloadStatementScreen extends StatelessWidget {
  DownloadStatementScreen({super.key});
  late DownloadStatementController downloadStatementController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    downloadStatementController = Get.put(DownloadStatementController());
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: CustomButton(
            title: "Submit",
            onTap: () {
              downloadStatementController.validate();
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              // CustomTextFormField(
              //     label: "Choose account",
              //     hintText: "Sprout Naira Account",
              //     enabled: false,
              //     fillColor: isDarkMode
              //         ? AppColors.inputBackgroundColor
              //         : AppColors.grey,
              //     hintTextStyle: TextStyle(
              //       fontWeight: FontWeight.w700,
              //       color: isDarkMode ? AppColors.white : AppColors.black,
              //     )),
              InkWell(
                onTap: () => downloadStatementController.selectStartDate(),
                child: Obx((() => CustomTextFormField(
                    controller: downloadStatementController.startDateController,
                    label: "Start date",
                    enabled: false,
                    hintText: downloadStatementController.startDate.value,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    textInputAction: TextInputAction.next,
                    hintTextStyle: downloadStatementController
                                .startDate.value ==
                            "YYYY / MM / DAY"
                        ? null
                        : TextStyle(
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                            fontWeight: FontWeight.w600)))),
              ),
              addHorizontalSpace(10.w),
              InkWell(
                  onTap: () => downloadStatementController.selectEndDate(),
                  child: Obx((() => CustomTextFormField(
                      controller: downloadStatementController.endDateController,
                      label: "End date",
                      enabled: false,
                      hintText: downloadStatementController.endDate.value,
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                      textInputAction: TextInputAction.next,
                      hintTextStyle:
                          downloadStatementController.endDate.value ==
                                  "YYYY / MM / DAY"
                              ? null
                              : TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontWeight: FontWeight.w600))))),
            ],
          ),
        )),
      ),
    );
  }
}
