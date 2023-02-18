import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/home/view/widgets.dart';
import 'package:sprout_mobile/src/components/save/view/all_savings.dart';
import 'package:sprout_mobile/src/components/save/view/new_savings.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

class SavingsDashboard extends StatelessWidget {
  SavingsDashboard({super.key});

  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total Savings-",
                          style: TextStyle(
                              fontFamily: "DMSans",
                              color: isDarkMode
                                  ? AppColors.greyText
                                  : AppColors.greyText,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        addHorizontalSpace(5.w),
                        Text("Housing",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.greyText
                                    : AppColors.greyText,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Container(
                        width: 120.w,
                        child: CustomButton(
                          title: "Start New Savings",
                          onTap: () {
                            // Get.to(() => NewSavingsScreen());
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: ((context) {
                                  return Dialog(
                                    backgroundColor: isDarkMode
                                        ? AppColors.greyDot
                                        : AppColors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Container(
                                      height: 300.h,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        child: Column(
                                          children: [
                                            addVerticalSpace(10.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Cancel",
                                                  style:
                                                      theme.textTheme.headline6,
                                                ),
                                                InkWell(
                                                    onTap: () => Get.back(),
                                                    child: SvgPicture.asset(
                                                        AppSvg.cancel))
                                              ],
                                            ),
                                            addVerticalSpace(20.h),
                                            InkWell(
                                              onTap: () => Get.to(
                                                  () => NewSavingsScreen()),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Lock Savings",
                                                        style: theme.textTheme
                                                            .headline6,
                                                      ),
                                                      SvgPicture.asset(
                                                          AppSvg.mark_green)
                                                    ],
                                                  ),
                                                  addVerticalSpace(5.h),
                                                  Text(
                                                    "Lock your savings for a particular period of time and get interest on withdrawal",
                                                    style: theme
                                                        .textTheme.subtitle2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            addVerticalSpace(20.h),
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Target Savings",
                                                      style: theme
                                                          .textTheme.headline6,
                                                    ),
                                                    SvgPicture.asset(
                                                        AppSvg.mark_green)
                                                  ],
                                                ),
                                                addVerticalSpace(5.h),
                                                Text(
                                                    "Save for a future target periodically and get instant rewards",
                                                    style: theme
                                                        .textTheme.subtitle2)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                          },
                        )),
                  ],
                ),
                addVerticalSpace(15.h),
                Row(
                  children: [
                    Text(
                      "N19,260.00",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color:
                              isDarkMode ? AppColors.white : AppColors.black),
                    ),
                    addHorizontalSpace(16.w),
                    Container(
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(CommunityMaterialIcons.eye_off_outline,
                            size: 18,
                            color: isDarkMode
                                ? AppColors.greyText
                                : AppColors.greyText),
                      ),
                    )
                  ],
                ),
                addVerticalSpace(20.h),
                Row(
                  children: [
                    Container(
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              AppSvg.swap,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                            addVerticalSpace(15.h),
                            Container(
                              width: 60,
                              child: Text(
                                "Top Up Savings",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    addHorizontalSpace(10.w),
                    Container(
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppSvg.invoice,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                            addVerticalSpace(15.h),
                            Container(
                              width: 70,
                              child: Text(
                                "Roll Over",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Savings History",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 13.sp,
                          color: AppColors.greyText),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => AllSavingsScreen());
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontFamily: "DMSans",
                            fontSize: 13.sp,
                            color: AppColors.greyText,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(20.h),
                isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.emoty),
                              addVerticalSpace(10.h),
                              Container(
                                width: 200.w,
                                child: Text(
                                  "No history yet. Click on “Start New Savings” at the top to get started",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 13.sp,
                                      color: AppColors.greyText),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return HistoryCard(
                              theme: theme,
                              isDarkMode: isDarkMode,
                              text: "Housing");
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
