import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/cable/cable_tv.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/internet/select_bundle.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
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
              InternetBillsCard(
                title: "Airtel Bundle",
                subTitle: "Internet Data",
                image: AppSvg.airtel,
                onTap: () {
                  Get.to(() => SelectBundleScreen());
                },
              ),
              addVerticalSpace(10.h),
              InternetBillsCard(
                title: "Mtn Bundle",
                subTitle: "Internet Data",
                image: AppSvg.mtn,
                onTap: () {
                  Get.to(() => SelectBundleScreen());
                },
              ),
              addVerticalSpace(10.h),
              InternetBillsCard(
                title: "9Mobile Bundle",
                subTitle: "Internet Data",
                image: AppSvg.nmobile,
                onTap: () {
                  Get.to(() => SelectBundleScreen());
                },
              ),
              addVerticalSpace(10.h),
              InternetBillsCard(
                title: "Glo Bundle",
                subTitle: "Internet Data",
                image: AppSvg.glo,
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

class InternetBillsCard extends StatelessWidget {
  const InternetBillsCard(
      {Key? key, this.title, this.subTitle, this.image, this.onTap})
      : super(key: key);
  final String? title;
  final String? image;
  final String? subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    image!,
                    height: 40,
                    width: 40,
                  ),
                  addHorizontalSpace(5.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black),
                      ),
                      Text(
                        subTitle!,
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                            color: isDarkMode
                                ? AppColors.greyText
                                : AppColors.greyText),
                      )
                    ],
                  )
                ],
              ),
              IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: isDarkMode
                        ? AppColors.inputLabelColor
                        : AppColors.inputLabelColor,
                  ))
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
