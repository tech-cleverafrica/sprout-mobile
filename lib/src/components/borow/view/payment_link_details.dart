import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/borow/controller/payment_link_controler.dart';
import 'package:sprout_mobile/src/components/borow/controller/payment_link_details_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class PaymentLinkDetails extends StatelessWidget {
  PaymentLinkDetails({super.key});

  late PaymentLinkController paymentLinkController;
  late PaymentLinkDetailsController paymentLinkDetailsController;

  @override
  Widget build(BuildContext context) {
    paymentLinkController = Get.put(PaymentLinkController());
    paymentLinkDetailsController = Get.put(PaymentLinkDetailsController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeader(isDarkMode),
            addVerticalSpace(16.h),
            Obx((() => getInfo(isDarkMode, context, theme)))
          ],
        ),
      )),
    ));
  }

  getInfo(isDarkMode, context, theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      paymentLinkDetailsController.screenStatus.value,
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontSize: 12.sp,
                          color: isDarkMode
                              ? AppColors.white
                              : AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      paymentLinkController.share(paymentLinkDetailsController
                          .paymentLink.value!.paymentLinkUrl!);
                    },
                    child: Container(
                      width: 40.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.mainGreen
                              : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppSvg.share,
                              color: AppColors.white,
                              height: 16,
                              width: 16,
                            ),
                          ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        addVerticalSpace(20.h),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.greyDot : AppColors.greyBg,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Details",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: isDarkMode ? AppColors.white : AppColors.black),
                ),
                addVerticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                          color:
                              isDarkMode ? AppColors.white : AppColors.black),
                    ),
                    Text(
                        paymentLinkDetailsController
                            .paymentLink.value!.fullName!,
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount",
                        style: TextStyle(
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.black)),
                    Text(
                        "$currencySymbol${paymentLinkController.formatter.formatAsMoney(double.parse(paymentLinkDetailsController.paymentLink.value!.amount.toString()))}",
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Decription",
                        style: TextStyle(
                            color: isDarkMode
                                ? AppColors.white
                                : AppColors.black)),
                    Text(
                        paymentLinkDetailsController
                            .paymentLink.value!.description!,
                        style: theme.textTheme.headline6),
                  ],
                ),
              ],
            ),
          ),
        ),
        addVerticalSpace(10.h),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.greyDot : AppColors.greyBg,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Link",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: isDarkMode ? AppColors.white : AppColors.black),
                ),
                addVerticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (await canLaunchUrl(Uri.parse(
                            paymentLinkDetailsController
                                .paymentLink.value!.paymentLinkUrl!))) {
                          await launchUrl(Uri.parse(paymentLinkDetailsController
                              .paymentLink.value!.paymentLinkUrl!));
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          paymentLinkDetailsController
                              .paymentLink.value!.paymentLinkUrl!,
                          style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Platform.isIOS
                          ? Clipboard.setData(ClipboardData(
                                  text: paymentLinkDetailsController
                                      .paymentLink.value!.paymentLinkUrl!))
                              .then((value) => {
                                    CustomToastNotification.show(
                                        "Link has been copied successfully",
                                        type: ToastType.success),
                                  })
                          : FlutterClipboard.copy(paymentLinkDetailsController
                                  .paymentLink.value!.paymentLinkUrl!)
                              .then((value) => {
                                    CustomToastNotification.show(
                                        "Link has been copied successfully",
                                        type: ToastType.success),
                                  }),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: SvgPicture.asset(
                          AppSvg.copy,
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          height: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
