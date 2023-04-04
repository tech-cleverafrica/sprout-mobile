import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprout_mobile/src/components/home/view/widgets.dart';
import 'package:sprout_mobile/src/components/invoice/controller/invoice_controller.dart';
import 'package:sprout_mobile/src/components/invoice/view/create_customer.dart';
import 'package:sprout_mobile/src/components/invoice/view/create_invoice.dart';
import 'package:sprout_mobile/src/components/invoice/view/invoice_details.dart';
import 'package:sprout_mobile/src/components/invoice/view/widgets/invoice_widgets.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';

import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../public/widgets/custom_loader.dart';
import '../../../public/widgets/custom_text_form_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class AllInvoiceScreen extends StatefulWidget {
  AllInvoiceScreen({super.key});

  @override
  State<AllInvoiceScreen> createState() => _AllInvoiceScreenState();
}

class _AllInvoiceScreenState extends State<AllInvoiceScreen> {
  late InvoiceController invoiceIncontroller;

  // Track the progress of a downloaded file here.
  double progress = 0;

  // Track if the PDF was downloaded here.
  bool didDownloadPDF = false;

  // Show the progress status to the user.
  String progressString = 'File has not been downloaded yet.';

  // This method uses Dio to download a file from the given URL
  Future download(Dio dio, String url, String savePath) async {
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: updateProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      var file = File(savePath).openSync(mode: FileMode.write);
      file.writeFromSync(response.data);
      await file.close();

      // Here, you're catching an error and printing it. For production
      // apps, you should display the warning to the user and give them a
      // way to restart the download.
    } catch (e) {
      print(e);
    }
  }

  // You can update the download progress here so that the user is
  void updateProgress(done, total) {
    progress = done / total;
    setState(() {
      if (progress >= 1) {
        progressString =
            '✅ File has finished downloading. Try opening the file.';
        didDownloadPDF = true;
      } else {
        progressString = 'Download progress: ' +
            (progress * 100).toStringAsFixed(0) +
            '% done.';
      }
    });
  }

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
                Obx((() => buildBody(theme, isDarkMode)))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 50, right: 50),
          child: Obx(
            () => CustomButton(
                title: invoiceIncontroller.isInvoiceDisplay.value
                    ? "Create Invoice"
                    : "Create Customer",
                prefixIcon: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
                onTap: () => invoiceIncontroller.isInvoiceDisplay.value
                    ? push(page: CreateInvoice())
                    : push(page: CreateCustomer())),
          ),
        ),
      ),
    );
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
          itemCount: invoiceIncontroller.invoiceCustomer.value.length,
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
                                  .invoiceCustomer.value[index].fullName!,
                              style: TextStyle(
                                  fontFamily: "DMSans",
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
                              invoiceIncontroller
                                  .invoiceCustomer.value[index].phone!,
                              style: TextStyle(
                                  fontFamily: "DMSans",
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
                              invoiceIncontroller
                                  .invoiceCustomer.value[index].email!,
                              style: TextStyle(
                                fontFamily: "DMSans",
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
                            invoiceIncontroller
                                .invoiceCustomer.value[index].id!,
                            invoiceIncontroller
                                .invoiceCustomer.value[index].fullName!,
                            invoiceIncontroller
                                .invoiceCustomer.value[index].phone!,
                            invoiceIncontroller
                                .invoiceCustomer.value[index].email!,
                            invoiceIncontroller
                                .invoiceCustomer.value[index].address!),
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
                                    fontFamily: "DMSans",
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
                "No history yet. Click Invoice at the top to get started",
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
              status: invoiceIncontroller.invoice.value[index].paymentStatus!,
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
                                      fontFamily: "DMSans",
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
                                                    fontFamily: "Outfit",
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
                                          download(
                                              Dio(),
                                              invoiceIncontroller.invoice
                                                  .value[index].invoicePDFUrl!,
                                              tempDir.path +
                                                  invoiceIncontroller.invoice
                                                      .value[index].id!);
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
                                                    fontFamily: "Outfit",
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
          },
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
          onTap: () {
            invoiceIncontroller.isInvoiceDisplay.value = false;
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 10, left: 10),
                  child: Text(
                    "Customer",
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
