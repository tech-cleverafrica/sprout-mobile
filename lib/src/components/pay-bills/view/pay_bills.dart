import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/controller/pay_bills_controller.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/betting/betting.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/cable/cable_tv.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/electricity/electricity.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/internet/internet_data.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

// ignore: must_be_immutable
class PayBillsScreen extends StatelessWidget {
  PayBillsScreen({super.key});

  late PayBillsController payBillsController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    payBillsController = Get.put(PayBillsController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              CustomTextFormField(
                hasPrefixIcon: true,
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Search your bills",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
              ),
              addVerticalSpace(35.h),
              Obx((() => payBillsController.loading.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildBillsShimmer(),
                        buildBillsShimmer(),
                        buildBillsShimmer(),
                        buildBillsShimmer()
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var group in payBillsController.groups)
                          Container(
                            child: InkWell(
                                onTap: () {
                                  push(
                                      page: group.slug == "PAY_TV" ||
                                              group.slug == "PAID_TV"
                                          ? CableTvScreen()
                                          : group.slug == "AIRTIME_AND_DATA"
                                              ? InternetDataScreen()
                                              : group.slug ==
                                                          "ELECTRIC_DISCO" ||
                                                      group.slug == "DISCO"
                                                  ? ElectricityScreen()
                                                  : BettingScreen(),
                                      arguments: group.slug);
                                },
                                child: group.slug == "PAY_TV" ||
                                        group.slug == "PAID_TV"
                                    ? getItems(
                                        isDarkMode, AppSvg.cable, "Cable TV")
                                    : group.slug == "AIRTIME_AND_DATA"
                                        ? getItems(isDarkMode, AppSvg.mobile,
                                            "Mobile Data &\n Internet")
                                        : group.slug == "ELECTRIC_DISCO" ||
                                                group.slug == "DISCO"
                                            ? getItems(
                                                isDarkMode,
                                                AppSvg.electricity,
                                                "Electricity")
                                            : getItems(isDarkMode,
                                                AppSvg.betting, "Betting")),
                          )
                      ],
                    ))),
            ],
          ),
        ),
      ),
    );
  }

  Column getItems(bool isDarkMode, svg, text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(svg),
        addVerticalSpace(6.h),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Mont",
              color: isDarkMode ? AppColors.white : AppColors.black),
        ),
      ],
    );
  }
}
