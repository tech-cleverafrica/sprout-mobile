import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/home/view/widgets.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/view/create_invoice.dart';
import 'package:sprout_mobile/src/components/invoice/view/widgets/invoice_widgets.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';

import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';

import '../../../public/widgets/custom_loader.dart';
import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class AllInvoiceScreen extends StatelessWidget {
  AllInvoiceScreen({super.key});

  late InvoiceController invoiceIncontroller;

  @override
  Widget build(BuildContext context) {
    invoiceIncontroller = Get.put(InvoiceController());
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
                addVerticalSpace(16.h),
                getDisplaySwitch(isDarkMode),
                addVerticalSpace(16.h),
                CustomTextFormField(
                  hasPrefixIcon: true,
                  prefixIcon: Icon(Icons.search_outlined),
                  hintText: "Search your invoices",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
                addVerticalSpace(20.h),
                Text(
                  "Invoice History",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                addVerticalSpace(20.h),
                invoiceIncontroller.invoice.value.length < 1
                    ? Center(
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
                              width: 150.w,
                              child: Text(
                                "No history yet. Click Invoice at the top to get started",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.greyText
                                        : AppColors.black),
                              ),
                            )
                          ],
                        ),
                      )
                    : Obx((() => getInvoiceList(theme, isDarkMode)))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 50, right: 50),
          child: CustomButton(
            title: "Create Invoice",
            prefixIcon: Icon(
              Icons.add,
              color: AppColors.white,
            ),
            onTap: () {
              Get.to(() => CreateInvoice());
            },
          ),
        ),
      ),
    );
  }

  getInvoiceList(theme, isDarkMode) {
    if (invoiceIncontroller.isInvoiceLoading.value) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: buildShimmer(3),
      );
    } else {
      return ListView.builder(
          itemCount: invoiceIncontroller.invoice.value.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InvoiceCard(
              theme: theme,
              isDarkMode: isDarkMode,
              invoiceNo: invoiceIncontroller.invoice.value[index].invoiceNo!,
              invoiceTotalPrice: invoiceIncontroller.invoice.value[index].total,
              to: invoiceIncontroller.invoice.value[index].customer!.fullName,
              from: invoiceIncontroller
                  .invoice.value[index].businessInfo!.businessName,
              createdAt: invoiceIncontroller.invoice.value[index].createdAt,
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
                  "Invoice",
                  style: TextStyle(
                      fontFamily: "DmSans",
                      fontSize: 14.sp,
                      color:
                          isDarkMode ? AppColors.white : AppColors.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 10, left: 10),
                  child: Text(
                    "Draft",
                    style: TextStyle(
                        fontFamily: "DmSans",
                        fontSize: 14.sp,
                        color: isDarkMode ? AppColors.grey : AppColors.greyText,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
