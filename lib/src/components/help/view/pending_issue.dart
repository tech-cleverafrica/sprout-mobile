import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/components/help/view/clever_comment.dart';
import 'package:sprout_mobile/src/components/help/view/issue_heading.dart';
import 'package:sprout_mobile/src/public/widgets/custom_multiline_text_form_field.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

class PendingIssueScreen extends StatefulWidget {
  PendingIssueScreen(
      {super.key, required this.issue, required this.refreshIssue});
  final void issue;
  final Function() refreshIssue;
  @override
  _PendingIssueScreenState createState() => _PendingIssueScreenState();
}

class _PendingIssueScreenState extends State<PendingIssueScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var cleverResponse = [
    {"cleverResponse": "Hello", "cleverResponseTime": "10:10:02PM"},
    {"cleverResponse": "Hello", "cleverResponseTime": "10:10:02PM"},
  ];

  void submitCallback(void issue) {
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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: DecisionButton(
              isDarkMode: isDarkMode,
              buttonText: "Update",
              onTap: () {
                updateIssue();
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
                addVerticalSpace(30.h),
                IssueHeading(
                    title: "Case ID: ",
                    subtitle: "CVL-960228000-FAI253",
                    offset: 0.7),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Issue Category: ",
                    subtitle: "POS WITHDRAWAL",
                    offset: 0.6),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Issue Subcategory: ",
                    subtitle: "APPROVED TRANSACTION NOT SETTLED TO THE WALLET",
                    offset: 0.5),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Transaction Date: ",
                    subtitle: "28-02-2023 10:10:02PM",
                    offset: 0.5),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Transaction Amount: ",
                    subtitle: "₦ " + "2,000.00",
                    offset: 0.5),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Card PAN: ", subtitle: "1234", offset: 0.5),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Name on Card: ",
                    subtitle: "Oluwaseun Odeyemi",
                    offset: 0.5),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Cardholder phone no.: ",
                    subtitle: "07039347005",
                    offset: 0.4),
                SizedBox(height: 10),
                IssueHeading(title: "RRN: ", subtitle: "123456", offset: 0.5),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Status: ", subtitle: "PENDING", offset: 0.7),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Creation Date: ",
                    subtitle: "28-02-2023 10:10:02PM",
                    offset: 0.6),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Resolution Deadline: ",
                    subtitle: "28-02-2023 10:10:02PM",
                    offset: 0.5),
                SizedBox(height: 10),
                IssueHeading(
                    title: "Created By: ",
                    subtitle: "Oluwaseun Odeyemi",
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
                      fontSize: 14.sp + 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                CustomMultilineTextFormField(
                  maxLines: 4,
                  maxLength: 500,
                  label: null,
                  hintText: "Enter issue description",
                  fillColor: isDarkMode
                      ? AppColors.inputBackgroundColor
                      : AppColors.grey,
                ),
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
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Clever:",
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.white
                          : Color.fromRGBO(29, 30, 31, 1),
                      fontSize: 14.sp + 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                cleverResponse.length > 0
                    ? ListView.builder(
                        itemCount: cleverResponse.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => CleverComment(
                            cleverResponse:
                                cleverResponse[index]['cleverResponse'] ?? "",
                            cleverResponseTime: cleverResponse[index]
                                    ['cleverResponseTime'] ??
                                ""))
                    : SizedBox(),
              ],
            )),
          )),
    );
  }

  Future<void> submitIssue(issue) async {}

  Future<void> updateIssue() async {
    submitCallback(null);
    widget.refreshIssue();
  }
}
