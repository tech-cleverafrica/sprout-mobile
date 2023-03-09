import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:sprout_mobile/src/components/help/controller/help_controller.dart';
import 'package:sprout_mobile/src/components/help/controller/post_complaint_controller.dart';
import 'package:sprout_mobile/src/components/help/model/issues_model.dart';
import 'package:sprout_mobile/src/components/help/model/issues_sub_category_model.dart';
import 'package:sprout_mobile/src/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

// ignore: must_be_immutable
class DispenseErrorScreen extends StatelessWidget {
  DispenseErrorScreen({
    super.key,
    required this.category,
    required this.data,
    required this.onSubmit,
  });
  final String category;
  final IssuesSubCategory? data;
  final Function(Issues issue) onSubmit;

  late HelpController helpController;
  late PostComplaintController postComplaintController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    helpController = Get.put(HelpController());
    postComplaintController = Get.put(PostComplaintController());
    postComplaintController.setCategory(category);
    postComplaintController.setSubCategory(data);
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Submit",
              onTap: () {
                postComplaintController
                    .validateDispenseError()
                    .then((value) => {
                          if (value != null)
                            {
                              pop(),
                              onSubmit(value),
                            }
                        });
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeader(isDarkMode, hideHelp: true),
                  addVerticalSpace(15.h),
                  Obx((() => Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Transaction date",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.inputLabelColor),
                                        ),
                                        Text(' *',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10))
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 55,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? AppColors.inputBackgroundColor
                                            : AppColors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: GestureDetector(
                                        onTap: () => showDatePicker(
                                                context: context,
                                                builder: (context, child) =>
                                                    Theme(
                                                      data: ThemeData.light()
                                                          .copyWith(
                                                        colorScheme:
                                                            ColorScheme.dark(
                                                          primary: isDarkMode
                                                              ? AppColors
                                                                  .mainGreen
                                                              : AppColors
                                                                  .primaryColor,
                                                          surface: isDarkMode
                                                              ? AppColors
                                                                  .mainGreen
                                                              : AppColors
                                                                  .primaryColor,
                                                          onSurface: isDarkMode
                                                              ? AppColors
                                                                  .mainGreen
                                                              : AppColors
                                                                  .primaryColor,
                                                          onPrimary:
                                                              AppColors.white,
                                                        ),
                                                        dialogBackgroundColor:
                                                            isDarkMode
                                                                ? AppColors
                                                                    .black
                                                                : AppColors
                                                                    .white,
                                                      ),
                                                      child: Container(
                                                        child: child,
                                                      ),
                                                    ),
                                                firstDate: DateTime(
                                                    DateTime.now().year - 10),
                                                lastDate: DateTime.now(),
                                                initialDate: DateTime.now())
                                            .then((date) {
                                          if (date != null) {
                                            DateFormat('date');
                                            postComplaintController
                                                    .dateToDisplay.value =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(date)
                                                    .toString();
                                            postComplaintController
                                                .transactionDate
                                                .value = DateFormat(
                                                    'yyyy-MM-ddTHH:mm:ss')
                                                .format(date)
                                                .toString();
                                          }
                                        }),
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  postComplaintController
                                                      .dateToDisplay.value,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .inputLabelColor)),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 18,
                                                color:
                                                    AppColors.inputLabelColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: CustomTextFormField(
                                label: "Transaction amount",
                                hintText: "Amount",
                                required: true,
                                textInputType: TextInputType.phone,
                                controller: postComplaintController
                                    .transactionAmountController,
                                fillColor: isDarkMode
                                    ? AppColors.inputBackgroundColor
                                    : AppColors.grey,
                                inputFormatters: [
                                  ThousandsFormatter(allowFraction: true),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[0-9,.]*$'))
                                ],
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.length == 0)
                                    return "Amount is required";
                                  else if (int.parse(
                                          value.split(",").join("")) ==
                                      0) {
                                    return "Invalid amount";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ))),
                  CustomTextFormField(
                    label: "Card PAN",
                    controller: postComplaintController.cardPANController,
                    required: true,
                    maxLength: 4,
                    showCounterText: false,
                    maxLengthEnforced: true,
                    hintText: "Enter last 4 digits of the Card PAN",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    validator: (value) {
                      if (value!.length == 0)
                        return "Card PAN is required";
                      else if (value.length < 4)
                        return "Card PAN should be 4 digits";
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: "Name on Card",
                    controller: postComplaintController.cardNameController,
                    hintText: "Enter Card Name",
                    required: true,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.length == 0) return "Card name is required";
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: "Cardholder Phone No.",
                    controller: postComplaintController.phoneNumberController,
                    hintText: "Enter Phone Number",
                    required: true,
                    maxLength: 11,
                    showCounterText: false,
                    maxLengthEnforced: true,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))
                    ],
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    validator: (value) {
                      if (value!.length == 0)
                        return "Phone number is required";
                      else if (value.length < 11)
                        return "Phone number should be 11 digits";
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    label: "RRN",
                    controller: postComplaintController.rrnController,
                    hintText: "Enter RRN",
                    required: true,
                    maxLength: 12,
                    showCounterText: false,
                    maxLengthEnforced: true,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'))
                    ],
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    validator: (value) {
                      if (value!.length == 0)
                        return "RRN is required";
                      else if (value.length < 12)
                        return "RRN should be 12 digits";
                      return null;
                    },
                  ),
                  Obx(((() => postComplaintController.receipt.value != null
                      ? addVerticalSpace(20)
                      : SizedBox()))),
                  Obx((() => postComplaintController.receipt.value != null
                      ? Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Platform.isIOS
                                    ? MediaQuery.of(context).size.width * 0.5
                                    : MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  postComplaintController.receipt.value?.name ??
                                      "",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    postComplaintController.removeFile(null),
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.transparent,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Text(
                                    "Remove file",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: AppColors.red,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox())),
                  addVerticalSpace(20),
                  Obx(((() => postComplaintController.receipt.value == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async => Platform.isIOS
                                  ? await FilePicker.platform
                                      .pickFiles(
                                        type: FileType.media,
                                      )
                                      .then((value) => {
                                            if (value != null)
                                              {
                                                postComplaintController
                                                    .processFile(File(value
                                                            .files
                                                            .single
                                                            .path ??
                                                        "")),
                                              }
                                          })
                                  : await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: [
                                          'jpg',
                                          'jpeg',
                                          'png',
                                        ]).then((value) => {
                                        if (value != null)
                                          {
                                            postComplaintController.processFile(
                                                File(value.files.single.path ??
                                                    "")),
                                          }
                                      }),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Attach receipt or evidence",
                                    style: TextStyle(
                                        fontFamily: "DMSans",
                                        fontSize: 13.sp,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 24,
                              color: Colors.transparent,
                              child: Image.asset(isDarkMode
                                  ? AppImages.upload_dark
                                  : AppImages.upload),
                            ),
                          ],
                        )
                      : SizedBox()))),
                ],
              ),
            ),
          )),
    );
  }

  Future submitDispenseError() async {
    // Future.delayed(const Duration(milliseconds: 500),
    //     () => {widget.onSubmit(issue), Navigator.pop(context)});
  }
}
