import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_dropdown_button_field.dart';
import 'package:sprout_mobile/src/public/widgets/custom_multiline_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

class SubmitComplaintScreen extends StatefulWidget {
  SubmitComplaintScreen(
      {super.key, required this.onSubmit, required this.navigateNext});
  final Function(void issue) onSubmit;
  final Function(String title, String category, void subCategory) navigateNext;
  @override
  _SubmitComplaintScreenState createState() => _SubmitComplaintScreenState();
}

class _SubmitComplaintScreenState extends State<SubmitComplaintScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showInstruction() {
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
                                      widget.navigateNext("", "", null)
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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Submit",
              onTap: () {
                submitIssue("issue");
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
                  CustomDropdownButtonFormField(
                    items: [
                      "Approved Transaction Not Settled to the Wallet",
                      "High Transaction Charges",
                      "Decline Transactions but the cardholder is debited",
                      "Others"
                    ],
                    onSaved: (value) => {
                      if (value ==
                          "Decline Transactions but the cardholder is debited")
                        {showInstruction()}
                    },
                    label: "Select Issue Subcategory",
                    // hintText: "Your Email",
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  CustomMultilineTextFormField(
                    maxLines: 6,
                    maxLength: 500,
                    label: "Please give us details of the issue",
                    hintText: "Enter issue description",
                    required: true,
                    fillColor: isDarkMode
                        ? AppColors.inputBackgroundColor
                        : AppColors.grey,
                  ),
                  addVerticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                          Text(' *',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))
                        ],
                      ),
                      Container(
                        height: 24,
                        color: Colors.transparent,
                        child: Image.asset(isDarkMode
                            ? AppImages.upload_dark
                            : AppImages.upload),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> submitIssue(issue) async {
    Future.delayed(const Duration(milliseconds: 500),
        () => {widget.onSubmit(issue), Navigator.pop(context)});
  }
}
