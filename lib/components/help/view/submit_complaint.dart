import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/components/help/controller/help_controller.dart';
import 'package:sprout_mobile/components/help/controller/post_complaint_controller.dart';
import 'package:sprout_mobile/components/help/model/issues_model.dart';
import 'package:sprout_mobile/components/help/model/issues_sub_category_model.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';
import 'package:sprout_mobile/public/widgets/custom_multiline_text_form_field.dart';
import 'package:sprout_mobile/public/widgets/custom_text_form_field.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/app_images.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:sprout_mobile/utils/helper_widgets.dart';
import 'package:sprout_mobile/utils/nav_function.dart';

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
  final Function(String category, IssuesSubCategory? subCategory) navigateNext;

  late HelpController helpController;
  late PostComplaintController pCC;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    helpController = Get.put(HelpController());
    pCC = Get.put(PostComplaintController());
    pCC.getSubCategories(id);
    pCC.setCategory(category);
    return SafeArea(
      key: navigatorKey,
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Submit",
              onTap: () {
                pCC.validate().then((value) => {
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
                      GestureDetector(
                          onTap: () {
                            showSubCategoriesList(context, isDarkMode);
                          },
                          child: Obx((() => CustomTextFormField(
                                label: "Select Issue Subcategory",
                                hintText: pCC.subCategoryName.value == ""
                                    ? "Select Issue Subcategory"
                                    : pCC.subCategoryName.value,
                                required: true,
                                enabled: false,
                                fillColor: isDarkMode
                                    ? AppColors.inputBackgroundColor
                                    : AppColors.grey,
                                hintTextStyle: pCC.subCategoryName.value == ""
                                    ? null
                                    : TextStyle(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp),
                              )))),
                      pCC.issuesSubCategory.value != null
                          ? CustomMultilineTextFormField(
                              controller: pCC.descriptionController,
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
                      pCC.issuesSubCategory.value != null
                          ? addVerticalSpace(10)
                          : SizedBox(),
                      pCC.issuesSubCategory.value != null &&
                              pCC.files.length > 0
                          ? ListView.builder(
                              itemCount: pCC.files.length,
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
                                        pCC.files[index].name ?? "",
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
                                      onTap: () => pCC.removeFile(index),
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
                      pCC.issuesSubCategory.value != null
                          ? addVerticalSpace(10)
                          : SizedBox(),
                      pCC.issuesSubCategory.value != null
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
                                                    pCC.processFile(File(value
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
                                                pCC.processFile(File(
                                                    value.files.single.path ??
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
                                            fontFamily: "Mont",
                                            fontSize: 13.sp,
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Obx((() => pCC.isFileRequired.value
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

  void showInstruction() {
    final isDarkMode =
        Theme.of(navigatorKey.currentContext!).brightness == Brightness.dark;
    final theme = Theme.of(navigatorKey.currentContext!);
    Future.delayed(
        Duration(seconds: 1),
        () => showDialog(
            context: navigatorKey.currentContext!,
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
                                "POS Withdrawal: Decline Transactions but the cardholder is debited",
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
                                      pop(),
                                      pop(),
                                      navigateNext(pCC.category,
                                          pCC.dispenseSubCategory.value)
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

  showSubCategoriesList(context, isDarkMode) {
    pCC = Get.put(PostComplaintController());
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
                              "Select Card",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "Mont",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? AppColors.mainGreen
                                      : AppColors.primaryColor),
                            ),
                          )
                        ]),
                  ),
                  Obx((() => Expanded(
                      child: ListView.builder(
                          itemCount: pCC.subCategoriesname.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: GestureDetector(
                                onTap: () {
                                  pop();
                                  pCC.subCategoryName.value =
                                      pCC.subCategoriesname[index];
                                  pCC
                                      .sortPackage(pCC.subCategoriesname[index])
                                      .then((value) => {
                                            if (value != "") {showInstruction()}
                                          });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? AppColors.inputBackgroundColor
                                          : AppColors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 16.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                pCC.subCategoriesname[index],
                                                style: TextStyle(
                                                    fontFamily: "Mont",
                                                    fontSize: 12.sp,
                                                    fontWeight: pCC.subCategoryName
                                                                    .value !=
                                                                "" &&
                                                            pCC.subCategoryName
                                                                    .value ==
                                                                pCC.subCategoriesname[
                                                                    index]
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    color: isDarkMode
                                                        ? AppColors.mainGreen
                                                        : AppColors
                                                            .primaryColor),
                                              ),
                                            ],
                                          ),
                                          pCC.subCategoryName.value != "" &&
                                                  pCC.subCategoryName.value ==
                                                      pCC.subCategoriesname[
                                                          index]
                                              ? SvgPicture.asset(
                                                  AppSvg.mark_green,
                                                  height: 20,
                                                  color: isDarkMode
                                                      ? AppColors.mainGreen
                                                      : AppColors.primaryColor,
                                                )
                                              : SizedBox()
                                        ],
                                      )),
                                ),
                              ),
                            );
                          }))))),
                ],
              )),
            ),
          );
        });
  }
}
