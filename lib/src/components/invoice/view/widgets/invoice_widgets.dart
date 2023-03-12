import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    this.to,
    this.from,
    this.createdAt,
  }) : super(key: key);

  final ThemeData theme;
  final bool isDarkMode;
  final String invoiceNo;
  final num? invoiceTotalPrice;
  final String? to;
  final String? from;
  final String? createdAt;

  @override
  Widget build(BuildContext context) {
    String? tType;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
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
                Text(
                  invoiceTotalPrice.toString(),
                  style: TextStyle(
                      fontFamily: "DMSans",
                      color: AppColors.mainGreen,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
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
    );
  }
}
