import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';

import '../../../../utils/helper_widgets.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    Key? key,
    required this.theme,
    required this.isDarkMode,
    required this.invoiceNo,
    this.invoiceTotalPrice,
    required this.onTapDownload,
    this.to,
    this.from,
    this.createdAt,
    this.status,
  }) : super(key: key);

  final ThemeData theme;
  final bool isDarkMode;
  final String invoiceNo;
  final num? invoiceTotalPrice;
  final String? to;
  final String? from;
  final String? createdAt;
  final String? status;
  final VoidCallback onTapDownload;
  @override
  Widget build(BuildContext context) {
    String? sType;
    Color? sColor;
    Color? sBg;
    switch (status) {
      case "NOT_PAID":
        sType = "Not Paid";
        sColor = AppColors.errorRed;
        sBg = Color(0xFFF5B7B1);
        break;
      case "PARTIAL_PAYMENT":
        sType = "Partial Payment";
        sColor = AppColors.orangeWarning;
        sBg = Color(0xFFFFFD580);
        break;
      case "PAID":
        sType = "Paid";
        sColor = AppColors.mainGreen;
        sBg = Color(0xFF90EE90);
        break;
      default:
        sType = "Not Paid";
        sColor = AppColors.errorRed;
        sBg = Color(0xFFF5B7B1);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: InkWell(
        onTap: () {
          // Get.to(() => InvoiceDetails());
          debugPrint("GOT HERE!!!");
        },
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppSvg.send,
                        color: AppColors.mainGreen,
                        height: 18,
                        width: 18,
                      ),
                      addHorizontalSpace(5.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            invoiceNo,
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 12.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          addVerticalSpace(5.h),
                          Container(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Text(
                              to!,
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 10.sp,
                                  color: isDarkMode
                                      ? AppColors.inputLabelColor
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          addVerticalSpace(5.h),
                          Container(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Text(
                              from!,
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 10.sp,
                                  color: isDarkMode
                                      ? AppColors.inputLabelColor
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          addVerticalSpace(5.h),
                          Container(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Text(
                              createdAt!,
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 10.sp,
                                  color: isDarkMode
                                      ? AppColors.inputLabelColor
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        invoiceTotalPrice.toString(),
                        style: TextStyle(
                            fontFamily: "DMSans",
                            color: AppColors.mainGreen,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: sBg,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              sType,
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 11.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              addVerticalSpace(10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: onTapDownload,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(
                        "Download Invoice",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: "DMSans"),
                      )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
