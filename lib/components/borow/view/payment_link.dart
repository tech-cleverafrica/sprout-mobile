import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/borow/controller/payment_link_controler.dart';
import 'package:sprout_mobile/components/borow/view/request_payment.dart';
import 'package:sprout_mobile/components/borow/view/widgets/payment_link_widgets.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';

import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_images.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

import '../../../public/widgets/custom_loader.dart';
import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class PaymentLinkScreen extends StatefulWidget {
  PaymentLinkScreen({super.key});

  @override
  State<PaymentLinkScreen> createState() => PaymentLinkScreenState();
}

class PaymentLinkScreenState extends State<PaymentLinkScreen> {
  late PaymentLinkController paymentLinkController;

  @override
  Widget build(BuildContext context) {
    paymentLinkController = Get.put(PaymentLinkController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(16.h),
                getDisplaySwitch(isDarkMode),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: CustomTextFormField(
                        hasPrefixIcon: true,
                        prefixIcon: Icon(
                          Icons.search_outlined,
                        ),
                        hintText: "Search",
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                        onChanged: (value) =>
                            paymentLinkController.filterPaymentLinks(value),
                        contentPaddingVertical: 17,
                        borderRadius: 4,
                        isDense: true,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.28,
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () => {
                              paymentLinkController.showStatusList(
                                  context, isDarkMode, theme)
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: isDarkMode
                                    ? AppColors.mainGreen
                                    : AppColors.primaryColor,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 5),
                                  Image.asset(
                                    AppImages.filter,
                                    height: 5,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(width: 7),
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      paymentLinkController.status.value,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Mont",
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                ],
                              ), // )),
                            ),
                          ),
                        ),
                        addVerticalSpace(2.h),
                        Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.28,
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () => {
                              paymentLinkController.showTimeList(
                                  context, isDarkMode, theme)
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: isDarkMode
                                    ? AppColors.mainGreen
                                    : AppColors.primaryColor,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 5),
                                  Image.asset(
                                    AppImages.filter,
                                    height: 5,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(width: 7),
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      paymentLinkController.time.value,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Mont",
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                ],
                              ), // )),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                addVerticalSpace(10.h),
                Text(
                  "History",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                addVerticalSpace(20.h),
                Obx((() => buildBody(theme, isDarkMode)))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
          child: CustomButton(
              title: "Create Payment Link",
              prefixIcon: Icon(
                Icons.add,
                color: AppColors.white,
              ),
              onTap: () => push(page: RequestPayment())),
        ),
      ),
    );
  }

  buildBody(theme, isDarkMode) {
    return getPaymentLinkList(theme, isDarkMode);
  }

  getPaymentLinkList(theme, isDarkMode) {
    if (paymentLinkController.isPaymentLinksLoading.value) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: buildShimmer(3),
      );
    } else if (paymentLinkController.basePaymentLinks.length < 1) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addVerticalSpace(40.h),
            Image.asset(
              AppImages.invoice,
              height: 150,
              width: 150,
            ),
            Container(
              width: 200.w,
              child: Text(
                "No history yet. Click Create Payment Link at the bottom to get started",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isDarkMode ? AppColors.greyText : AppColors.black),
              ),
            )
          ],
        ),
      );
    } else {
      return ListView.builder(
          itemCount: paymentLinkController.paymentLinks.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return PaymentLinkCard(
              theme: theme,
              isDarkMode: isDarkMode,
              description:
                  paymentLinkController.paymentLinks[index].description!,
              amount: paymentLinkController.paymentLinks[index].amount,
              name:
                  paymentLinkController.paymentLinks[index].businessName != null
                      ? paymentLinkController.paymentLinks[index].businessName
                      : "No Name",
              createdAt: paymentLinkController.paymentLinks[index].createdAt,
              status: paymentLinkController.paymentLinks[index].paid!
                  ? "PAID"
                  : "NOT_PAID",
              paymentLink: paymentLinkController.paymentLinks[index],
            );
          });
    }
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
                  "Payments",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontSize: 14.sp,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
