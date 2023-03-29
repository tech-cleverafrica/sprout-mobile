import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sprout_mobile/src/components/help/controller/help_controller.dart';
import 'package:sprout_mobile/src/components/help/model/issues_model.dart';
import 'package:sprout_mobile/src/components/help/model/issues_sub_category_model.dart';
import 'package:sprout_mobile/src/public/screens/contact_us.dart';
import 'package:sprout_mobile/src/components/help/view/complaint_tab.dart';
import 'package:sprout_mobile/src/components/help/view/dispense_error.dart';
import 'package:sprout_mobile/src/components/help/view/pending_issue.dart';
import 'package:sprout_mobile/src/components/help/view/reolved_issue.dart';
import 'package:sprout_mobile/src/components/help/view/singleIssue.dart';
import 'package:sprout_mobile/src/components/help/view/submit_complaint.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class ComplaintScreen extends StatelessWidget {
  ComplaintScreen({super.key});

  late HelpController helpController;

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
                    Obx((() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ComplaintTab(
                              title: "Select Issue",
                              index: 0,
                              setIndex: (index) =>
                                  helpController.currentIndex.value = index,
                              withBadge: false,
                              badge: "",
                            ),
                            ComplaintTab(
                              title: "Pending",
                              index: 1,
                              setIndex: (index) => {
                                if (helpController.currentIndex.value != index)
                                  {
                                    helpController.currentIndex.value = index,
                                    helpController.pendingIssuesLoading.value =
                                        true,
                                    helpController.resolvedIssuesLoading.value =
                                        false,
                                    helpController.size.value = 15,
                                    helpController.status.value = 'PENDING',
                                    helpController.getPendingIssues(),
                                  }
                              },
                              withBadge: true,
                              badge: helpController.pending.value,
                            ),
                            ComplaintTab(
                              title: "Resolved",
                              index: 2,
                              setIndex: (index) => {
                                if (helpController.currentIndex.value != index)
                                  {
                                    helpController.currentIndex.value = index,
                                    helpController.pendingIssuesLoading.value =
                                        false,
                                    helpController.resolvedIssuesLoading.value =
                                        true,
                                    helpController.size.value = 15,
                                    helpController.status.value = 'RESOLVED',
                                    helpController.getIssues(),
                                  }
                              },
                              withBadge: true,
                              badge: helpController.resolved.value,
                            ),
                          ],
                        ))),
                    Obx((() => helpController.currentIndex.value == 0
                        ? helpController.categoriesLoading.value
                            ? Container(
                                margin: EdgeInsets.only(bottom: 50),
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.42,
                                alignment: Alignment.center,
                                child: SpinKitFadingCircle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  size: 30,
                                ))
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: helpController.categories.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () => Get.to(() =>
                                        SubmitComplaintScreen(
                                            onSubmit: (issue) => {
                                                  submitCallback(
                                                      issue, context),
                                                  helpController
                                                      .getPendingIssues(),
                                                  helpController.getIssues(),
                                                  helpController.getOverview()
                                                },
                                            id: helpController
                                                    .categories[index].id ??
                                                "",
                                            category: helpController
                                                    .categories[index]
                                                    .category ??
                                                "",
                                            navigateNext: (category,
                                                    subCategory) =>
                                                navigateNext(category,
                                                    subCategory, context))),
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
                              builder: (BuildContext context) => ContactUs(
                                heading: "Can't find your issue?",
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
                        ? helpController.pendingIssuesLoading.value
                            ? Container(
                                margin: EdgeInsets.only(bottom: 50),
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.42,
                                alignment: Alignment.center,
                                child: SpinKitFadingCircle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  size: 30,
                                ))
                            : helpController.pendingIssues.isEmpty
                                ? Expanded(
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.42,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "You have no pending issue",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic),
                                        )),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        controller:
                                            helpController.scrollController,
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
                                                          () =>
                                                              PendingIssueScreen(
                                                                refreshIssue:
                                                                    () => {
                                                                  helpController
                                                                      .getPendingIssues(),
                                                                  helpController
                                                                      .getIssues(),
                                                                  helpController
                                                                      .getOverview()
                                                                },
                                                              ),
                                                          arguments: issue)
                                                    })))
                        : SizedBox())),
                    Obx((() => !helpController.pendingIssuesLoading.value &&
                            helpController.currentIndex.value == 1
                        ? GestureDetector(
                            onTap: () => showDialog(
                              context: (context),
                              builder: (BuildContext context) => ContactUs(
                                heading: "Can't find your issue?",
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
                        ? helpController.resolvedIssuesLoading.value
                            ? Container(
                                margin: EdgeInsets.only(bottom: 50),
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.42,
                                alignment: Alignment.center,
                                child: SpinKitFadingCircle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  size: 30,
                                ))
                            : helpController.resolvedIssues.isEmpty
                                ? Expanded(
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.42,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "You have no resolved issue",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic),
                                        )),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        controller:
                                            helpController.scrollController,
                                        itemCount: helpController
                                            .resolvedIssues.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(top: 20),
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            SingleIssue(
                                                issue: helpController
                                                    .resolvedIssues[index],
                                                onTap: (issue) => {
                                                      Get.to(() =>
                                                          ResolvedIssueScreen(
                                                            issue: issue,
                                                            refreshIssue: () =>
                                                                {
                                                              helpController
                                                                  .getPendingIssues(),
                                                              helpController
                                                                  .getIssues(),
                                                              helpController
                                                                  .getOverview()
                                                            },
                                                            onReopened: (issue) =>
                                                                reopenedCallback(
                                                                    issue,
                                                                    context),
                                                          ))
                                                    })))
                        : SizedBox())),
                    Obx((() => !helpController.resolvedIssuesLoading.value &&
                            helpController.currentIndex.value == 2
                        ? GestureDetector(
                            onTap: () => showDialog(
                              context: (context),
                              builder: (BuildContext context) => ContactUs(
                                heading: "Can't find your issue?",
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

  void reopenedCallback(Issues issue, BuildContext context) {
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
                height: 150,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                      "Your complaint has been reopened, and it will be resolved shortly",
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

  void submitCallback(Issues issue, BuildContext context) {
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
                              "Dear " +
                                  helpController.inCaps(helpController.name) +
                                  ",",
                              style: theme.textTheme.subtitle2,
                            ),
                            addVerticalSpace(5.h),
                            issue.sla == null
                                ? Text(
                                    "Your complaint has been received. This will be resolved within " +
                                        issue.sla.toString() +
                                        ".",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontSize: 12.sp,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    "Your complaint has been received. This will be resolved within " +
                                        helpController.toHrMin(issue.sla) +
                                        ".",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontSize: 12.sp,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            addVerticalSpace(5.h),
                            Text(
                              "Your Case ID is:",
                              style: theme.textTheme.subtitle2,
                            ),
                            addVerticalSpace(5.h),
                            Text(
                              issue.caseId ?? '-',
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

  void navigateNext(String category, IssuesSubCategory? dispenseSubCategory,
      BuildContext context) {
    CustomLoader.show(message: "Please wait");
    Future.delayed(
      const Duration(seconds: 1),
      () => {
        CustomLoader.dismiss(),
        push(
            page: DispenseErrorScreen(
          category: category,
          data: dispenseSubCategory,
          onSubmit: ((issue) => {
                submitCallback(issue, context),
                helpController.getPendingIssues(),
                helpController.getIssues(),
                helpController.getOverview()
              }),
        ))
      },
    );
  }
}
