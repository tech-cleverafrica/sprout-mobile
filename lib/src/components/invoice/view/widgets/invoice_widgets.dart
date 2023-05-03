import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/components/invoice/view/invoice_details.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';

import '../../../../utils/helper_widgets.dart';

var oCcy = new NumberFormat("#,##0.00", "en_US");

DateTime localDate(String date) {
  return DateTime.parse(date).toLocal();
}

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
    this.invoice,
  }) : super(key: key);

  final ThemeData theme;
  final bool isDarkMode;
  final String invoiceNo;
  final num? invoiceTotalPrice;
  final String? to;
  final String? from;
  final String? createdAt;
  final String? status;
  final Invoice? invoice;
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
          Get.to(() => InvoiceDetails(), arguments: invoice);
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
                            to!,
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
                              invoiceNo,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 10.sp,
                                  color: isDarkMode
                                      ? AppColors.inputLabelColor
                                      : AppColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          // addVerticalSpace(5.h),
                          // Container(
                          //   width: MediaQuery.of(context).size.width * .6,
                          //   child: Text(
                          //     from!,
                          //     style: TextStyle(
                          //         fontFamily: "Mont",
                          //         fontSize: 10.sp,
                          //         color: isDarkMode
                          //             ? AppColors.inputLabelColor
                          //             : AppColors.black,
                          //         fontWeight: FontWeight.w500),
                          //   ),
                          // ),
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
                            (invoiceTotalPrice != null
                                ? oCcy
                                    .format(double.parse(
                                        invoiceTotalPrice!.toStringAsFixed(2)))
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
              // addVerticalSpace(10.h),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 24),
              //   child: InkWell(
              //     onTap: onTapDownload,
              //     child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(30),
              //           border: Border.all(color: AppColors.primaryColor)),
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Center(
              //             child: Text(
              //           "Download Invoice",
              //           style: TextStyle(
              //               color: AppColors.primaryColor,
              //               fontFamily: "Mont"),
              //         )),
              //       ),
              //     ),
              //   ),
              // ),
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
