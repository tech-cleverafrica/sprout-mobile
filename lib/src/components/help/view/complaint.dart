import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/components/help/view/cant_find_my_issue.dart';
import 'package:sprout_mobile/src/components/help/view/complaint_tab.dart';
import 'package:sprout_mobile/src/components/help/view/dispense_error.dart';
import 'package:sprout_mobile/src/components/help/view/pending_issue.dart';
import 'package:sprout_mobile/src/components/help/view/reolved_issue.dart';
import 'package:sprout_mobile/src/components/help/view/singleIssue.dart';
import 'package:sprout_mobile/src/components/help/view/submit_complaint.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';

class ComplaintScreen extends StatefulWidget {
  ComplaintScreen({super.key});

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ScrollController _scrollController = new ScrollController();
  int currentIndex = 0;
  bool loading = false;
  bool categoriesLoading = false;
  bool pendingIssuesLoading = false;
  bool resolvedIssuesLoading = false;
  List<String> issueCategories = [
    "POS Withdrawal",
    "Funds Transfer",
    "Mobile App",
    "POS Device",
    "Wallet Top-Up",
    "Airtime",
    "Bills Payment",
    "Others"
  ];
  var overview = {};
  String status = "";
  String pending = "";
  String resolved = "";
  List pendingIssues = [
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
  ];
  List resolvedIssues = [
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
    {"id": 1, "caseId": "CVL-960228000-FAI253"},
  ];
  int size = 15;

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
                  height: 200.h,
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
                              "Your complaint has been received. This will be resolved within 24hrs.",
                              style: theme.textTheme.subtitle2,
                            ),
                            addVerticalSpace(5.h),
                            Text(
                              "Your Case ID is:",
                              style: theme.textTheme.subtitle2,
                            ),
                            addVerticalSpace(5.h),
                            Text(
                              "CLV-492250000-APP124",
                              style: theme.textTheme.headline6,
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode, hideHelp: true),
              addVerticalSpace(15.h),
              addVerticalSpace(16.h),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ComplaintTab(
                          title: "Select Issue",
                          index: 0,
                          currentIndex: currentIndex,
                          setIndex: (index) =>
                              setState(() => currentIndex = index),
                          withBadge: false,
                          badge: "",
                        ),
                        ComplaintTab(
                          title: "Pending",
                          index: 1,
                          currentIndex: currentIndex,
                          setIndex: (index) => {
                            if (currentIndex != index)
                              {
                                setState(() {
                                  currentIndex = index;
                                  // pendingIssuesLoading = true;
                                  pendingIssuesLoading = false;
                                  resolvedIssuesLoading = false;
                                  size = 15;
                                  status = 'PENDING';
                                })
                              }
                          },
                          withBadge: true,
                          badge: pending,
                        ),
                        ComplaintTab(
                          title: "Resolved",
                          index: 2,
                          currentIndex: currentIndex,
                          setIndex: (index) => {
                            if (currentIndex != index)
                              {
                                setState(() {
                                  currentIndex = index;
                                  pendingIssuesLoading = false;
                                  // resolvedIssuesLoading = true;
                                  resolvedIssuesLoading = false;
                                  size = 15;
                                  status = 'RESOLVED';
                                })
                              }
                          },
                          withBadge: true,
                          badge: resolved,
                        ),
                      ],
                    ),
                    addVerticalSpace(10.h),
                    currentIndex == 0
                        ? categoriesLoading
                            ? Container(
                                margin: EdgeInsets.only(bottom: 50),
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.42,
                                alignment: Alignment.center,
                                child: Text(
                                  "Loading",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.sp,
                                  ),
                                ))
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: issueCategories.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () => Get.to(() =>
                                        SubmitComplaintScreen(
                                            onSubmit: (issue) =>
                                                submitCallback(issue),
                                            navigateNext: (title, category,
                                                    subCategory) =>
                                                navigateNext(title, category,
                                                    subCategory))),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.transparent,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            issueCategories[index],
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: isDarkMode
                                                ? AppColors.white
                                                : AppColors.black,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                        : SizedBox(),
                    !categoriesLoading && currentIndex == 0
                        ? GestureDetector(
                            onTap: () => showDialog(
                              context: (context),
                              builder: (BuildContext context) =>
                                  CantFindMyIssue(
                                title: "0817-9435-965",
                                phone: "+2348179435965",
                              ),
                            ),
                            child: Container(
                              height: 20,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "Can't find your issue? Click Here.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    currentIndex == 1
                        ? pendingIssuesLoading
                            ? Container(
                                margin: EdgeInsets.only(bottom: 50),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "Loading",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.sp,
                                  ),
                                ))
                            : Expanded(
                                child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: pendingIssues.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 20),
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        SingleIssue(
                                            issue: pendingIssues[index],
                                            onTap: (issue) => {
                                                  Get.to(
                                                      () => PendingIssueScreen(
                                                            issue: null,
                                                            refreshIssue: () =>
                                                                getPendingIssues(),
                                                          ))
                                                })))
                        : SizedBox(),
                    !pendingIssuesLoading && currentIndex == 1
                        ? GestureDetector(
                            onTap: () => showDialog(
                              context: (context),
                              builder: (BuildContext context) =>
                                  CantFindMyIssue(
                                title: "0817-9435-965",
                                phone: "+2348179435965",
                              ),
                            ),
                            child: Container(
                              height: 20,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "Can't find your issue? Click Here.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    currentIndex == 2
                        ? resolvedIssuesLoading
                            ? Container(
                                margin: EdgeInsets.only(bottom: 50),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "Loading",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.sp,
                                  ),
                                ))
                            : Expanded(
                                child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: resolvedIssues.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 20),
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        SingleIssue(
                                            issue: pendingIssues[index],
                                            onTap: (issue) => {
                                                  Get.to(
                                                      () => ResolvedIssueScreen(
                                                            issue: null,
                                                            refreshIssue: () =>
                                                                getPendingIssues(),
                                                          ))
                                                })))
                        : SizedBox(),
                    !resolvedIssuesLoading && currentIndex == 2
                        ? GestureDetector(
                            onTap: () => showDialog(
                              context: (context),
                              builder: (BuildContext context) =>
                                  CantFindMyIssue(
                                title: "0817-9435-965",
                                phone: "+2348179435965",
                              ),
                            ),
                            child: Container(
                              height: 20,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "Can't find your issue? Click Here.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateNext(String title, String category, void dispenseSubCategory) {
    Future.delayed(
      const Duration(seconds: 1),
      () => {
        Get.to(() => DispenseErrorScreen(
              title: "",
              category: "",
              data: null,
              onSubmit: ((issue) => {submitCallback(issue)}),
            ))
      },
    );
  }

  Future<void> getPendingIssues() async {}
}
