import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/view/document_upload.dart';
import 'package:sprout_mobile/src/components/home/view/all_transactions.dart';
import 'package:sprout_mobile/src/components/home/view/home_chart.dart';
import 'package:sprout_mobile/src/components/home/view/widgets.dart';
import 'package:sprout_mobile/src/components/notification/controller/notification_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';
import '../controller/home_controller.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  late bool showInvoice = false;
  late HomeController homeController;
  late NotificationController notificationController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    homeController = Get.put(HomeController());
    notificationController = Get.put(NotificationController());

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: homeController.refreshData,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                addVerticalSpace(19.h),
                getHomeHeader(isDarkMode, homeController.abbreviation,
                    notificationController.size),
                addVerticalSpace(16.h),
                getHomeDisplay(isDarkMode, theme, context)
              ])),
        ),
      ),
    );
  }

  getHomeDisplay(isDarkMode, theme, context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                "Hi",
                style: TextStyle(
                  color: isDarkMode ? AppColors.white : AppColors.black,
                  fontFamily: "DMSans",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              addHorizontalSpace(5.w),
              Text(homeController.fullname,
                  style: TextStyle(
                    color: isDarkMode ? AppColors.white : AppColors.black,
                    fontFamily: "DMSans",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ),
        addVerticalSpace(16.h),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              BalanceCard(
                isDarkMode: isDarkMode,
                flag: AppSvg.nigeria,
                currency: "Naira",
                title: "Available Balance",
                symbol: "N",
                naira: homeController.walletBalance.toString(),
                kobo: "",
                bank: homeController.bankToUse,
                accountNumber: homeController.accountNumberToUse,
                buttontext: "Fund Account",
                buttonColor: AppColors.primaryColor,
                copyVisible: true,
                iconVisible: true,
                bankVisible: true,
                buttonVisible: true,
              ),
              addHorizontalSpace(10.w),
              BalanceCard(
                isDarkMode: isDarkMode,
                flag: AppSvg.nigeria,
                currency: "Naira",
                title: "Savings Balance",
                symbol: "N",
                naira: "19,260",
                kobo: "00",
                bank: "Providus Bank",
                accountNumber: "0087642335",
                buttontext: "Details",
                buttonColor: AppColors.black,
                copyVisible: false,
                iconVisible: false,
                bankVisible: false,
                buttonVisible: true,
              ),
              addHorizontalSpace(10.w),
              BalanceCard(
                isDarkMode: isDarkMode,
                flag: AppSvg.usa,
                currency: "USD",
                title: "Account Balance",
                symbol: 'N',
                naira: "19,260",
                kobo: "00",
                bank: "Providus Bank",
                accountNumber: "0087642335",
                buttontext: "Details",
                buttonColor: AppColors.black,
                copyVisible: false,
                iconVisible: false,
                bankVisible: false,
                buttonVisible: false,
              )
            ],
          ),
        ),
        addVerticalSpace(16.h),
        getItems(isDarkMode),
        SizedBox(
          height: 16.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            height: 160.h,
            child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF161618) : AppColors.greyBg,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  children: [
                    Container(
                      width: 282.w,
                      height: 122.h,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Complete Account Setup",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 12.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            addVerticalSpace(39.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Container(
                                  height: 37.h,
                                  width: 127.w,
                                  decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? AppColors.black
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: GestureDetector(
                                    onTap: () => Get.to(() => DocumentUpload()),
                                    child: Text(
                                      "Complete",
                                      style: TextStyle(
                                          fontFamily: "DMSans",
                                          fontSize: 13.sp,
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    addHorizontalSpace(10.w),
                    Container(
                      width: 282.w,
                      height: 122.h,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Complete Account Setup",
                              style: TextStyle(
                                  fontFamily: "DMSans",
                                  fontSize: 12.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            addVerticalSpace(39.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Container(
                                  height: 37.h,
                                  width: 127.w,
                                  decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? AppColors.black
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.topRight,
                                  child: Center(
                                      child: GestureDetector(
                                    onTap: () => Get.to(() => DocumentUpload()),
                                    child: Text(
                                      "Complete",
                                      style: TextStyle(
                                          fontFamily: "DMSans",
                                          fontSize: 13.sp,
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        addVerticalSpace(20.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 12.sp,
                    color: isDarkMode
                        ? AppColors.inputLabelColor
                        : AppColors.greyText,
                    fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  push(
                      page: AlltransactionScreen(),
                      arguments: homeController.transactions);
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      fontSize: 12.sp,
                      color: isDarkMode
                          ? AppColors.inputLabelColor
                          : AppColors.greyText,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
        addVerticalSpace(24.h),
        Obx((() => getTransactions(theme, isDarkMode))),
        addVerticalSpace(10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF161618) : AppColors.greyBg,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: HomeChart(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: HomeChart(color: AppColors.mainGreen),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getDisplaySwitch(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              // setState(() {
              //   showInvoice = false;
              // });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: isDarkMode ? AppColors.greyDot : AppColors.grey),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 10, left: 10),
                  child: Text(
                    "Account",
                    style: TextStyle(
                        fontFamily: "DmSans",
                        fontSize: 14.sp,
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // setState(() {
              //   showInvoice = true;
              // });
            },
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 10, left: 10),
                    child: Text(
                      "Invoice",
                      style: TextStyle(
                          fontFamily: "DmSans",
                          fontSize: 14.sp,
                          color:
                              isDarkMode ? AppColors.grey : AppColors.greyText,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getTransactions(theme, isDarkMode) {
    if (homeController.isTransactionLoading.value) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: buildShimmer(3),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
            itemCount: homeController.transactions.value.length > 5
                ? 5
                : homeController.transactions.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return HistoryCard(
                theme: theme,
                isDarkMode: isDarkMode,
                transactionType: homeController.transactions.value[index].type!,
                transactionAmount:
                    homeController.transactions.value[index].transactionAmount!,
                transactionRef: homeController.transactions.value[index].ref,
                transactionId: homeController.transactions.value[index].id,
                createdAt: homeController.transactions.value[index].createdAt,
              );
            })),
      );
    }
  }
}
