import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/components/save/controller/all_savings_controller.dart';
import 'package:sprout_mobile/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/global_function.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';

import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class AllSavingsScreen extends StatelessWidget {
  AllSavingsScreen({super.key});

  late AllSavingsController allSavingsController;

  @override
  Widget build(BuildContext context) {
    allSavingsController = Get.put(AllSavingsController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode),
                addVerticalSpace(15.h),
                CustomTextFormField(
                  hintText: "Search your savings",
                  hasPrefixIcon: true,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                  ),
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                  onChanged: (value) =>
                      allSavingsController.filterSavings(value),
                  contentPaddingVertical: 17,
                  borderRadius: 4,
                  isDense: true,
                ),
                addVerticalSpace(20.h),
                Obx((() => allSavingsController.isSavingsLoading.value
                    ? buildShimmer(3)
                    : ListView.builder(
                        itemCount: allSavingsController.savings.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: InkWell(
                              onTap: () {
                                print("WORKED1");
                              },
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      allSavingsController
                                          .savings[index].portfolioName!,
                                      style: TextStyle(
                                          fontFamily: "Mont",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: isDarkMode
                                              ? AppColors.inputLabelColor
                                              : AppColors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          allSavingsController
                                                  .savings[index].visible!
                                              ? "$currencySymbol${allSavingsController.formatter.formatAsMoney(allSavingsController.savings[index].currentAmount!.toDouble())}"
                                              : "*****",
                                          style: TextStyle(
                                              fontFamily: "Mont",
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color: isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.black),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            allSavingsController.setVisibility(
                                                allSavingsController
                                                    .savings[index].id!);
                                          },
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            decoration: BoxDecoration(
                                                color: isDarkMode
                                                    ? AppColors.greyDot
                                                    : AppColors.greyBg,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                  CommunityMaterialIcons
                                                      .eye_off_outline,
                                                  size: 18,
                                                  color: isDarkMode
                                                      ? AppColors.greyText
                                                      : AppColors.greyText),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    addVerticalSpace(10.h),
                                    Divider()
                                  ],
                                ),
                              ),
                            ),
                          );
                        }))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
