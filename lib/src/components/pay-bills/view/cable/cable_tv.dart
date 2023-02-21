import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/cable/select_package.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../../public/widgets/custom_text_form_field.dart';
import '../../../../utils/app_colors.dart';

class CabletvScreen extends StatelessWidget {
  const CabletvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(20),
              CustomTextFormField(
                hasPrefixIcon: true,
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Search your bills",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              addVerticalSpace(30.h),
              BillsCard(
                title: "GOTV",
                subTitle: "Tv Subscription",
                image: AppImages.gotv,
                onTap: () {
                  Get.to(() => SelectPackageScreen());
                },
              ),
              addVerticalSpace(10.h),
              BillsCard(
                title: "DSTV",
                subTitle: "Tv Subscription",
                image: AppImages.dstv,
                onTap: () {},
              ),
              addVerticalSpace(10.h),
              BillsCard(
                title: "STARTIMES",
                subTitle: "Tv Subscription",
                image: AppImages.startime,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BillsCard extends StatelessWidget {
  const BillsCard({Key? key, this.title, this.subTitle, this.image, this.onTap})
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
                  Image.asset(
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
