import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/controller/billers_controller.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/internet/select_bundle.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../../public/widgets/custom_text_form_field.dart';
import '../../../../utils/app_colors.dart';

// ignore: must_be_immutable
class InternetDataScreen extends StatelessWidget {
  InternetDataScreen({super.key});

  late BillersController billersController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    billersController = Get.put(BillersController());
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              CustomTextFormField(
                hasPrefixIcon: true,
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Search your bundle",
                fillColor: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.grey,
                onChanged: (value) => billersController.filterBillers(value),
              ),
              Obx((() => billersController.loading.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: buildSlimShimmer(4),
                    )
                  : ListView.builder(
                      itemCount: billersController.billers.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Column(
                        children: [
                          addVerticalSpace(30.h),
                          InternetBillsCard(
                            title: billersController.billers[index].name,
                            subTitle: "Internet Data",
                            image: billersController.billers[index].slug ==
                                    "MTN_NIGERIA"
                                ? AppImages.mtn
                                : billersController.billers[index].slug ==
                                        "AIRTEL_NIGERIA"
                                    ? AppImages.airtel
                                    : billersController.billers[index].slug ==
                                            "GLO_NIGERIA"
                                        ? AppImages.glo
                                        : billersController
                                                    .billers[index].slug ==
                                                "9MOBILE_NIGERIA"
                                            ? AppImages.nine_mobile
                                            : billersController
                                                        .billers[index].slug ==
                                                    "SMILE"
                                                ? AppImages.smile
                                                : billersController
                                                            .billers[index]
                                                            .slug ==
                                                        "IPNX"
                                                    ? AppImages.ipnx
                                                    : AppImages.logo_icon,
                            onTap: () {
                              push(
                                  page: SelectBundleScreen(),
                                  arguments: billersController.billers[index]);
                            },
                          ),
                        ],
                      ),
                    ))),
            ],
          ),
        ),
      ),
    ));
  }
}

class InternetBillsCard extends StatelessWidget {
  const InternetBillsCard(
      {Key? key, this.title, this.subTitle, this.image, this.onTap})
      : super(key: key);
  final String? title;
  final String? image;
  final String? subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      image!,
                      height: 30,
                      width: 30,
                    ),
                    addHorizontalSpace(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title!,
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black),
                        ),
                        Text(
                          subTitle!,
                          style: TextStyle(
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              color: isDarkMode
                                  ? AppColors.greyText
                                  : AppColors.greyText),
                        )
                      ],
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward,
                  color: isDarkMode
                      ? AppColors.inputLabelColor
                      : AppColors.inputLabelColor,
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
