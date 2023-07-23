import 'dart:io';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/api-setup/api_setup.dart';
import 'package:sprout_mobile/api/api_response.dart';
import 'package:sprout_mobile/components/invoice/model/invoice_model.dart';
import 'package:sprout_mobile/components/invoice/service/invoice_service.dart';
import 'package:sprout_mobile/config/Config.dart';
import 'package:sprout_mobile/public/services/shared_service.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';
import 'package:sprout_mobile/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/public/widgets/custom_toast_notification.dart';
import 'package:sprout_mobile/components/authentication/service/auth_service.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

class InvoiceSuccessController extends GetxController {
  TextEditingController emailSubjectController = new TextEditingController();
  TextEditingController recipientEmailController = new TextEditingController();
  TextEditingController emailBodyController = new TextEditingController();

  var args;
  var invoice = Rxn<Invoice>();
  RxString invoiceUrl = "".obs;
  RxBool loading = false.obs;

  // Track the progress of a downloaded file here.
  double progress = 0;
  // Track if the PDF was downloaded here.
  bool didDownloadPDF = false;
  // Show the progress status to the user.
  String progressString = 'File has not been downloaded yet.';

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
    invoice.value = Invoice.fromJson(args);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  sendInvoice() async {
    AppResponse response = await locator
        .get<InvoiceService>()
        .sendInvoice(buildInvoiceEmailModel());
    if (response.status) {
      CustomToastNotification.show(response.message, type: ToastType.success);
      pop();
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        sendInvoice();
      }
    } else {
      CustomToastNotification.show(response.message, type: ToastType.error);
    }
  }

  Future<dynamic> downloadInvoice(String invoiceId) async {
    AppResponse response =
        await locator.get<InvoiceService>().downloadInvoice(invoiceId);
    if (response.status) {
      invoiceUrl.value = response.data["data"];
      return response.data["data"];
    } else if (response.statusCode == 999) {
      AppResponse res = await locator.get<AuthService>().refreshUserToken();
      if (res.status) {
        downloadInvoice(invoiceId);
      }
    }
    return null;
  }

  buildInvoiceEmailModel() {
    return {
      "invoiceID": invoice.value?.id,
      "message": emailBodyController.text,
      "subject": emailSubjectController.text,
      "to": recipientEmailController.text
    };
  }

  validateEmail() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (emailSubjectController.text.length > 5 &&
        recipientEmailController.text.isNotEmpty &&
        (regex.hasMatch(recipientEmailController.text))) {
      sendInvoice();
    } else if (emailSubjectController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Email Subject is required"),
          backgroundColor: AppColors.errorRed));
    } else if (emailSubjectController.text.length < 6) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Email Subject is too short"),
          backgroundColor: AppColors.errorRed));
    } else if (recipientEmailController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Recipient email is required"),
          backgroundColor: AppColors.errorRed));
    } else if (!(regex.hasMatch(recipientEmailController.text))) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please enter a valid email"),
          backgroundColor: AppColors.errorRed));
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Please supply all required fields"),
          backgroundColor: AppColors.errorRed));
    }
  }

  showUpdateModal(context, isDarkMode) {
    emailSubjectController = TextEditingController(text: invoice.value?.note);
    recipientEmailController =
        TextEditingController(text: invoice.value?.customer?.email);
    emailBodyController = TextEditingController(
        text: "Dear " +
            invoice.value!.customer!.fullName! +
            ", \n\nAn invoice has been generated for you by $APP_NAME.\n\nPlease click on the button below to view the invoice\n       \nBest regards,\n$APP_COMPANY_NAME. \n      ");
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.8,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        Center(
                          child: Text(
                            "Send Invoice",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 14.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        CustomTextFormField(
                          controller: emailSubjectController,
                          label: "Email Subject",
                          fillColor: isDarkMode
                              ? AppColors.inputBackgroundColor
                              : AppColors.grey,
                          hintText: "Enter Email Subject",
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.length == 0)
                              return "Email subject is required";
                            else if (value.length < 6)
                              return "Email Subject is too short";
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: recipientEmailController,
                          label: "Recipient Email",
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
                          controller: emailBodyController,
                          maxLines: 9,
                          maxLength: 500,
                          label: "Enter Address",
                          hintText: "Address",
                          enabled: false,
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
                        addVerticalSpace(20.h),
                        CustomButton(
                          title: "Send Invoice",
                          onTap: () {
                            validateEmail();
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
}
