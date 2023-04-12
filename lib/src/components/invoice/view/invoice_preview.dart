import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/invoice/controller/create_invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/view/success_invoice.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

// ignore: must_be_immutable
class InvoicePreviewScreen extends StatelessWidget {
  InvoicePreviewScreen({super.key});

  late CreateInvoiceController createInvoiceController;

  @override
  Widget build(BuildContext context) {
    createInvoiceController = Get.put(CreateInvoiceController());
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
                Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Invoice #1",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black),
                      ),
                      addVerticalSpace(10.h),
                      Obx((() => Text(
                            "Date: " +
                                createInvoiceController.invoiceDate.value,
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w700,
                                fontSize: 12.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          ))),
                      addVerticalSpace(10.h),
                      Obx((() => Text(
                            "Due Date: " +
                                createInvoiceController.dueDate.value,
                            style: TextStyle(
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black),
                          ))),
                      addVerticalSpace(20.h),
                      Obx((() => Container(
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? AppColors.greyDot
                                  : AppColors.greyBg,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Business:",
                                        style: TextStyle(
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: isDarkMode
                                                ? AppColors.greyText
                                                : AppColors.greyText),
                                      ),
                                      InkWell(
                                        onTap: () => {pop()},
                                        child: SvgPicture.asset(AppSvg.pendown),
                                      )
                                    ],
                                  ),
                                  addVerticalSpace(10.h),
                                  Text(
                                      createInvoiceController
                                              .info.value?.businessName ??
                                          "",
                                      style: theme.textTheme.headline6),
                                  addVerticalSpace(10.h),
                                  Text(
                                    createInvoiceController
                                            .info.value?.businessAddress ??
                                        "",
                                    style: theme.textTheme.headline6,
                                  ),
                                  addVerticalSpace(10.h),
                                  Text(createInvoiceController
                                          .info.value?.email ??
                                      ""),
                                  addVerticalSpace(10.h),
                                  Text(createInvoiceController
                                          .info.value?.phone ??
                                      ""),
                                ],
                              ),
                            ),
                          ))),
                      addVerticalSpace(5.h),
                      Obx((() => Container(
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? AppColors.greyDot
                                  : AppColors.greyBg,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "To",
                                        style: TextStyle(
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: isDarkMode
                                                ? AppColors.greyText
                                                : AppColors.greyText),
                                      ),
                                      InkWell(
                                        onTap: () => {pop()},
                                        child: SvgPicture.asset(AppSvg.pendown),
                                      )
                                    ],
                                  ),
                                  addVerticalSpace(10.h),
                                  Text(
                                      createInvoiceController
                                              .savedCustomer.value?.name ??
                                          "",
                                      style: theme.textTheme.headline6),
                                  addVerticalSpace(10.h),
                                  Text(
                                    createInvoiceController
                                            .savedCustomer.value?.address ??
                                        "",
                                    style: theme.textTheme.headline6,
                                  ),
                                  addVerticalSpace(10.h),
                                  Text(createInvoiceController
                                          .savedCustomer.value?.email ??
                                      ""),
                                  addVerticalSpace(10.h),
                                  Text(createInvoiceController
                                          .savedCustomer.value?.phone ??
                                      ""),
                                ],
                              ),
                            ),
                          ))),
                      addVerticalSpace(5.h),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Text(
                                      "NAME",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    child: Text(
                                      "QTY",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    child: Text(
                                      "PRICE/RATE",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    child: Text(
                                      "AMOUNT",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Obx((() => ListView.builder(
                                  itemCount: createInvoiceController
                                      .invoiceItems.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.20,
                                              child: Text(
                                                createInvoiceController
                                                        .invoiceItems[index]
                                                        .name ??
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.18,
                                              child: Text(
                                                createInvoiceController
                                                    .invoiceItems[index]
                                                    .quantity
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.18,
                                              child: Text(
                                                "$currencySymbol${createInvoiceController.formatter.formatAsMoney(createInvoiceController.invoiceItems[index].price ?? 0)}",
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.18,
                                              child: Text(
                                                "$currencySymbol${createInvoiceController.formatter.formatAsMoney(createInvoiceController.invoiceItems[index].amount ?? 0)}",
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
                                        createInvoiceController
                                                        .invoiceItems.length -
                                                    1 !=
                                                index
                                            ? addVerticalSpace(15.h)
                                            : SizedBox()
                                      ],
                                    );
                                  }))))
                              // addVerticalSpace(10.h),
                            ],
                          ),
                        ),
                      ),
                      addVerticalSpace(5.h),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Summary",
                                    style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: isDarkMode
                                            ? AppColors.greyText
                                            : AppColors.greyText),
                                  ),
                                ],
                              ),
                              addVerticalSpace(20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Discount"),
                                  Text(
                                      createInvoiceController
                                              .itemDiscountController.text +
                                          "%",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                              addVerticalSpace(10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tax"),
                                  Text(
                                      createInvoiceController
                                              .itemTaxController.text +
                                          "%",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                              addVerticalSpace(10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "GRAND TOTAL",
                                    style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.mainGreen),
                                  ),
                                  Obx((() => Text(
                                        "$currencySymbol${createInvoiceController.formatter.formatAsMoney(createInvoiceController.total.value)}",
                                        style: TextStyle(
                                            fontFamily: "Mont",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.black),
                                      ))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      addVerticalSpace(5.h),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment Details",
                                    style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: isDarkMode
                                            ? AppColors.greyText
                                            : AppColors.greyText),
                                  ),
                                ],
                              ),
                              addVerticalSpace(20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Account Name"),
                                  Text(
                                      StringUtils.capitalize(
                                              createInvoiceController
                                                  .info.value!.firstName!) +
                                          " " +
                                          StringUtils.capitalize(
                                              createInvoiceController
                                                  .info.value!.lastName!),
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                              addVerticalSpace(10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Account Number"),
                                  Text(
                                      createInvoiceController.info.value
                                              ?.paymentAccountNumber ??
                                          "",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                              addVerticalSpace(10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Bank Name"),
                                  Text(
                                      createInvoiceController
                                              .info.value?.bankName ??
                                          "",
                                      style: theme.textTheme.headline6),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // addVerticalSpace(10.h),
                // Container(
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 20, vertical: 20),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Signature",
                //           style: theme.textTheme.headline6,
                //         ),
                //         addVerticalSpace(10.h),
                //         SvgPicture.asset(
                //           AppSvg.signature,
                //           color: isDarkMode ? AppColors.white : AppColors.black,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // addVerticalSpace(10.h),
                // Container(
                //   width: double.infinity,
                //   height: 80.h,
                //   decoration: BoxDecoration(
                //     color: isDarkMode ? AppColors.greyDot : AppColors.greyBg,
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                // ),
                addVerticalSpace(20.h),
                DecisionButton(
                    isDarkMode: isDarkMode,
                    buttonText: "Create invoice",
                    onTap: () {
                      Get.to(() => SuccessfulInvoice());
                    }),
                addVerticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
