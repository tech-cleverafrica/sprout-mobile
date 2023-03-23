import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/buy-airtime/view/buy_airtime.dart';
import 'package:sprout_mobile/src/components/invoice/view/invoice_preview.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_dropdown_button_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';

class CreateInvoice extends StatelessWidget {
  const CreateInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
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
                  label: "Invoice Number/Name",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                CustomTextFormField(
                  label: "Subject",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomDropdownButtonFormField(
                      label: "Due Date (Optional)",
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                      items: [],
                    )),
                    addHorizontalSpace(10.w),
                    Expanded(
                        child: CustomDropdownButtonFormField(
                      label: "Due Date (Optional)",
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                      items: [],
                    )),
                  ],
                ),
                addVerticalSpace(15.h),
                Text(
                  "Bill To:",
                  style: theme.textTheme.headline6,
                ),
                addVerticalSpace(15.h),
                InkWell(
                  onTap: () {
                    showAddCustomer(context, isDarkMode, theme);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppSvg.add,
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      addHorizontalSpace(5.w),
                      Text(
                        "Add Customer",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: isDarkMode ? AppColors.white : AppColors.black,
                ),
                addVerticalSpace(15.h),
                Text(
                  "Item:",
                  style: theme.textTheme.headline6,
                ),
                addVerticalSpace(15.h),
                InkWell(
                  onTap: () {
                    showAddItem(context, isDarkMode, theme);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(AppSvg.add,
                          color:
                              isDarkMode ? AppColors.white : AppColors.black),
                      addHorizontalSpace(5.w),
                      Text(
                        "Add Item",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: isDarkMode ? AppColors.white : AppColors.black,
                ),
                addVerticalSpace(30.h),
                Text(
                  "Summary",
                  style: theme.textTheme.headline6,
                ),
                addVerticalSpace(15.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          ),
                          Text(
                            "N20000",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          )
                        ],
                      ),
                      Divider(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      addVerticalSpace(15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "TAX",
                                style: TextStyle(
                                    fontFamily: "DMSans",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black),
                              ),
                              addHorizontalSpace(5.w),
                              Container(
                                height: 30,
                                child: Switch(
                                  activeColor: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              )
                            ],
                          ),
                          Text(
                            "7.5% VAT",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          )
                        ],
                      ),
                      Divider(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      addVerticalSpace(15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          ),
                          Text(
                            "N25000",
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          )
                        ],
                      ),
                      Divider(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(20.h),
                CustomTextFormField(
                  label: "Notes",
                  maxLines: 5,
                  maxLength: 250,
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                Divider(
                  color: isDarkMode ? AppColors.white : AppColors.black,
                ),
                addVerticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Signature",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color:
                              isDarkMode ? AppColors.white : AppColors.black),
                    ),
                    addHorizontalSpace(5.w),
                    Container(
                      height: 30,
                      child: CupertinoSwitch(
                        activeColor:
                            isDarkMode ? AppColors.white : AppColors.black,
                        value: false,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
                addVerticalSpace(20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomButton(
                    title: "Continue",
                    onTap: () {
                      Get.to(() => InvoicePreviewScreen());
                    },
                  ),
                ),
                addVerticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAddItem(context, isDarkMode, theme) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return Dialog(
            backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 450.h,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cancel",
                          style: theme.textTheme.headline6,
                        ),
                        InkWell(
                            onTap: () => Get.back(),
                            child: SvgPicture.asset(AppSvg.cancel))
                      ],
                    ),
                    addVerticalSpace(10.h),
                    CustomTextFormField(
                      label: "Item",
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                    ),
                    CustomTextFormField(
                      label: "Quantity",
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                    ),
                    CustomTextFormField(
                      label: "Price/Rate",
                      fillColor: isDarkMode
                          ? AppColors.inputBackgroundColor
                          : AppColors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add New",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SvgPicture.asset(AppSvg.add)
                      ],
                    ),
                    addVerticalSpace(15.h),
                    CustomButton(
                      title: "Done",
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }

  showAddCustomer(context, isDarkMode, theme) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return Dialog(
            backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 570.h,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cancel",
                            style: theme.textTheme.headline6,
                          ),
                          InkWell(
                              onTap: () => Get.back(),
                              child: SvgPicture.asset(AppSvg.cancel))
                        ],
                      ),
                      addVerticalSpace(10.h),
                      CustomTextFormField(
                        label: "Customer Name",
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                      ),
                      CustomTextFormField(
                        label: "Phone Number",
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                      ),
                      CustomTextFormField(
                        label: "Email Address",
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                      ),
                      addVerticalSpace(15.h),
                      CustomButton(
                        title: "Done",
                        onTap: () {},
                      ),
                      addVerticalSpace(20.h),
                      Text(
                        "Select From Your Contact",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w700,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                            fontSize: 12.sp),
                      ),
                      addVerticalSpace(9.h),
                      getRecentContacts(isDarkMode)
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
