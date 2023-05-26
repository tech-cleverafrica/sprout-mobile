import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprout_mobile/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/components/invoice/view/create_customer.dart';
import 'package:sprout_mobile/components/invoice/view/create_invoice.dart';
import 'package:sprout_mobile/components/invoice/view/widgets/invoice_widgets.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';

import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_images.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

import '../../../public/widgets/custom_loader.dart';
import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late InvoiceController invoiceIncontroller;

  @override
  Widget build(BuildContext context) {
    invoiceIncontroller = Get.put(InvoiceController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return SafeArea(
        child: WillPopScope(
            onWillPop: () {
              pushUntil(
                  page: BottomNav(
                index: 0,
              ));
              return Future.value(true);
            },
            child: Obx((() => invoiceIncontroller.invoice.length == 0 &&
                    invoiceIncontroller.invoiceCustomer.length == 0 &&
                    !invoiceIncontroller.showMain.value &&
                    !invoiceIncontroller.isInvoiceLoading.value &&
                    !invoiceIncontroller.isInvoiceCustomerLoading.value
                ? Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getHeader(isDarkMode),
                            addVerticalSpace(16.h),
                            addVerticalSpace(16.h),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.invoice),
                                      fit: BoxFit.contain)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  addVerticalSpace(50.h),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                        width: 205.w,
                                        child: Text(
                                          "Generate Invoices",
                                          style: TextStyle(
                                              fontFamily: "Mont",
                                              fontSize: 40.sp,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w900),
                                        )),
                                  ),
                                  addVerticalSpace(10.h),
                                  Container(
                                      height: 120.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  AppImages.invoice_overlay),
                                              fit: BoxFit.cover)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Obx((() => invoiceIncontroller
                                                        .isApproved.value &&
                                                    !invoiceIncontroller
                                                        .inReview.value
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.78,
                                                    child: CustomButton(
                                                      title: "Get Started",
                                                      color: AppColors.black,
                                                      onTap: () {
                                                        if (!invoiceIncontroller
                                                                .isInvoiceLoading
                                                                .value &&
                                                            !invoiceIncontroller
                                                                .isInvoiceCustomerLoading
                                                                .value) {
                                                          invoiceIncontroller
                                                              .showMain
                                                              .value = true;
                                                        }
                                                      },
                                                    ))
                                                : SizedBox()))
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : !invoiceIncontroller.isInvoiceLoading.value &&
                        !invoiceIncontroller.isInvoiceCustomerLoading.value
                    ? Scaffold(
                        body: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getHeader(isDarkMode),
                                addVerticalSpace(16.h),
                                getDisplaySwitch(isDarkMode),
                                addVerticalSpace(10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: invoiceIncontroller
                                              .isInvoiceDisplay.value
                                          ? MediaQuery.of(context).size.width *
                                              0.55
                                          : MediaQuery.of(context).size.width *
                                              0.88,
                                      child: CustomTextFormField(
                                        controller: invoiceIncontroller
                                            .searchController,
                                        hasPrefixIcon: true,
                                        prefixIcon: Icon(
                                          Icons.search_outlined,
                                        ),
                                        hintText: invoiceIncontroller
                                                .isInvoiceDisplay.value
                                            ? "Search your invoices"
                                            : "Search your customers",
                                        fillColor: isDarkMode
                                            ? AppColors.inputBackgroundColor
                                            : AppColors.grey,
                                        onChanged: (value) =>
                                            invoiceIncontroller
                                                    .isInvoiceDisplay.value
                                                ? invoiceIncontroller
                                                    .filterInvoices(value)
                                                : invoiceIncontroller
                                                    .filterCustomers(value),
                                        contentPaddingVertical: 17,
                                        borderRadius: 4,
                                        isDense: true,
                                      ),
                                    ),
                                    invoiceIncontroller.isInvoiceDisplay.value
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 25,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.28,
                                                alignment: Alignment.center,
                                                child: GestureDetector(
                                                  onTap: () => {
                                                    invoiceIncontroller
                                                        .showStatusList(context,
                                                            isDarkMode, theme)
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: isDarkMode
                                                          ? AppColors.mainGreen
                                                          : AppColors
                                                              .primaryColor,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 5),
                                                        Image.asset(
                                                          AppImages.filter,
                                                          height: 5,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                        SizedBox(width: 7),
                                                        Expanded(
                                                            child: Container(
                                                          child: Text(
                                                            invoiceIncontroller
                                                                .status.value,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontSize: 9.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Mont",
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.28,
                                                alignment: Alignment.center,
                                                child: GestureDetector(
                                                  onTap: () => {
                                                    invoiceIncontroller
                                                        .showTimeList(context,
                                                            isDarkMode, theme)
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: isDarkMode
                                                          ? AppColors.mainGreen
                                                          : AppColors
                                                              .primaryColor,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 5),
                                                        Image.asset(
                                                          AppImages.filter,
                                                          height: 5,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                        SizedBox(width: 7),
                                                        Expanded(
                                                            child: Container(
                                                          child: Text(
                                                            invoiceIncontroller
                                                                .time.value,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontSize: 9.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Mont",
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ))
                                                      ],
                                                    ), // )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox()
                                  ],
                                ),
                                addVerticalSpace(10.h),
                                Text(
                                  "Invoice History",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                addVerticalSpace(20.h),
                                Obx((() => buildBody(theme, isDarkMode)))
                              ],
                            ),
                          ),
                        ),
                        bottomNavigationBar: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 50, right: 50),
                          child: Obx(
                            () => CustomButton(
                                title:
                                    invoiceIncontroller.isInvoiceDisplay.value
                                        ? "Create Invoice"
                                        : "Create Customer",
                                prefixIcon: Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                ),
                                onTap: () =>
                                    invoiceIncontroller.isInvoiceDisplay.value
                                        ? push(page: CreateInvoice())
                                        : push(page: CreateCustomer())),
                          ),
                        ),
                      )
                    : Scaffold(
                        body: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getHeader(isDarkMode),
                              addVerticalSpace(15.h),
                              addVerticalSpace(16.h),
                              buildLargeShimmer()
                            ],
                          ),
                        ),
                      )))));
  }

  buildBody(theme, isDarkMode) {
    if (invoiceIncontroller.isInvoiceDisplay.value) {
      return getInvoiceList(theme, isDarkMode);
    } else {
      return getInvoiceCustomers(theme, isDarkMode);
    }
  }

  getInvoiceCustomers(theme, isDarkMode) {
    if (invoiceIncontroller.isInvoiceCustomerLoading.value) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: buildShimmer(3),
      );
    } else if (invoiceIncontroller.invoiceCustomer.length < 1) {
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
              width: 150.w,
              child: Text(
                "No customer added yet",
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
          itemCount: invoiceIncontroller.invoiceCustomer.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.greyBg,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80.w,
                            child: Text(
                              invoiceIncontroller
                                  .invoiceCustomer[index].fullName!,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 80.w,
                            child: Text(
                              invoiceIncontroller.invoiceCustomer[index].phone!,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 100.w,
                            child: Text(
                              invoiceIncontroller.invoiceCustomer[index].email!,
                              style: TextStyle(
                                fontFamily: "Mont",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () => invoiceIncontroller.showUpdateModal(
                            context,
                            isDarkMode,
                            invoiceIncontroller.invoiceCustomer[index].id!,
                            invoiceIncontroller
                                .invoiceCustomer[index].fullName!,
                            invoiceIncontroller.invoiceCustomer[index].phone!,
                            invoiceIncontroller.invoiceCustomer[index].email!,
                            invoiceIncontroller
                                .invoiceCustomer[index].address!),
                        child: Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "Edit Customer",
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  getInvoiceList(theme, isDarkMode) {
    if (invoiceIncontroller.isInvoiceLoading.value) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: buildShimmer(3),
      );
    } else if (invoiceIncontroller.invoice.length < 1) {
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
              width: 150.w,
              child: Text(
                "No history yet. Click Invoice at the bottom to get started",
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
          itemCount: invoiceIncontroller.invoice.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InvoiceCard(
              theme: theme,
              isDarkMode: isDarkMode,
              invoiceNo: invoiceIncontroller.invoice[index].invoiceNo!,
              invoiceTotalPrice: invoiceIncontroller.invoice[index].total,
              to: invoiceIncontroller.invoice[index].customer!.fullName,
              from:
                  invoiceIncontroller.invoice[index].businessInfo!.businessName,
              createdAt: invoiceIncontroller.invoice[index].createdAt,
              status: invoiceIncontroller.invoice[index].paymentStatus!,
              invoice: invoiceIncontroller.invoice[index],
              onTapDownload: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: AppColors.white,
                        child: Container(
                          height: 160.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.w, horizontal: 20.h),
                            child: Column(
                              children: [
                                SizedBox(height: 10.h),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "Download invoice as pdf to your device",
                                  style: TextStyle(
                                      fontFamily: "Mont",
                                      color: AppColors.black),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          pop();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.errorRed,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    color: AppColors.errorRed,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          var tempDir =
                                              await getTemporaryDirectory();
                                          if (invoiceIncontroller.invoice[index]
                                                      .invoicePDFUrl !=
                                                  null &&
                                              invoiceIncontroller.invoice[index]
                                                      .invoicePDFUrl !=
                                                  "") {
                                            invoiceIncontroller.download(
                                                Dio(),
                                                invoiceIncontroller
                                                    .invoice[index]
                                                    .invoicePDFUrl!,
                                                tempDir.path +
                                                    invoiceIncontroller
                                                        .invoice[index].id! +
                                                    ".pdf");
                                            pop();
                                          } else {
                                            invoiceIncontroller
                                                .downloadInvoice(
                                                    invoiceIncontroller
                                                        .invoice[index].id!)
                                                .then((value) => {
                                                      if (value != null)
                                                        {
                                                          invoiceIncontroller.download(
                                                              Dio(),
                                                              value,
                                                              tempDir.path +
                                                                  invoiceIncontroller
                                                                      .invoice[
                                                                          index]
                                                                      .id! +
                                                                  ".pdf"),
                                                          pop()
                                                        }
                                                    });
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.mainGreen,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(
                                              child: Text(
                                                "Download",
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    color: AppColors.mainGreen,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
              },
            );
          });
    }
  }

  getDisplaySwitch(bool isDarkMode) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            invoiceIncontroller.isInvoiceDisplay.value = true;
            invoiceIncontroller.reset();
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: invoiceIncontroller.isInvoiceDisplay.value
                    ? BorderRadius.circular(5)
                    : BorderRadius.circular(10),
                color: invoiceIncontroller.isInvoiceDisplay.value
                    ? isDarkMode
                        ? AppColors.greyDot
                        : AppColors.grey
                    : AppColors.transparent),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 10, left: 10),
                child: Text(
                  "Invoice",
                  style: TextStyle(
                      fontFamily: "Mont",
                      fontSize: 14.sp,
                      color: invoiceIncontroller.isInvoiceDisplay.value
                          ? isDarkMode
                              ? AppColors.white
                              : AppColors.primaryColor
                          : isDarkMode
                              ? AppColors.grey
                              : AppColors.greyText,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            invoiceIncontroller.isInvoiceDisplay.value = false;
            invoiceIncontroller.reset();
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: !invoiceIncontroller.isInvoiceDisplay.value
                    ? BorderRadius.circular(5)
                    : BorderRadius.circular(10),
                color: !invoiceIncontroller.isInvoiceDisplay.value
                    ? isDarkMode
                        ? AppColors.greyDot
                        : AppColors.grey
                    : AppColors.transparent),
            child: Center(
                child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, right: 10, left: 10),
              child: Text(
                "Customer",
                style: TextStyle(
                    fontFamily: "Mont",
                    fontSize: 14.sp,
                    color: !invoiceIncontroller.isInvoiceDisplay.value
                        ? isDarkMode
                            ? AppColors.white
                            : AppColors.primaryColor
                        : isDarkMode
                            ? AppColors.grey
                            : AppColors.greyText,
                    fontWeight: FontWeight.w700),
              ),
            )),
          ),
        ),
      ],
    );
  }
}
