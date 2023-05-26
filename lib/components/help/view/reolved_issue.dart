import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/components/help/controller/help_controller.dart';
import 'package:sprout_mobile/components/help/controller/resolved_issues_controller.dart';
import 'package:sprout_mobile/components/help/model/issues_model.dart';
import 'package:sprout_mobile/components/help/view/clever_comment.dart';
import 'package:sprout_mobile/components/help/view/issue_heading.dart';
import 'package:sprout_mobile/public/widgets/custom_multiline_text_form_field.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/app_images.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

// ignore: must_be_immutable
class ResolvedIssueScreen extends StatelessWidget {
  ResolvedIssueScreen(
      {super.key,
      required this.issue,
      required this.refreshIssue,
      required this.onReopened});
  final Issues issue;
  final Function() refreshIssue;
  final Function(Issues issue) onReopened;

  late HelpController helpController;
  late ResolvedIssuesController resolvedIssuesController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    helpController = Get.put(HelpController());
    resolvedIssuesController = Get.put(ResolvedIssuesController());
    resolvedIssuesController.setDescription(issue);
    resolvedIssuesController.addFiles(issue);
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar:
              Obx((() => resolvedIssuesController.reopened.value
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 24),
                      child: DecisionButton(
                        isDarkMode: isDarkMode,
                        buttonText: "Reopen",
                        onTap: () {
                          resolvedIssuesController
                              .validate(issue)
                              .then((value) => {
                                    if (value != null)
                                      {
                                        pop(),
                                        onReopened(value),
                                        refreshIssue(),
                                      }
                                  });
                        },
                        onBack: () =>
                            resolvedIssuesController.reopened.value = false,
                      ),
                    )
                  : SizedBox())),
          body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getHeader(isDarkMode, hideHelp: true),
                    addVerticalSpace(30.h),
                    IssueHeading(
                        title: "Case ID: ",
                        subtitle: issue.caseId ?? "",
                        offset: 0.7),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Issue Category: ",
                        subtitle: issue.issueCategory!.split("_").join(" "),
                        offset: 0.6),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Issue Subcategory: ",
                        subtitle: issue.issueSubCategory!.split("_").join(" "),
                        offset: 0.5),
                    SizedBox(height: 10),
                    issue.issueSubCategory == 'DISPENSE_ERROR'
                        ? Column(
                            children: [
                              IssueHeading(
                                  title: "Transaction Date: ",
                                  subtitle: issue.transactionDate != null
                                      ? DateFormat('dd-MM-yyyy').format(
                                          helpController.localDate(
                                              issue.transactionDate ?? ""))
                                      : '-',
                                  offset: 0.5),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "Transaction Amount: ",
                                  subtitle: "₦ " +
                                      helpController.oCcy.format(int.parse(
                                          (issue.transactionAmount != null
                                                  ? issue.transactionAmount!
                                                      .toStringAsFixed(2)
                                                  : "0.00")
                                              .split(".")[0])),
                                  offset: 0.5),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "Card PAN: ",
                                  subtitle: issue.pan ?? "",
                                  offset: 0.5),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "Name on Card: ",
                                  subtitle: issue.cardName ?? "",
                                  offset: 0.5),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "Cardholder phone no.: ",
                                  subtitle: issue.cardHolderPhoneNumber ?? "",
                                  offset: 0.4),
                              SizedBox(height: 10),
                              IssueHeading(
                                  title: "RRN: ",
                                  subtitle: issue.rrn ?? "",
                                  offset: 0.5),
                              SizedBox(height: 10),
                            ],
                          )
                        : SizedBox(),
                    IssueHeading(
                        title: "Status: ",
                        subtitle: issue.status!.split("_").join(" "),
                        offset: 0.7),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Creation Date: ",
                        subtitle: issue.creationDate != null
                            ? DateFormat('dd-MM-yyyy \thh:mm:ssa').format(
                                helpController
                                    .localDate(issue.creationDate ?? ""))
                            : '-',
                        offset: 0.6),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Resolution Deadline: ",
                        subtitle: issue.resolutionDeadline != null
                            ? DateFormat('dd-MM-yyyy \thh:mm:ssa').format(
                                helpController
                                    .localDate(issue.resolutionDeadline ?? ""))
                            : '-',
                        offset: 0.5),
                    SizedBox(height: 10),
                    IssueHeading(
                        title: "Created By: ",
                        subtitle: issue.createdBy ?? "",
                        offset: 0.6),
                    SizedBox(height: 30),
                    Obx((() => !resolvedIssuesController.reopened.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                  "Your Issue:",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : Color.fromRGBO(29, 30, 31, 1),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isDarkMode
                                          ? AppColors.orangeWarning
                                          : AppColors.greyText,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Text(
                                    issue.issueDescription ?? '',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : Color.fromRGBO(29, 30, 31, 1),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                              SizedBox(height: 10),
                              resolvedIssuesController.files.length > 0
                                  ? Container(
                                      width: double.infinity,
                                      child: Text(
                                        "Receipt or evidence:",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : Color.fromRGBO(29, 30, 31, 1),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              resolvedIssuesController.files.length > 0
                                  ? SizedBox(height: 5)
                                  : SizedBox(),
                              resolvedIssuesController.files.length > 0
                                  ? ListView.builder(
                                      itemCount:
                                          resolvedIssuesController.files.length,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Text(
                                                resolvedIssuesController
                                                        .files[index].name ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: isDarkMode
                                                      ? AppColors.white
                                                      : AppColors.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              issue.issueSubCategory != 'DISPENSE_ERROR'
                                  ? SizedBox(height: 10)
                                  : SizedBox(),
                              issue.issueSubCategory != 'DISPENSE_ERROR'
                                  ? Container(
                                      width: double.infinity,
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: 120,
                                        height: 35,
                                        child: Container(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              backgroundColor: isDarkMode
                                                  ? AppColors.mainGreen
                                                  : AppColors.primaryColor,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                            ),
                                            onPressed: () => {
                                              confirmReopenIssue(context),
                                            },
                                            child: Text("Reopen case",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 30),
                              issue.cleverResponse!.length > 0
                                  ? Container(
                                      width: double.infinity,
                                      child: Text(
                                        "Sprout:",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.white
                                              : Color.fromRGBO(29, 30, 31, 1),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              issue.cleverResponse!.length > 0
                                  ? SizedBox(height: 5)
                                  : SizedBox(),
                              issue.cleverResponse!.length > 0
                                  ? ListView.builder(
                                      itemCount: issue.cleverResponse!.length,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          CleverComment(
                                              cleverResponse:
                                                  issue.cleverResponse![index]
                                                      ['cleverResponse'],
                                              cleverResponseTime:
                                                  issue.cleverResponse![index]
                                                      ['cleverResponseTime']))
                                  : SizedBox(),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Please give us details of the issue.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              CustomMultilineTextFormField(
                                controller: resolvedIssuesController
                                    .descriptionController,
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
                              SizedBox(height: 20),
                              resolvedIssuesController.files.length > 0
                                  ? ListView.builder(
                                      itemCount:
                                          resolvedIssuesController.files.length,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Text(
                                                resolvedIssuesController
                                                        .files[index].name ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: isDarkMode
                                                      ? AppColors.white
                                                      : AppColors.primaryColor,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  resolvedIssuesController
                                                      .removeFile(index),
                                              behavior: HitTestBehavior.opaque,
                                              child: Container(
                                                height: 20,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
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
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                      resolvedIssuesController
                                                          .processFile(File(
                                                              value.files.single
                                                                      .path ??
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
                                                  resolvedIssuesController
                                                      .processFile(File(value
                                                              .files
                                                              .single
                                                              .path ??
                                                          "")),
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
                                          // width: MediaQuery.of(context).size.width *
                                          //     0.42,
                                          child: Text(
                                            "Attach receipt or evidence",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
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
                              resolvedIssuesController.fileError.value != ""
                                  ? SizedBox(
                                      height: 10,
                                    )
                                  : SizedBox(),
                              resolvedIssuesController.fileError.value != ""
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          resolvedIssuesController
                                              .fileError.value,
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: AppColors.red,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ))),
                    SizedBox(height: 30),
                  ],
                )),
          )),
    );
  }

  Future<void> confirmReopenIssue(BuildContext context) async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return Dialog(
            backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: Text(
                        "Are you sure you want to reopen this case?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: AppColors.inputLabelColor,
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel",
                                style: Theme.of(context).textTheme.button),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: AppColors.mainGreen,
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () => {
                              pop(),
                              resolvedIssuesController.reopened.value = true,
                            },
                            child: Text("Yes",
                                style: Theme.of(context).textTheme.button),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        }));
  }
}
