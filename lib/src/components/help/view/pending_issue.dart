import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/components/help/controller/help_controller.dart';
import 'package:sprout_mobile/src/components/help/controller/pending_issues_controller.dart';
import 'package:sprout_mobile/src/components/help/model/issues_model.dart';
import 'package:sprout_mobile/src/components/help/view/clever_comment.dart';
import 'package:sprout_mobile/src/components/help/view/issue_heading.dart';
import 'package:sprout_mobile/src/public/widgets/custom_multiline_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

// ignore: must_be_immutable
class PendingIssueScreen extends StatelessWidget {
  PendingIssueScreen({super.key, required this.refreshIssue});
  final VoidCallback refreshIssue;

  late HelpController helpController;
  late PendingIssuesController pendingIssuesController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    helpController = Get.put(HelpController());
    pendingIssuesController = Get.put(PendingIssuesController());
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Update",
              onTap: () {
                pendingIssuesController
                    .validate(pendingIssuesController.issue.value)
                    .then((value) => {
                          if (value != null)
                            {
                              refreshIssue(),
                              submitCallback(
                                  pendingIssuesController.issue.value, context),
                            }
                        });
              },
            ),
          ),
          body: Obx((() => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getHeader(isDarkMode, hideHelp: true),
                    addVerticalSpace(30.h),
                    IssueHeading(
                        title: "Case ID: ",
                        subtitle:
                            pendingIssuesController.issue.value?.caseId ?? "",
                        offset: 0.7),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Issue Category: ",
                        subtitle: pendingIssuesController
                            .issue.value.issueCategory!
                            .split("_")
                            .join(" "),
                        offset: 0.6),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Issue Subcategory: ",
                        subtitle: pendingIssuesController
                            .issue.value.issueSubCategory!
                            .split("_")
                            .join(" "),
                        offset: 0.5),
                    SizedBox(height: 10),
                    pendingIssuesController.issue.value.issueSubCategory ==
                            'DISPENSE_ERROR'
                        ? Column(
                            children: [
                              IssueHeading(
                                  title: "Transaction Date: ",
                                  subtitle: pendingIssuesController
                                              .issue.value.transactionDate !=
                                          null
                                      ? DateFormat('dd-MM-yyyy').format(
                                          helpController.localDate(
                                              pendingIssuesController.issue
                                                      .value.transactionDate ??
                                                  ""))
                                      : '-',
                                  offset: 0.5),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "Transaction Amount: ",
                                  subtitle: "₦ " +
                                      helpController.oCcy.format(int.parse(
                                          (pendingIssuesController.issue.value
                                                          .transactionAmount !=
                                                      null
                                                  ? pendingIssuesController
                                                      .issue
                                                      .value
                                                      .transactionAmount!
                                                      .toStringAsFixed(2)
                                                  : "0.00")
                                              .split(".")[0])),
                                  offset: 0.5),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "Card PAN: ",
                                  subtitle:
                                      pendingIssuesController.issue.value.pan ??
                                          "",
                                  offset: 0.5),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "Name on Card: ",
                                  subtitle: pendingIssuesController
                                          .issue.value.cardName ??
                                      "",
                                  offset: 0.5),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "Cardholder phone no.: ",
                                  subtitle: pendingIssuesController
                                          .issue.value.cardHolderPhoneNumber ??
                                      "",
                                  offset: 0.4),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "RRN: ",
                                  subtitle:
                                      pendingIssuesController.issue.value.rrn ??
                                          "",
                                  offset: 0.5),
                              SizedBox(height: 10),
                            ],
                          )
                        : SizedBox(),
                    IssueHeading(
                        title: "Status: ",
                        subtitle: pendingIssuesController.issue.value.status!
                            .split("_")
                            .join(" "),
                        offset: 0.7),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Creation Date: ",
                        subtitle: pendingIssuesController
                                    .issue.value.creationDate !=
                                null
                            ? DateFormat('dd-MM-yyyy \thh:mm:ssa').format(
                                helpController.localDate(pendingIssuesController
                                        .issue.value.creationDate ??
                                    ""))
                            : '-',
                        offset: 0.6),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Resolution Deadline: ",
                        subtitle: pendingIssuesController
                                    .issue.value.resolutionDeadline !=
                                null
                            ? DateFormat('dd-MM-yyyy \thh:mm:ssa').format(
                                helpController.localDate(pendingIssuesController
                                        .issue.value.resolutionDeadline ??
                                    ""))
                            : '-',
                        offset: 0.5),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Created By: ",
                        subtitle:
                            pendingIssuesController.issue.value.createdBy ?? "",
                        offset: 0.6),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Your Issue:",
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.white
                              : Color.fromRGBO(29, 30, 31, 1),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    CustomMultilineTextFormField(
                      controller: pendingIssuesController.descriptionController,
                      maxLines: 4,
                      maxLength: 500,
                      maxLengthEnforced: true,
                      label: null,
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
                    ),
                    SizedBox(height: 10),
                    Obx((() => pendingIssuesController.files.length > 0
                        ? ListView.builder(
                            itemCount: pendingIssuesController.files.length,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      pendingIssuesController
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
                                    onTap: () => pendingIssuesController
                                        .removeFile(index),
                                    behavior: HitTestBehavior.opaque,
                                    child: Container(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
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
                            ),
                          )
                        : SizedBox())),
                    SizedBox(height: 10),
                    Row(
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
                                            pendingIssuesController.processFile(
                                                File(value.files.single.path ??
                                                    "")),
                                          }
                                      })
                              : await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                      'jpg',
                                      'pdf',
                                      'jpeg',
                                      'png',
                                    ]).then((value) => {
                                    if (value != null)
                                      {
                                        pendingIssuesController.processFile(
                                            File(
                                                value.files.single.path ?? "")),
                                      }
                                  }),
                          child: Row(
                            children: [
                              Container(
                                height: 24,
                                color: Colors.transparent,
                                child: Image.asset(isDarkMode
                                    ? AppImages.upload_dark
                                    : AppImages.upload),
                              ),
                              SizedBox(width: 7),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: Text(
                                  "Attach receipt or evidence",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pendingIssuesController.fileError.value != ""
                        ? SizedBox(
                            height: 10,
                          )
                        : SizedBox(),
                    pendingIssuesController.fileError.value != ""
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pendingIssuesController.fileError.value,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(height: 30),
                    pendingIssuesController.issue.value.cleverResponse!.length >
                            0
                        ? Container(
                            width: double.infinity,
                            child: Text(
                              "Sprout:",
                              style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.white
                                    : Color.fromRGBO(29, 30, 31, 1),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : SizedBox(),
                    pendingIssuesController.issue.value.cleverResponse!.length >
                            0
                        ? SizedBox(height: 5)
                        : SizedBox(),
                    pendingIssuesController.issue.value.cleverResponse!.length >
                            0
                        ? ListView.builder(
                            itemCount: pendingIssuesController
                                .issue.value.cleverResponse!.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => CleverComment(
                                cleverResponse: pendingIssuesController
                                    .issue
                                    .value
                                    .cleverResponse![index]['cleverResponse'],
                                cleverResponseTime: pendingIssuesController
                                        .issue.value.cleverResponse![index]
                                    ['cleverResponseTime']))
                        : SizedBox(),
                  ],
                )),
              )))),
    );
  }

  Future<void> submitCallback(Issues issue, BuildContext context) async {
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
                  height: 130.h,
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
                              "Dear Oluwaseun,",
                              style: theme.textTheme.subtitle2,
                            ),
                            addVerticalSpace(5.h),
                            Text(
                              "Your complaint has been updated successfully.",
                              style: theme.textTheme.subtitle2,
                            ),
                            addVerticalSpace(10.h),
                            Text(
                              "Thank You!",
                              style: theme.textTheme.subtitle2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })));
  }

  Future<void> submitIssue(Issues issue, BuildContext context) async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return Dialog(
            backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
                height: 110,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dear " +
                          helpController.inCaps(helpController.name) +
                          ",",
                      style: TextStyle(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                        fontSize: 12.sp,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Your complaint has been updated successfully.",
                      style: TextStyle(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                        fontSize: 12.sp,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Thank You!",
                      style: TextStyle(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                        fontSize: 12.sp,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )),
          );
        }));
  }
}
