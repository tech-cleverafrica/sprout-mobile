import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_details_controller.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';

import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class InvoiceDetails extends StatelessWidget {
  InvoiceDetails({super.key});

  late InvoiceController invoiceController;
  late InvoiceDetailsController invoiceDetailsController;

  @override
  Widget build(BuildContext context) {
    invoiceController = Get.put(InvoiceController());
    invoiceDetailsController = Get.put(InvoiceDetailsController());
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
            Obx((() => getInfo(isDarkMode, context, theme)))
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
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 32,
                width: invoiceDetailsController.screenStatus.value == "Paid" ||
                        invoiceDetailsController.screenStatus.value ==
                            "Not Paid"
                    ? 75
                    : 95,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => {
                    invoiceDetailsController.showStatusList(
                        context, isDarkMode, theme)
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
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
                            invoiceDetailsController.screenStatus.value,
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
              Row(
                children: [
                  InkWell(
                    onTap: () => {invoiceDetailsController.sendInvoice()},
                    child: Container(
                      width: 88.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.mainGreen
                              : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppSvg.send,
                              color: AppColors.white,
                              height: 10,
                              width: 10,
                            ),
                            SizedBox(width: 7),
                            Text(
                              "Send Invoice",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Mont",
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ]),
                    ),
                  ),
                  addHorizontalSpace(10.w),
                  InkWell(
                    onTap: () async {
                      var tempDir = await getTemporaryDirectory();
                      if (invoiceDetailsController
                                  .invoice.value!.invoicePDFUrl !=
                              null &&
                          invoiceDetailsController
                                  .invoice.value!.invoicePDFUrl !=
                              "") {
                        invoiceController.download(
                            Dio(),
                            invoiceDetailsController
                                .invoice.value!.invoicePDFUrl!,
                            tempDir.path +
                                invoiceDetailsController.invoice.value!.id! +
                                ".pdf");
                      } else {
                        invoiceController
                            .downloadInvoice(
                                invoiceDetailsController.invoice.value!.id!)
                            .then((value) => {
                                  if (value != null)
                                    invoiceDetailsController
                                        .invoice.value?.invoicePDFUrl = value,
                                  {
                                    invoiceController.download(
                                        Dio(),
                                        value,
                                        tempDir.path +
                                            invoiceDetailsController
                                                .invoice.value!.id! +
                                            ".pdf"),
                                  }
                                });
                      }
                    },
                    child: Container(
                      width: 40.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppColors.mainGreen
                              : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppSvg.share,
                              color: AppColors.white,
                              height: 16,
                              width: 16,
                            ),
                          ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        addVerticalSpace(20.h),
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
                            height: invoiceDetailsController.invoice.value
                                        ?.businessInfo?.businessLogo !=
                                    null
                                ? 40
                                : 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.transparent,
                            ),
                            child: invoiceDetailsController.invoice.value
                                        ?.businessInfo?.businessLogo !=
                                    null
                                ? Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        child: Image.network(
                                          invoiceDetailsController
                                                  .invoice
                                                  .value
                                                  ?.businessInfo
                                                  ?.businessLogo ??
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
                        Text(
                            invoiceDetailsController.invoice.value?.businessInfo
                                    ?.businessName ??
                                "",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600)),
                        addVerticalSpace(10.h),
                        Text(
                            invoiceDetailsController.invoice.value?.businessInfo
                                    ?.businessAddress ??
                                "",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600)),
                        addVerticalSpace(10.h),
                        Text(
                            invoiceDetailsController
                                    .invoice.value?.businessInfo?.email ??
                                "",
                            style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w600)),
                        addVerticalSpace(10.h),
                        Text(
                            invoiceDetailsController
                                    .invoice.value?.businessInfo?.phone ??
                                "",
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
                  Text(
                      invoiceDetailsController
                              .invoice.value?.customer?.fullName ??
                          "",
                      style: TextStyle(
                        color:
                            isDarkMode ? AppColors.greyDot : AppColors.greyText,
                        fontFamily: "DMSans",
                      )),
                  addVerticalSpace(10.h),
                  Text(
                      invoiceDetailsController
                              .invoice.value?.customer?.address ??
                          "",
                      style: TextStyle(
                        color:
                            isDarkMode ? AppColors.greyDot : AppColors.greyText,
                        fontFamily: "DMSans",
                      )),
                  addVerticalSpace(10.h),
                  Text(
                      invoiceDetailsController.invoice.value?.customer?.email ??
                          "",
                      style: TextStyle(
                        color:
                            isDarkMode ? AppColors.greyDot : AppColors.greyText,
                        fontFamily: "DMSans",
                      )),
                  addVerticalSpace(10.h),
                  Text(
                      invoiceDetailsController.invoice.value?.customer?.phone ??
                          "",
                      style: TextStyle(
                        color:
                            isDarkMode ? AppColors.greyDot : AppColors.greyText,
                        fontFamily: "DMSans",
                      )),
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
                    itemCount: invoiceDetailsController
                        .invoice.value?.invoiceContent?.length,
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
                                  invoiceDetailsController.invoice.value
                                          ?.invoiceContent![index].itemTitle ??
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
                                  invoiceDetailsController.invoice.value!
                                      .invoiceContent![index].itemQuantity
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
                                  "$currencySymbol${invoiceController.formatter.formatAsMoney(double.parse(invoiceDetailsController.invoice.value!.invoiceContent![index].itemUnitPrice.toString()))}",
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
                                  "$currencySymbol${invoiceController.formatter.formatAsMoney(double.parse(invoiceDetailsController.invoice.value!.invoiceContent![index].itemTotalPrice.toString()))}",
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
                          invoiceDetailsController.invoice.value!
                                          .invoiceContent!.length -
                                      1 !=
                                  index
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
                        double.parse(invoiceDetailsController
                                    .invoice.value!.discount
                                    .toString())
                                .toString() +
                            "%",
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax"),
                    Text(
                        double.parse(invoiceDetailsController.invoice.value!.tax
                                    .toString())
                                .toString() +
                            "%",
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "INVOICE AMOUNT",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.mainGreen),
                    ),
                    Text(
                      "$currencySymbol${invoiceController.formatter.formatAsMoney(double.parse(invoiceDetailsController.invoice.value!.total.toString()))}",
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                          color:
                              isDarkMode ? AppColors.white : AppColors.black),
                    ),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "AMOUNT DUE",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.mainGreen),
                    ),
                    Text(
                      "$currencySymbol${invoiceController.formatter.formatAsMoney(invoiceDetailsController.amountDue.value)}",
                      style: TextStyle(
                          fontFamily: "Mont",
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
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
                        StringUtils.capitalize(invoiceDetailsController
                                .invoice.value!.businessInfo!.firstName!) +
                            " " +
                            StringUtils.capitalize(invoiceDetailsController
                                .invoice.value!.businessInfo!.lastName!),
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Account Number"),
                    Text(
                        invoiceDetailsController.invoice.value!.businessInfo!
                                .paymentAccountNumber ??
                            "",
                        style: theme.textTheme.headline6),
                  ],
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bank Name"),
                    Text(
                        invoiceDetailsController
                                .invoice.value!.businessInfo!.bankName ??
                            "",
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
