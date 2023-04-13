import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';

import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class InvoiceDetails extends StatelessWidget {
  Invoice? invoice;
  InvoiceDetails({super.key, required this.invoice});

  late InvoiceController invoiceController;

  @override
  Widget build(BuildContext context) {
    invoiceController = Get.put(InvoiceController());
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
            getInfo(isDarkMode, context, theme)
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? AppColors.greyDot
                  : Color.fromRGBO(61, 2, 230, 0.1)),
          child: Container(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                            height: invoice?.businessInfo?.businessLogo != null
                                ? 40
                                : 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.transparent,
                            ),
                            child: invoice?.businessInfo?.businessLogo != null
                                ? Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        child: Image.network(
                                          invoice?.businessInfo?.businessLogo ??
                                              "",
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              loadingProgress == null
                                                  ? child
                                                  : Container(
                                                      height: 40,
                                                      width: 40,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor,
                                                      ),
                                                      child: SpinKitThreeBounce(
                                                        color: isDarkMode
                                                            ? AppColors.white
                                                            : AppColors
                                                                .primaryColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox())),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(invoice?.businessInfo?.businessName ?? "",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600)),
                        addVerticalSpace(10.h),
                        Text(invoice?.businessInfo?.businessAddress ?? "",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600)),
                        addVerticalSpace(10.h),
                        Text(invoice?.businessInfo?.email ?? "",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600)),
                        addVerticalSpace(10.h),
                        Text(invoice?.businessInfo?.phone ?? "",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                )),
          ),
        ),
        addVerticalSpace(20.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode ? AppColors.greyDot : AppColors.greyBg),
          child: Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Billed To",
                      style: TextStyle(
                          color: isDarkMode ? AppColors.white : AppColors.black,
                          fontFamily: "DMSans",
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text(invoice?.customer?.fullName ?? "",
                      style: TextStyle(
                          color: isDarkMode
                              ? AppColors.greyDot
                              : AppColors.greyText,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text(invoice?.customer?.address ?? "",
                      style: TextStyle(
                          color: isDarkMode
                              ? AppColors.greyDot
                              : AppColors.greyText,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text(invoice?.customer?.email ?? "",
                      style: TextStyle(
                          color: isDarkMode
                              ? AppColors.greyDot
                              : AppColors.greyText,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                  addVerticalSpace(10.h),
                  Text(invoice?.customer?.phone ?? "",
                      style: TextStyle(
                          color: isDarkMode
                              ? AppColors.greyDot
                              : AppColors.greyText,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
        addVerticalSpace(20.h),
        Text("Invoice Information",
            style: TextStyle(
                color: isDarkMode ? AppColors.white : AppColors.black,
                fontFamily: "DMSans",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text(
                        "NAME",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: Text(
                        "QTY",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: Text(
                        "PRICE/RATE",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: Text(
                        "AMOUNT",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                Divider(),
                ListView.builder(
                    itemCount: invoice?.invoiceContent?.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text(
                                  invoice?.invoiceContent![index].itemTitle ??
                                      "",
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Text(
                                  invoice!.invoiceContent![index].itemQuantity
                                      .toString(),
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Text(
                                  "$currencySymbol${invoiceController.formatter.formatAsMoney(double.parse(invoice!.invoiceContent![index].itemUnitPrice.toString()))}",
                                  style: TextStyle(
                                      fontFamily: "Monts",
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.18,
                                child: Text(
                                  "$currencySymbol${invoiceController.formatter.formatAsMoney(double.parse(invoice!.invoiceContent![index].itemTotalPrice.toString()))}",
                                  style: TextStyle(
                                      fontFamily: "Monts",
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          invoice!.invoiceContent!.length - 1 != index
                              ? addVerticalSpace(15.h)
                              : SizedBox()
                        ],
                      );
                    }))
                // addVerticalSpace(10.h),
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
                  "Summary",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color:
                          isDarkMode ? AppColors.greyText : AppColors.greyText),
                ),
                addVerticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount"),
                    Text(
                        double.parse(invoice!.discount.toString()).toString() +
                            "%",
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax"),
                    Text(double.parse(invoice!.tax.toString()).toString() + "%",
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "GRAND TOTAL",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: AppColors.mainGreen),
                    ),
                    Text(
                      "$currencySymbol${invoiceController.formatter.formatAsMoney(double.parse(invoice!.total.toString()))}",
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color:
                              isDarkMode ? AppColors.white : AppColors.black),
                    ),
                  ],
                )
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
                  "Payment Details",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color:
                          isDarkMode ? AppColors.greyText : AppColors.greyText),
                ),
                addVerticalSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Account Name"),
                    Text(
                        StringUtils.capitalize(
                                invoice!.businessInfo!.firstName!) +
                            " " +
                            StringUtils.capitalize(
                                invoice!.businessInfo!.lastName!),
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Account Number"),
                    Text(invoice!.businessInfo!.paymentAccountNumber ?? "",
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bank Name"),
                    Text(invoice!.businessInfo!.bankName ?? "",
                        style: theme.textTheme.headline6),
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
