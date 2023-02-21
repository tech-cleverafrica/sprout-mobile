import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/cable/cable_tv.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/internet/internet_data.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

class PayBillsScreen extends StatelessWidget {
  const PayBillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigation(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              CustomTextFormField(
                hasPrefixIcon: true,
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Search your bills",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              addVerticalSpace(35.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getItems(isDarkMode, AppSvg.electricity, "Electricity"),
                  InkWell(
                      onTap: () {
                        Get.to(() => CabletvScreen());
                      },
                      child: getItems(isDarkMode, AppSvg.cable, "Cable TV")),
                  InkWell(
                    onTap: () {
                      Get.to(() => InternetDataScreen());
                    },
                    child: getItems(
                        isDarkMode, AppSvg.mobile, "Mobile Data &\n Internet"),
                  ),
                  getItems(isDarkMode, AppSvg.betting, "Betting")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column getItems(bool isDarkMode, svg, text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(svg),
        addVerticalSpace(6.h),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "DMSans",
              color: isDarkMode ? AppColors.white : AppColors.black),
        ),
      ],
    );
  }
}
