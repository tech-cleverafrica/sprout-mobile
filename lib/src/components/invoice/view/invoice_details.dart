import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

import '../../../utils/helper_widgets.dart';

class InvoiceDetails extends StatelessWidget {
  InvoiceDetails({super.key});

  late InvoiceController invoiceIncontroller;

  @override
  Widget build(BuildContext context) {
    invoiceIncontroller = Get.put(InvoiceController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeader(isDarkMode),
            addVerticalSpace(16.h),
            //getInfo(isDarkMode)
          ],
        ),
      )),
    );
  }

  getInfo(isDarkMode) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? AppColors.greyDot
                  : Color.fromRGBO(61, 2, 230, 0.1)),
          child: Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("jsakdhasklfasjdlkaskl",
                      style: TextStyle(
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text("68 ibidun street surulere",
                      style: TextStyle(
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text("reachayo@gmail.com",
                      style: TextStyle(
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text("09087656545",
                      style: TextStyle(
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
        addVerticalSpace(20.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode ? AppColors.greyDot : AppColors.greyBg),
          child: Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Billed To",
                      style: TextStyle(
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  Text("Abubakr Chinedu Ola",
                      style: TextStyle(
                          color: isDarkMode
                              ? AppColors.greyDot
                              : AppColors.greyText,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text("44 adetokunbo street",
                      style: TextStyle(
                          color: isDarkMode
                              ? AppColors.greyDot
                              : AppColors.greyText,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text("acola@gmail.com",
                      style: TextStyle(
                          color: isDarkMode
                              ? AppColors.greyDot
                              : AppColors.greyText,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text("08034323432",
                      style: TextStyle(
                          color: isDarkMode
                              ? AppColors.greyDot
                              : AppColors.greyText,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
        addVerticalSpace(20.h),
        Text("Invoice Information",
            style: TextStyle(
                color: isDarkMode ? AppColors.white : AppColors.black,
                fontFamily: "DMSans",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600)),
        addVerticalSpace(20.h),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 130.w,
                        child: Text(
                            "Proicurement of this and that plus this and that")),
                    Text("23"),
                    Text("N23,55"),
                    Text("N45000"),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
