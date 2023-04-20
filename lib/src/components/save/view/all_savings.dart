import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';

class AllSavingsScreen extends StatelessWidget {
  const AllSavingsScreen({super.key});

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
                Row(
                  children: [
                    Text("Housing"),
                    addHorizontalSpace(15.w),
                    Text("Japa")
                  ],
                ),
                addVerticalSpace(20.h),
                CustomTextFormField(
                  hintText: "Search your savings",
                  hasPrefixIcon: true,
                  prefixIcon: Icon(Icons.search),
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(20.h),
                ListView.builder(
                    itemCount: 7,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Savings - Housing",
                                  style: TextStyle(
                                      fontFamily: "Mont",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: isDarkMode
                                          ? AppColors.inputLabelColor
                                          : AppColors.black),
                                ),
                                addVerticalSpace(5.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'N19,260.0',
                                      style: TextStyle(
                                          fontFamily: "Mont",
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black),
                                    ),
                                    Container(
                                      alignment: Alignment.topRight,
                                      decoration: BoxDecoration(
                                          color: isDarkMode
                                              ? AppColors.greyDot
                                              : AppColors.greyBg,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Icon(
                                            CommunityMaterialIcons
                                                .eye_off_outline,
                                            size: 18,
                                            color: isDarkMode
                                                ? AppColors.greyText
                                                : AppColors.greyText),
                                      ),
                                    )
                                  ],
                                ),
                                addVerticalSpace(10.h),
                                Divider()
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
