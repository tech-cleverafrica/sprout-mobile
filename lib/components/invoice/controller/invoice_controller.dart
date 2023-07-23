import 'dart:io';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/components/invoice/model/invoice_customer_model.dart';
import 'package:sprout_mobile/components/invoice/model/invoice_detail_model.dart';
import 'package:sprout_mobile/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/components/invoice/service/invoice_service.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/public/model/date_range.dart';
import 'package:sprout_mobile/public/services/date_service.dart';
import 'package:sprout_mobile/public/services/shared_service.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/app_formatter.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

import '../../../api-setup/api_setup.dart';
import '../../../api/api_response.dart';
import '../../../public/widgets/custom_button.dart';
import '../../../public/widgets/custom_text_form_field.dart';
import '../../../public/widgets/custom_toast_notification.dart';
import '../../../utils/helper_widgets.dart';

class InvoiceController extends GetxController {
  final storage = GetStorage();
  final AppFormatter formatter = Get.put(AppFormatter());
  TextEditingController searchController = new TextEditingController();

  TextEditingController updateCustomerNameController =
      new TextEditingController();
  TextEditingController updateCustomerPhoneController =
      new TextEditingController();
  TextEditingController updateCustomerEmailController =
      new TextEditingController();
  TextEditingController updateCustomerAddressController =
      new TextEditingController();

  RxList<InvoiceRespose> invoiceResponse = <InvoiceRespose>[].obs;
  RxList<Invoice> invoice = <Invoice>[].obs;
  RxList<Invoice> baseInvoice = <Invoice>[].obs;

  RxList<InvoiceCustomerResponse> invoiceCustomerResponse =
      <InvoiceCustomerResponse>[].obs;
  RxList<InvoiceCustomer> invoiceCustomer = <InvoiceCustomer>[].obs;
  RxList<InvoiceCustomer> baseInvoiceCustomer = <InvoiceCustomer>[].obs;

  InvoiceDetail? invoiceDetail;
  RxBool isInvoiceLoading = false.obs;
  RxBool isInvoiceCustomerLoading = false.obs;
  RxBool isSingleInvoiceLoading = false.obs;
  RxBool isInvoiceDisplay = true.obs;
  RxBool showMain = false.obs;
  RxBool isApproved = false.obs;
  RxBool inReview = false.obs;

  // Track the progress of a downloaded file here.
  double progress = 0;
  // Track if the PDF was downloaded here.
  bool didDownloadPDF = false;
  // Show the progress status to the user.
  String progressString = 'File has not been downloaded yet.';

  List<String> statuses = ["All", "Partial Payment", "Paid", "Not Paid"];
  List<String> times = [
    "All Time",
    "Today",
    "Yesterday",
    "This week",
    "Last week",
    "This month",
    "Last month"
  ];
  RxString status = "All".obs;
  RxString time = "All Time".obs;
  String statusFilter = "all";
  Map<String, dynamic> timeFilter = {"startDate": null, "endDate": null};

  @override
  void onInit() {
    fetchUserInvoices(false);
    fetchInvoiceCustomers();
    String approvalStatus = storage.read("approvalStatus");
    isApproved.value = approvalStatus == "APPROVED" ? true : false;
    inReview.value = approvalStatus == "IN_REVIEW" ? true : false;
    super.onInit();
  }

  fetchUserInvoices(bool refresh) async {
    reset();
    if (!refresh) {
      isInvoiceLoading.value = true;
    }
    AppResponse<List<Invoice>> invoiceResponse = await locator
        .get<InvoiceService>()
        .getInvoices(statusFilter, timeFilter);
    isInvoiceLoading.value = false;
    if (invoiceResponse.status) {
      invoice.assignAll(invoiceResponse.data!);
      baseInvoice.assignAll(invoiceResponse.data!);
    } else if (invoiceResponse.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        fetchUserInvoices(refresh);
      }
    } else {
      CustomToastNotification.show(invoiceResponse.message,
          type: ToastType.error);
      pushUntil(page: BottomNav());
    }
  }

  Future<dynamic> fetchInvoiceCustomers() async {
    reset();
    isInvoiceCustomerLoading.value = true;
    AppResponse<List<InvoiceCustomer>> invoiceCustomerResponse =
        await locator.get<InvoiceService>().getInvoiceCustomer();
    isInvoiceCustomerLoading.value = false;
    if (invoiceCustomerResponse.status) {
      invoiceCustomer.assignAll(invoiceCustomerResponse.data!);
      baseInvoiceCustomer.assignAll(invoiceCustomerResponse.data!);
      return true;
    } else if (invoiceCustomerResponse.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        fetchInvoiceCustomers();
      }
    }
    return null;
  }

  fetchSingleInvoice(String invoiceId) async {
    isSingleInvoiceLoading.value = true;
    AppResponse appResponse =
        await locator.get<InvoiceService>().getInvoice(invoiceId);
    isSingleInvoiceLoading.value = false;
    if (appResponse.status) {
      invoiceDetail = InvoiceDetail.fromJson(appResponse.data['data']);
    } else if (appResponse.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        fetchSingleInvoice(invoiceId);
      }
    }
  }

  Future<dynamic> downloadInvoice(String invoiceId) async {
    AppResponse response =
        await locator.get<InvoiceService>().downloadInvoice(invoiceId);
    isSingleInvoiceLoading.value = false;
    if (response.status) {
      fetchUserInvoices(true);
      return response.data["data"];
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        downloadInvoice(invoiceId);
      }
    }
    return null;
  }

  buildCustomerRequest() {
    return {
      "fullName": updateCustomerNameController.text,
      "email": updateCustomerEmailController.text,
      "address": updateCustomerAddressController.text,
      "phone": updateCustomerPhoneController.text
    };
  }

  validateCustomerUpdate(String id) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (updateCustomerNameController.text.length > 1 &&
        updateCustomerPhoneController.text.length == 11 &&
        updateCustomerEmailController.text.isNotEmpty &&
        updateCustomerAddressController.text.length > 5 &&
        (regex.hasMatch(updateCustomerEmailController.text))) {
      updateCustomer(id);
    } else if (updateCustomerNameController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Customer Name is required"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerNameController.text.length < 2) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Customer Name is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number is required"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerPhoneController.text.length < 11) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Phone number should ber 11 digits"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerEmailController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Email is required"),
          backgroundColor: AppColors.errorRed));
    } else if (!(regex.hasMatch(updateCustomerEmailController.text))) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid email"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerAddressController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address is required"),
          backgroundColor: AppColors.errorRed));
    } else if (updateCustomerAddressController.text.length < 6) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Address is too short"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  updateCustomer(String customerId) async {
    AppResponse appResponse = await locator
        .get<InvoiceService>()
        .updateCustomer(buildCustomerRequest(), customerId);
    if (appResponse.status) {
      CustomToastNotification.show(appResponse.message,
          type: ToastType.success);
      pop();
      fetchInvoiceCustomers();
    } else {
      CustomToastNotification.show(appResponse.message, type: ToastType.error);
    }
  }

  filterInvoices(String value) {
    invoice.value = value == ""
        ? baseInvoice
        : baseInvoice
            .where((i) =>
                i.invoiceNo!.toLowerCase().contains(value.toLowerCase()) ||
                i.customer!.fullName!
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                i.businessInfo!.businessName!
                    .toLowerCase()
                    .contains(value.toLowerCase()))
            .toList();
  }

  filterCustomers(String value) {
    invoiceCustomer.value = value == ""
        ? baseInvoiceCustomer
        : baseInvoiceCustomer
            .where(
                (i) => i.fullName!.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }

  reset() {
    searchController = new TextEditingController(text: "");
    invoice.value = baseInvoice;
    invoiceCustomer.value = baseInvoiceCustomer;
  }

  showUpdateModal(context, isDarkMode, String id, String fullName, String phone,
      String email, String address) {
    updateCustomerNameController = new TextEditingController(text: fullName);
    updateCustomerPhoneController = new TextEditingController(text: phone);
    updateCustomerEmailController = new TextEditingController(text: email);
    updateCustomerAddressController = new TextEditingController(text: address);
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: StatefulBuilder(builder: (BuildContext context,
                StateSetter setModalState /*You can rename this!*/) {
              return Container(
                decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.greyDot : AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        Center(
                          child: Text(
                            "Update Customer info",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 14.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        CustomTextFormField(
                          controller: updateCustomerNameController,
                          label: "Customer Name",
                          hintText: "Enter Customer Name",
                          textInputAction: TextInputAction.next,
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Customer Name is required";
                            else if (value.length < 2)
                              return "Customer Name is too short";
                            return null;
                          },
                        ),
                        CustomTextFormField(
                            controller: updateCustomerPhoneController,
                            label: "Phone Number",
                            hintText: "Enter Phone Number",
                            maxLength: 11,
                            showCounterText: false,
                            maxLengthEnforced: true,
                            fillColor: isDarkMode
                                ? AppColors.inputBackgroundColor
                                : AppColors.grey,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[0-9]*$'))
                            ],
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.phone,
                            validator: (value) {
                              if (value!.length == 0)
                                return "Phone number is required";
                              else if (value.length < 11)
                                return "Phone number should be 11 digits";
                              return null;
                            }),
                        CustomTextFormField(
                          controller: updateCustomerEmailController,
                          label: "Email",
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          hintText: "davejossy9@gmail.com",
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) =>
                              EmailValidator.validate(value ?? "")
                                  ? null
                                  : "Please enter a valid email",
                        ),
                        CustomTextFormField(
                          controller: updateCustomerAddressController,
                          maxLines: 2,
                          maxLength: 250,
                          label: "Enter Address",
                          hintText: "Address",
                          maxLengthEnforced: true,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Address is required";
                            else if (value.length < 6)
                              return "Address is too short";
                            return null;
                          },
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                        ),
                        addVerticalSpace(40.h),
                        CustomButton(
                          title: "Update Customer",
                          onTap: () {
                            validateCustomerUpdate(id);
                          },
                        ),
                        SizedBox(
                          height: 36.h,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }

  showStatusList(context, isDarkMode, theme) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.greyDot : AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 17.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 20.w),
                            child: Text(
                              "Select Status",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: statuses.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                  onTap: () {
                                    pop();
                                    status.value = statuses[index];
                                    if (statuses[index] == "All") {
                                      statusFilter = "all";
                                    } else if (statuses[index] ==
                                        "Partial Payment") {
                                      statusFilter = "PARTIAL_PAYMENT";
                                    } else if (statuses[index] == "Paid") {
                                      statusFilter = "PAID";
                                    } else if (statuses[index] == "Not Paid") {
                                      statusFilter = "NOT_PAID";
                                    }
                                    fetchUserInvoices(true);
                                  },
                                  child: Obx((() => Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode
                                                ? AppColors.inputBackgroundColor
                                                : AppColors.grey,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 16.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      statuses[index],
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontSize: 12.sp,
                                                          fontWeight: status
                                                                          .value !=
                                                                      "" &&
                                                                  status.value ==
                                                                      statuses[
                                                                          index]
                                                              ? FontWeight.w700
                                                              : FontWeight.w600,
                                                          color: isDarkMode
                                                              ? AppColors
                                                                  .mainGreen
                                                              : AppColors
                                                                  .primaryColor),
                                                    ),
                                                  ],
                                                ),
                                                status.value != "" &&
                                                        status.value ==
                                                            statuses[index]
                                                    ? SvgPicture.asset(
                                                        AppSvg.mark_green,
                                                        height: 20,
                                                        color: isDarkMode
                                                            ? AppColors
                                                                .mainGreen
                                                            : AppColors
                                                                .primaryColor,
                                                      )
                                                    : SizedBox()
                                              ],
                                            )),
                                      )))),
                            );
                          }))),
                ],
              )),
            ),
          );
        });
  }

  showTimeList(context, isDarkMode, theme) {
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.greyDot : AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 17.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 20.w),
                            child: Text(
                              "Select Period",
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: times.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                  onTap: () {
                                    pop();
                                    time.value = times[index];
                                    if (times[index] != "All Time") {
                                      DateRange dateFilter = locator
                                          .get<DateService>()
                                          .dateRangeFormatter(times[index]);
                                      timeFilter = {
                                        "startDate": dateFilter.startDate,
                                        "endDate": dateFilter.endDate
                                      };
                                    } else {
                                      timeFilter = {
                                        "startDate": null,
                                        "endDate": null
                                      };
                                    }
                                    fetchUserInvoices(true);
                                  },
                                  child: Obx((() => Container(
                                        decoration: BoxDecoration(
                                            color: isDarkMode
                                                ? AppColors.inputBackgroundColor
                                                : AppColors.grey,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 16.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      times[index],
                                                      style: TextStyle(
                                                          fontFamily: "Mont",
                                                          fontSize: 12.sp,
                                                          fontWeight: time.value !=
                                                                      "" &&
                                                                  time.value ==
                                                                      times[
                                                                          index]
                                                              ? FontWeight.w700
                                                              : FontWeight.w600,
                                                          color: isDarkMode
                                                              ? AppColors
                                                                  .mainGreen
                                                              : AppColors
                                                                  .primaryColor),
                                                    ),
                                                  ],
                                                ),
                                                time.value != "" &&
                                                        time.value ==
                                                            times[index]
                                                    ? SvgPicture.asset(
                                                        AppSvg.mark_green,
                                                        height: 20,
                                                        color: isDarkMode
                                                            ? AppColors
                                                                .mainGreen
                                                            : AppColors
                                                                .primaryColor,
                                                      )
                                                    : SizedBox()
                                              ],
                                            )),
                                      )))),
                            );
                          }))),
                ],
              )),
            ),
          );
        });
  }

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
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await file.writeAsBytes(response.data);
      await locator.get<SharedService>().shareFile(file);
      await raf.close();
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
    if (progress >= 1) {
      progressString = '✅ File has finished downloading. Try opening the file.';
      didDownloadPDF = true;
    } else {
      progressString = 'Download progress: ' +
          (progress * 100).toStringAsFixed(0) +
          '% done.';
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
