import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/components/help/controller/help_controller.dart';
import 'package:sprout_mobile/src/components/help/view/cant_find_my_issue.dart';
import 'package:sprout_mobile/src/components/help/view/complaint_tab.dart';
import 'package:sprout_mobile/src/components/help/view/pending_issue.dart';
import 'package:sprout_mobile/src/components/help/view/reolved_issue.dart';
import 'package:sprout_mobile/src/components/help/view/singleIssue.dart';
import 'package:sprout_mobile/src/components/help/view/submit_complaint.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class ComplaintScreen extends StatelessWidget {
  ComplaintScreen({super.key});

  late HelpController helpController;
  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    helpController = Get.put(HelpController());
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
                          currentIndex: helpController.currentIndex.value,
                          setIndex: (index) =>
                              helpController.currentIndex.value = index,
                          withBadge: false,
                          badge: "",
                        ),
                        ComplaintTab(
                          title: "Pending",
                          index: 1,
                          currentIndex: helpController.currentIndex.value,
                          setIndex: (index) => {
                            if (helpController.currentIndex.value != index)
                              {
                                helpController.currentIndex.value = index,
                                // pendingIssuesLoading = true;
                                helpController.pendingIssuesLoading = false,
                                helpController.resolvedIssuesLoading = false,
                                helpController.size = 15,
                                helpController.status = 'PENDING',
                              }
                          },
                          withBadge: true,
                          badge: helpController.pending,
                        ),
                        ComplaintTab(
                          title: "Resolved",
                          index: 2,
                          currentIndex: helpController.currentIndex.value,
                          setIndex: (index) => {
                            if (helpController.currentIndex.value != index)
                              {
                                helpController.currentIndex.value = index,
                                helpController.pendingIssuesLoading = false,
                                // resolvedIssuesLoading = true,
                                helpController.resolvedIssuesLoading = false,
                                helpController.size = 15,
                                helpController.status = 'RESOLVED',
                              }
                          },
                          withBadge: true,
                          badge: helpController.resolved,
                        ),
                      ],
                    ),
                    addVerticalSpace(10.h),
                    Obx((() => helpController.currentIndex.value == 0
                        ? helpController.categoriesLoading.value
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
                                  itemCount: helpController.categories.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () => Get
                                        .to(() => SubmitComplaintScreen(
                                            onSubmit: (issue) => helpController
                                                .submitCallback(issue),
                                            navigateNext: (title, category,
                                                    subCategory) =>
                                                helpController.navigateNext(
                                                    title,
                                                    category,
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
                                            helpController
                                                    .categories[index].name ??
                                                "",
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
                        : SizedBox())),
                    Obx((() => !helpController.categoriesLoading.value &&
                            helpController.currentIndex.value == 0
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
                        : SizedBox())),
                    Obx((() => helpController.currentIndex.value == 1
                        ? helpController.pendingIssuesLoading
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
                                    itemCount:
                                        helpController.pendingIssues.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 20),
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        SingleIssue(
                                            issue: helpController
                                                .pendingIssues[index],
                                            onTap: (issue) => {
                                                  Get.to(
                                                      () => PendingIssueScreen(
                                                            issue: null,
                                                            refreshIssue: () =>
                                                                helpController
                                                                    .getPendingIssues(),
                                                          ))
                                                })))
                        : SizedBox())),
                    Obx((() => !helpController.pendingIssuesLoading &&
                            helpController.currentIndex.value == 1
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
                        : SizedBox())),
                    Obx((() => helpController.currentIndex.value == 2
                        ? helpController.resolvedIssuesLoading
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
                                    itemCount:
                                        helpController.resolvedIssues.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 20),
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        SingleIssue(
                                            issue: helpController
                                                .pendingIssues[index],
                                            onTap: (issue) => {
                                                  Get.to(
                                                      () => ResolvedIssueScreen(
                                                            issue: null,
                                                            refreshIssue: () =>
                                                                helpController
                                                                    .getPendingIssues(),
                                                          ))
                                                })))
                        : SizedBox())),
                    Obx((() => !helpController.resolvedIssuesLoading &&
                            helpController.currentIndex.value == 2
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
                        : SizedBox())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
