import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/cable/cable_tv.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/internet/select_bundle.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../../public/widgets/custom_text_form_field.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';

class InternetDataScreen extends StatelessWidget {
  const InternetDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                hasPrefixIcon: true,
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Search your bundle",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              addVerticalSpace(35.h),
              BillsCard(
                title: "Airtel Bundle",
                subTitle: "Internet Data",
                image: AppImages.airtel,
                onTap: () {
                  Get.to(() => SelectBundleScreen());
                },
              ),
              addVerticalSpace(10.h),
              BillsCard(
                title: "Mtn Bundle",
                subTitle: "Internet Data",
                image: AppImages.mtn,
                onTap: () {
                  Get.to(() => SelectBundleScreen());
                },
              ),
              addVerticalSpace(10.h),
              BillsCard(
                title: "9Mobile Bundle",
                subTitle: "Internet Data",
                image: AppImages.nine_mobile,
                onTap: () {
                  Get.to(() => SelectBundleScreen());
                },
              ),
              addVerticalSpace(10.h),
              BillsCard(
                title: "Glo Bundle",
                subTitle: "Internet Data",
                image: AppImages.glo,
                onTap: () {
                  Get.to(() => SelectBundleScreen());
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
