import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/view/all_invoice.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';

import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({super.key});

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
                addVerticalSpace(16.h),
                getDisplaySwitch(isDarkMode),
                addVerticalSpace(16.h),
                Container(
                  width: double.infinity,
                  //height: 284.h,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(AppImages.invoice),
                          fit: BoxFit.contain)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(50.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                            width: 205.w,
                            child: Text(
                              "Generate Invoices",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 44.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900),
                            )),
                      ),
                      addVerticalSpace(10.h),
                      Container(
                          height: 150.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              image: DecorationImage(
                                  image: AssetImage(AppImages.invoice_overlay),
                                  fit: BoxFit.cover)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 122.w,
                                  child: Text(
                                    "Lorem ipsum dolor sit amet consectetur. Placerat lorem neque risus.",
                                    style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontSize: 12.sp,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                    width: 144.w,
                                    child: CustomButton(
                                      title: "Get Started",
                                      color: AppColors.black,
                                      onTap: () {
                                        Get.to(() => AllInvoiceScreen());
                                      },
                                    ))
                              ],
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDisplaySwitch(bool isDarkMode) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isDarkMode ? AppColors.greyDot : AppColors.grey),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 10, left: 10),
                child: Text(
                  "Invoice",
                  style: TextStyle(
                      fontFamily: "DmSans",
                      fontSize: 14.sp,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 10, left: 10),
                  child: Text(
                    "Draft",
                    style: TextStyle(
                        fontFamily: "DmSans",
                        fontSize: 14.sp,
                        color: isDarkMode ? AppColors.grey : AppColors.greyText,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
