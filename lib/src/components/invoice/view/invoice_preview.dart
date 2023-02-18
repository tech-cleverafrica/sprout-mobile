import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/view/success_invoice.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

class InvoicePreviewScreen extends StatelessWidget {
  const InvoicePreviewScreen({super.key});

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
                Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Invoice #1",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black),
                      ),
                      addVerticalSpace(10.h),
                      Text(
                        "Date: 18-02-2023",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black),
                      ),
                      addVerticalSpace(10.h),
                      Text(
                        "Due Date: 22-02-2023",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black),
                      ),
                      addVerticalSpace(20.h),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "To",
                                    style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: isDarkMode
                                            ? AppColors.greyText
                                            : AppColors.greyText),
                                  ),
                                  SvgPicture.asset(AppSvg.pendown)
                                ],
                              ),
                              addVerticalSpace(10.h),
                              Text("banana Inc",
                                  style: theme.textTheme.headline6),
                              addVerticalSpace(10.h),
                              Text(
                                "134, High street, New Jersey, NYC, 1123233",
                                style: theme.textTheme.headline6,
                              ),
                              addVerticalSpace(10.h),
                              Text("finance@banana.com"),
                              addVerticalSpace(10.h),
                              Text("+1(233)3423-2323"),
                            ],
                          ),
                        ),
                      ),
                      addVerticalSpace(5.h),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("DESCRIPTION"),
                                  Text("RATE"),
                                  Text("QTY"),
                                  Text("SUBTOTAL"),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 46.w,
                                    child: Text(
                                      "RPA Service 1x3 months",
                                      style: theme.textTheme.headline6,
                                    ),
                                  ),
                                  Text("N3000",
                                      style: theme.textTheme.headline6),
                                  Text("3", style: theme.textTheme.headline6),
                                  Text("N9000",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                              addVerticalSpace(10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 46.w,
                                    child: Text(
                                      "Server Cost",
                                      style: theme.textTheme.headline6,
                                    ),
                                  ),
                                  Text("N18000",
                                      style: theme.textTheme.headline6),
                                  Text("2", style: theme.textTheme.headline6),
                                  Text("N36000",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      addVerticalSpace(5.h),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       ".",
                      //       style: TextStyle(
                      //           fontSize: 20,
                      //           color: isDarkMode
                      //               ? AppColors.greyDot
                      //               : AppColors.black),
                      //     ),
                      //     Text(".")
                      //   ],
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: isDarkMode
                                            ? AppColors.greyText
                                            : AppColors.greyText),
                                  ),
                                  Text("N45000",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                              addVerticalSpace(20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Tax"),
                                      addHorizontalSpace(5.w),
                                      Container(
                                        height: 20,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Center(
                                          child: Text(
                                            "12%",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text("N300",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                              addVerticalSpace(20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "GRAND TOTAL",
                                    style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontSize: 16.sp,
                                        color: AppColors.mainGreen),
                                  ),
                                  Text(
                                    "N44,000",
                                    style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(10.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Signature",
                          style: theme.textTheme.headline6,
                        ),
                        addVerticalSpace(10.h),
                        SvgPicture.asset(
                          AppSvg.signature,
                          color: isDarkMode ? AppColors.white : AppColors.black,
                        )
                      ],
                    ),
                  ),
                ),
                addVerticalSpace(10.h),
                Container(
                  width: double.infinity,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                addVerticalSpace(20.h),
                CustomButton(
                  title: "Create invoice",
                  onTap: () {
                    Get.to(() => SuccessfulInvoice());
                  },
                ),
                addVerticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
