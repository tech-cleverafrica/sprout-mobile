import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprout_mobile/src/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_success_controller.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_svgs.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class SuccessfulInvoice extends StatelessWidget {
  SuccessfulInvoice({super.key});

  late InvoiceSuccessController invoiceSuccessController;

  @override
  Widget build(BuildContext context) {
    invoiceSuccessController = Get.put(InvoiceSuccessController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
        onWillPop: () {
          pushUntil(
              page: BottomNav(
            index: 2,
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
                    Obx((() => Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "You have successfully created an invoice for " +
                              invoiceSuccessController
                                  .invoice.value!.customer!.fullName!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Mont",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white),
                        )))),
                    addVerticalSpace(20.w),
                    Container(
                        width: 160,
                        child: CustomButton(
                          height: 50,
                          title: "Send Invoice",
                          onTap: () {
                            invoiceSuccessController.showUpdateModal(
                                context, isDarkMode);
                          },
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
                              title: "Back To Invoices",
                              onTap: () {
                                pushUntil(
                                    page: BottomNav(
                                  index: 2,
                                ));
                              }),
                        ),
                        addHorizontalSpace(8.w),
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            var tempDir = await getTemporaryDirectory();
                            if (invoiceSuccessController.invoiceUrl.value !=
                                "") {
                              invoiceSuccessController.download(
                                  Dio(),
                                  invoiceSuccessController.invoiceUrl.value,
                                  tempDir.path +
                                      "/" +
                                      invoiceSuccessController
                                          .invoice.value!.id! +
                                      ".pdf");
                              pop();
                            } else {
                              invoiceSuccessController
                                  .downloadInvoice(invoiceSuccessController
                                      .invoice.value!.id!)
                                  .then((value) => {
                                        if (value != null)
                                          {
                                            invoiceSuccessController.download(
                                                Dio(),
                                                value,
                                                tempDir.path +
                                                    "/" +
                                                    invoiceSuccessController
                                                        .invoice.value!.id! +
                                                    ".pdf"),
                                            pop()
                                          }
                                      });
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.inputBackgroundColor,
                                borderRadius: BorderRadius.circular(10)),
                            child:
                                Center(child: SvgPicture.asset(AppSvg.share)),
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
        ));
  }
}
