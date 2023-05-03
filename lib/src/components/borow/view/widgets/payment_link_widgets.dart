import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/components/borow/model/payment_link_model.dart';
import 'package:sprout_mobile/src/components/borow/view/payment_link_details.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';

import '../../../../utils/helper_widgets.dart';

var oCcy = new NumberFormat("#,##0.00", "en_US");

DateTime localDate(String date) {
  return DateTime.parse(date).toLocal();
}

class PaymentLinkCard extends StatelessWidget {
  const PaymentLinkCard({
    Key? key,
    required this.theme,
    required this.isDarkMode,
    required this.description,
    this.amount,
    this.name,
    this.createdAt,
    this.status,
    this.paymentLink,
  }) : super(key: key);

  final ThemeData theme;
  final bool isDarkMode;
  final String description;
  final num? amount;
  final String? name;
  final String? createdAt;
  final String? status;
  final PaymentLink? paymentLink;
  @override
  Widget build(BuildContext context) {
    String? sType;
    Color? sBg;
    switch (status) {
      case "NOT_PAID":
        sType = "Not Paid";
        sBg = Color(0xFFF5B7B1);
        break;
      case "PAID":
        sType = "Paid";
        sBg = Color(0xFF90EE90);
        break;
      default:
        sType = "Not Paid";
        sBg = Color(0xFFF5B7B1);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: InkWell(
        onTap: () {
          Get.to(() => PaymentLinkDetails(), arguments: paymentLink);
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
                        AppSvg.basil_invoice,
                        // color: AppColors.mainGreen,
                        height: 18,
                        width: 18,
                      ),
                      addHorizontalSpace(5.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name!,
                            style: TextStyle(
                                fontFamily: "Mont",
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
                              description,
                              style: TextStyle(
                                  fontFamily: "Mont",
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
                              DateFormat('h:mma\t.\tdd-MM-yyyy')
                                  .format(localDate(createdAt!)),
                              style: TextStyle(
                                  fontFamily: "Mont",
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
                        "₦ " +
                            (amount != null
                                ? oCcy
                                    .format(double.parse(
                                        amount!.toStringAsFixed(2)))
                                    .toString()
                                : "0.00"),
                        style: TextStyle(
                            fontFamily: "Mont",
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: sBg, borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Center(
                            child: Text(
                              sType,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 10.sp),
                            ),
                          ),
                        ),
                      )
                    ],
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
      ),
    );
  }
}
