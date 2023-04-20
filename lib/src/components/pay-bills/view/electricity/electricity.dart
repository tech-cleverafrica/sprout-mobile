import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/pay-bills/controller/billers_controller.dart';
import 'package:sprout_mobile/src/components/pay-bills/view/electricity/select_electricity_package.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../../public/widgets/custom_text_form_field.dart';
import '../../../../utils/app_colors.dart';

// ignore: must_be_immutable
class ElectricityScreen extends StatelessWidget {
  ElectricityScreen({super.key});

  late BillersController billersController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    billersController = Get.put(BillersController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(20),
              CustomTextFormField(
                hasPrefixIcon: true,
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Search your bills",
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
                  : Expanded(
                      child: ListView.builder(
                        itemCount: billersController.billers.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Column(
                          children: [
                            addVerticalSpace(30.h),
                            BillsCard(
                              title: billersController.billers[index].name,
                              subTitle: "Disco Payment",
                              image: AppImages.logo_icon,
                              onTap: () {
                                push(
                                    page: SelectElectricityPackageScreen(),
                                    arguments:
                                        billersController.billers[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ))),
            ],
          ),
        ),
      ),
    );
  }
}

class BillsCard extends StatelessWidget {
  const BillsCard({Key? key, this.title, this.subTitle, this.image, this.onTap})
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
                              fontFamily: "Mont",
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black),
                        ),
                        Text(
                          subTitle!,
                          style: TextStyle(
                              fontFamily: "Mont",
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
