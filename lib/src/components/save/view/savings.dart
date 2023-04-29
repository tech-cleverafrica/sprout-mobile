import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/save/controller/savings_controller.dart';
import 'package:sprout_mobile/src/components/save/view/all_savings.dart';
import 'package:sprout_mobile/src/components/save/view/new_savings.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class SavingsScreen extends StatelessWidget {
  SavingsScreen({super.key});

  late SavingsController savingsIncontroller;

  @override
  Widget build(BuildContext context) {
    savingsIncontroller = Get.put(SavingsController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
        child: Obx((() => savingsIncontroller.savings.isEmpty &&
                !savingsIncontroller.showMain.value &&
                !savingsIncontroller.isSavingsLoading.value
            ? Scaffold(
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getHeader(isDarkMode),
                      addVerticalSpace(15.h),
                      addVerticalSpace(16.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.deepOrange,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage(AppImages.padlock),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addVerticalSpace(50.h),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                  width: 200.w,
                                  child: Text(
                                    "Save with Sprout",
                                    style: TextStyle(
                                        fontFamily: "Mont",
                                        fontSize: 40.sp,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w900),
                                  )),
                            ),
                            addVerticalSpace(10.h),
                            Container(
                                height: 120.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    image: DecorationImage(
                                        image: AssetImage(AppImages.overlay),
                                        fit: BoxFit.cover)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx((() => savingsIncontroller
                                                  .isApproved.value &&
                                              !savingsIncontroller
                                                  .inReview.value
                                          ? Container(
                                              width: 125.w,
                                              child: CustomButton(
                                                title: "Get Started",
                                                color: AppColors.black,
                                                onTap: () {
                                                  if (!savingsIncontroller
                                                      .isSavingsLoading.value) {
                                                    savingsIncontroller
                                                        .showMain.value = true;
                                                  }
                                                },
                                              ))
                                          : SizedBox()))
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : !savingsIncontroller.isSavingsLoading.value
                ? Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
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
                                    Text("Savings Balance",
                                        style: TextStyle(
                                            fontFamily: "Mont",
                                            fontSize: 12.sp,
                                            color: isDarkMode
                                                ? AppColors.greyText
                                                : AppColors.greyText,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    savingsIncontroller.type.value = "";
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: ((context) {
                                          return Dialog(
                                            backgroundColor: isDarkMode
                                                ? AppColors.blackBg
                                                : AppColors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Obx((() => Container(
                                                  height: savingsIncontroller
                                                              .type.value ==
                                                          ""
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.3
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.4,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20,
                                                        horizontal: 20),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            InkWell(
                                                                onTap: () =>
                                                                    Get.back(),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  AppSvg.cancel,
                                                                  height: 20,
                                                                ))
                                                          ],
                                                        ),
                                                        addVerticalSpace(25.h),
                                                        InkWell(
                                                          onTap: () => {
                                                            savingsIncontroller
                                                                .type
                                                                .value = "LOCK"
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Lock Funds",
                                                                    style: theme
                                                                        .textTheme
                                                                        .headline6,
                                                                  ),
                                                                  SvgPicture
                                                                      .asset(
                                                                    savingsIncontroller.type.value ==
                                                                            "LOCK"
                                                                        ? AppSvg
                                                                            .mark_green
                                                                        : AppSvg
                                                                            .mark_dot,
                                                                    height: 20,
                                                                  )
                                                                ],
                                                              ),
                                                              addVerticalSpace(
                                                                  5.h),
                                                              Text(
                                                                "Lock your funds for a period of time and earn interest.",
                                                                style: theme
                                                                    .textTheme
                                                                    .subtitle2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        addVerticalSpace(20.h),
                                                        InkWell(
                                                          onTap: () => {
                                                            savingsIncontroller
                                                                    .type
                                                                    .value =
                                                                "TARGET"
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Target Savings",
                                                                    style: theme
                                                                        .textTheme
                                                                        .headline6,
                                                                  ),
                                                                  SvgPicture
                                                                      .asset(
                                                                    savingsIncontroller.type.value ==
                                                                            "TARGET"
                                                                        ? AppSvg
                                                                            .mark_green
                                                                        : AppSvg
                                                                            .mark_dot,
                                                                    height: 20,
                                                                  )
                                                                ],
                                                              ),
                                                              addVerticalSpace(
                                                                  5.h),
                                                              Text(
                                                                  "Automate your savings for a future goal and earn interest while you do so.",
                                                                  style: theme
                                                                      .textTheme
                                                                      .subtitle2)
                                                            ],
                                                          ),
                                                        ),
                                                        savingsIncontroller.type
                                                                    .value !=
                                                                ""
                                                            ? Column(
                                                                children: [
                                                                  addVerticalSpace(
                                                                      30.h),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20),
                                                                    child:
                                                                        CustomButton(
                                                                      title:
                                                                          "Continue",
                                                                      onTap:
                                                                          () {
                                                                        pop();
                                                                        if (savingsIncontroller.type.value ==
                                                                            "LOCK") {
                                                                          Get.to(() =>
                                                                              NewSavingsScreen());
                                                                        } else {
                                                                          Get.to(() =>
                                                                              NewSavingsScreen());
                                                                        }
                                                                      },
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                ))),
                                          );
                                        }));
                                  },
                                  child: Container(
                                    height: 37.h,
                                    width: 124.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: AppColors.white,
                                          size: 16,
                                        ),
                                        addHorizontalSpace(4.w),
                                        Text("Start New Savings",
                                            style: TextStyle(
                                                fontFamily: "Mont",
                                                fontSize: 10.sp,
                                                color: isDarkMode
                                                    ? AppColors.white
                                                    : AppColors.white,
                                                fontWeight: FontWeight.w700))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            addVerticalSpace(15.h),
                            Row(
                              children: [
                                Padding(
                                  padding: savingsIncontroller.showAmount.value
                                      ? EdgeInsets.only(top: 0)
                                      : EdgeInsets.only(top: 10),
                                  child: Text(
                                    (savingsIncontroller.showAmount.value
                                        ? currencySymbol + "0.00"
                                        : "******"),
                                    style: TextStyle(
                                        fontFamily: "Mont",
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w700,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black),
                                  ),
                                ),
                                addHorizontalSpace(16.w),
                                InkWell(
                                  onTap: () => {
                                    savingsIncontroller.showAmount.value =
                                        !savingsIncontroller.showAmount.value
                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? AppColors.greyDot
                                            : AppColors.greyBg,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                          savingsIncontroller.showAmount.value
                                              ? CommunityMaterialIcons
                                                  .eye_off_outline
                                              : CommunityMaterialIcons
                                                  .eye_outline,
                                          size: 18,
                                          color: isDarkMode
                                              ? AppColors.greyText
                                              : AppColors.greyText),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Obx((() => savingsIncontroller.savings.isNotEmpty
                                ? Column(
                                    children: [
                                      addVerticalSpace(20.h),
                                      Row(
                                        children: [
                                          Container(
                                            width: 86.w,
                                            height: 94.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: isDarkMode
                                                  ? AppColors.greyDot
                                                  : AppColors.greyBg,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 15),
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: isDarkMode
                                                              ? AppColors.white
                                                              : AppColors.black,
                                                          fontSize: 10.sp),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          addHorizontalSpace(10.w),
                                          Container(
                                            width: 86.w,
                                            height: 94.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: isDarkMode
                                                  ? AppColors.greyDot
                                                  : AppColors.greyBg,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: isDarkMode
                                                              ? AppColors.white
                                                              : AppColors.black,
                                                          fontSize: 10.sp),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          addVerticalSpace(24.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Savings History",
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.greyText),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () => AllSavingsScreen());
                                                },
                                                child: Text(
                                                  "See All",
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontFamily: "Mont",
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.greyText,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : SizedBox())),
                            addVerticalSpace(20.h),
                            Obx((() => savingsIncontroller.savings.isEmpty
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(AppImages.emoty),
                                              addVerticalSpace(10.h),
                                              Container(
                                                width: 200.w,
                                                child: Text(
                                                  "No history yet. Click on “Start New Savings” at the top to get started",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: "Mont",
                                                      fontSize: 12.sp,
                                                      color:
                                                          AppColors.greyText),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container()
                                //  ListView.builder(
                                //     itemCount: 4,
                                //     shrinkWrap: true,
                                //     physics: NeverScrollableScrollPhysics(),
                                //     itemBuilder: ((context, index) {
                                //       return HistoryCard(
                                //           theme: theme,
                                //           isDarkMode: isDarkMode,
                                //           text: "Housing");
                                //     }))
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                : Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getHeader(isDarkMode),
                          addVerticalSpace(15.h),
                          addVerticalSpace(16.h),
                          buildLargeShimmer()
                        ],
                      ),
                    ),
                  ))));
  }

  getDisplaySwitch(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isDarkMode ? AppColors.greyDot : AppColors.grey),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 10, left: 10),
                child: Text(
                  "Account",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontSize: 14.sp,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 10, left: 10),
                  child: Text(
                    "Invoice",
                    style: TextStyle(
                        fontFamily: "Mont",
                        fontSize: 14.sp,
                        color: isDarkMode ? AppColors.grey : AppColors.greyText,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
