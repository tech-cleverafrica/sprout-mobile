import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/borow/controller/payment_link_success_controller.dart';
import 'package:sprout_mobile/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_svgs.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class SuccessfulPaymentLink extends StatelessWidget {
  SuccessfulPaymentLink({super.key});

  late PaymentLinkSuccessController paymentLinkSuccessController;

  @override
  Widget build(BuildContext context) {
    paymentLinkSuccessController = Get.put(PaymentLinkSuccessController());
    return WillPopScope(
      onWillPop: () {
        pushUntil(
            page: BottomNav(
          index: 0,
        ));
        return Future.value(true);
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.mainGreen,
                AppColors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            image: DecorationImage(
                image: AssetImage("assets/images/rough_background.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  addVerticalSpace(60.h),
                  Text(
                    "Successful",
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: "Mont",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  addVerticalSpace(26.h),
                  Container(
                      height: 220.h,
                      width: 250.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFD9D9D9).withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SvgPicture.asset(
                          AppSvg.mark,
                          color: AppColors.white,
                        ),
                      )),
                  addVerticalSpace(20.h),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        "You have successfully created a payment link for " +
                            paymentLinkSuccessController.paymentName.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Mont",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white),
                      )),
                  addVerticalSpace(20.w),
                  Container(
                      width: 160,
                      child: CustomButton(
                        height: 50,
                        title: "Copy Link",
                        onTap: () => Platform.isIOS
                            ? Clipboard.setData(ClipboardData(
                                    text: paymentLinkSuccessController
                                        .paymentLink
                                        .value["data"]["payment_link"]))
                                .then((value) => {
                                      CustomToastNotification.show(
                                          "Link has been copied successfully",
                                          type: ToastType.success),
                                    })
                            : FlutterClipboard.copy(paymentLinkSuccessController
                                    .paymentLink.value["data"]["payment_link"])
                                .then((value) => {
                                      CustomToastNotification.show(
                                          "Link has been copied successfully",
                                          type: ToastType.success),
                                    }),
                      ))
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 246.w,
                        child: CustomButton(
                            title: "Back To Home",
                            onTap: () {
                              pushUntil(
                                  page: BottomNav(
                                index: 0,
                              ));
                            }),
                      ),
                      addHorizontalSpace(8.w),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          paymentLinkSuccessController.share(
                              paymentLinkSuccessController
                                  .paymentLink.value["data"]["payment_link"]);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.inputBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(child: SvgPicture.asset(AppSvg.share)),
                        ),
                      ))
                    ],
                  ),
                  addVerticalSpace(20.h),
                  Image.asset(
                    AppImages.sprout_dark,
                    height: 24.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
