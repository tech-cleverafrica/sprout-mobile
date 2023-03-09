import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/help/controller/help_controller.dart';
import 'package:sprout_mobile/src/components/help/controller/post_complaint_controller.dart';
import 'package:sprout_mobile/src/components/help/model/issues_model.dart';
import 'package:sprout_mobile/src/components/help/model/issues_sub_category_model.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_dropdown_button_field.dart';
import 'package:sprout_mobile/src/public/widgets/custom_multiline_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

// ignore: must_be_immutable
class SubmitComplaintScreen extends StatelessWidget {
  SubmitComplaintScreen(
      {super.key,
      required this.onSubmit,
      required this.id,
      required this.category,
      required this.navigateNext});
  final Function(Issues issue) onSubmit;
  final String id;
  final String category;
  final Function(String title, String category, IssuesSubCategory? subCategory)
      navigateNext;

  late HelpController helpController;
  late PostComplaintController postComplaintController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    helpController = Get.put(HelpController());
    postComplaintController = Get.put(PostComplaintController());
    postComplaintController.getSubCategories(id);
    postComplaintController.setCategory(category);
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Submit",
              onTap: () {
                postComplaintController.validate().then((value) => {
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
              child: Obx((() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getHeader(isDarkMode, hideHelp: true),
                      addVerticalSpace(15.h),
                      CustomDropdownButtonFormField(
                        items: postComplaintController.subCategoriesname
                            .map((element) => element)
                            .toList(),
                        onSaved: (value) => {
                          print(value),
                          postComplaintController
                              .sortPackage(value ?? "")
                              .then((value) => {
                                    if (value != "") {showInstruction(context)}
                                  }),
                        },
                        label: "Select Issue Subcategory",
                        required: true,
                        fillColor: isDarkMode
                            ? AppColors.inputBackgroundColor
                            : AppColors.grey,
                      ),
                      postComplaintController.issuesSubCategory.value != null
                          ? CustomMultilineTextFormField(
                              controller:
                                  postComplaintController.descriptionController,
                              maxLines: 6,
                              maxLength: 500,
                              maxLengthEnforced: true,
                              label: "Please give us details of the issue",
                              hintText: "Enter issue description",
                              required: true,
                              validator: (value) {
                                if (value!.length == 0)
                                  return "Issue description cannot be empty";
                                else if (value.length < 20)
                                  return "Issue description is too short";
                                return null;
                              },
                              fillColor: isDarkMode
                                  ? AppColors.inputBackgroundColor
                                  : AppColors.grey,
                            )
                          : SizedBox(),
                      postComplaintController.issuesSubCategory.value != null
                          ? addVerticalSpace(10)
                          : SizedBox(),
                      postComplaintController.issuesSubCategory.value != null &&
                              postComplaintController.files.length > 0
                          ? ListView.builder(
                              itemCount: postComplaintController.files.length,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Platform.isIOS
                                          ? MediaQuery.of(context).size.width *
                                              0.5
                                          : MediaQuery.of(context).size.width *
                                              0.6,
                                      child: Text(
                                        postComplaintController
                                                .files[index].name ??
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
                                      onTap: () => postComplaintController
                                          .removeFile(index),
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                              ),
                            )
                          : SizedBox(),
                      postComplaintController.issuesSubCategory.value != null
                          ? addVerticalSpace(10)
                          : SizedBox(),
                      postComplaintController.issuesSubCategory.value != null
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
                                                postComplaintController
                                                    .processFile(File(value
                                                            .files
                                                            .single
                                                            .path ??
                                                        "")),
                                              }
                                          }),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Obx((() => postComplaintController
                                              .isFileRequired.value
                                          ? Text(' *',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10))
                                          : SizedBox())),
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
                          : SizedBox(),
                    ],
                  ))),
            ),
          )),
    );
  }

  void showInstruction(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    Future.delayed(
        Duration(seconds: 1),
        () => showDialog(
            context: context,
            barrierDismissible: true,
            builder: ((context) {
              return Dialog(
                backgroundColor:
                    isDarkMode ? AppColors.blackBg : AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  height: MediaQuery.of(context).size.height > 700
                      ? MediaQuery.of(context).size.height * 0.55
                      : MediaQuery.of(context).size.height * 0.70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        addVerticalSpace(5.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "POS Withdrawal: Decline Transactions but the caardholder is debited",
                                style: Theme.of(context).textTheme.headline6),
                            addVerticalSpace(15.h),
                            Text("Please follow the steps below",
                                style: Theme.of(context).textTheme.headline6),
                            addVerticalSpace(10.h),
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "1. ",
                                        style: theme.textTheme.headline6),
                                    TextSpan(
                                        text: "On the next screen, share the:",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "a. ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    TextSpan(
                                        text: "Transaction date",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "b. ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    TextSpan(
                                        text: "Amount",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "c. ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    TextSpan(
                                        text:
                                            "Card PAN (the last 4 digits on the card)",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "d. ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    TextSpan(
                                        text: "Name on the card",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "e. ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    TextSpan(
                                        text: "Cardholder phone number",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "f. ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    TextSpan(
                                        text: "RRN",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            addVerticalSpace(10.h),
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "2. ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    TextSpan(
                                        text: "Upload the declined receipt",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            addVerticalSpace(10.h),
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "3. ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    TextSpan(
                                        text:
                                            "We will inform you if we got settlement or not",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            addVerticalSpace(10.h),
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "4. ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    TextSpan(
                                        text:
                                            "If properly filled, we will credit you and you can credit the customer (Please ensure all information filled is correct).",
                                        style: theme.textTheme.subtitle2),
                                  ],
                                ),
                              ),
                            ),
                            addVerticalSpace(30.h),
                            CustomButton(
                                title: "Proceed",
                                onTap: () => {
                                      Get.back(),
                                      Get.back(),
                                      navigateNext(
                                          "",
                                          "",
                                          postComplaintController
                                              .dispenseSubCategory.value)
                                    })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })));
  }

  Future<void> submitIssue(issue) async {
    // Future.delayed(const Duration(milliseconds: 500),
    //     () => {onSubmit(issue), Navigator.pop(context)});
  }
}
