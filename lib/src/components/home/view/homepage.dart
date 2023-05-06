import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/view/document_upload.dart';
import 'package:sprout_mobile/src/components/fund-wallet/view/fund_wallet.dart';
import 'package:sprout_mobile/src/components/home/view/all_transactions.dart';
import 'package:sprout_mobile/src/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/src/components/home/view/home_chart.dart';
import 'package:sprout_mobile/src/components/home/view/transaction_details.dart';
import 'package:sprout_mobile/src/components/home/view/widgets.dart';
import 'package:sprout_mobile/src/components/notification/controller/notification_controller.dart';
import 'package:sprout_mobile/src/components/profile/controller/profile_controller.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/public/widgets/custom_loader.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/global_function.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';
import '../controller/home_controller.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  late bool showInvoice = false;
  late HomeController homeController;
  late NotificationController notificationController;
  late ProfileController profileController;
  var f = NumberFormat('#,##0.00########', 'en_Us');
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    homeController = Get.put(HomeController());
    notificationController = Get.put(NotificationController());
    profileController = Get.put(ProfileController());
    return SafeArea(
        child: WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: homeController.refreshData,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                addVerticalSpace(19.h),
                Obx((() => getHomeHeader(
                    isDarkMode,
                    homeController.abbreviation,
                    notificationController.size.value))),
                addVerticalSpace(16.h),
                getHomeDisplay(isDarkMode, theme, context)
              ])),
        ),
      ),
    ));
  }

  Future<bool> _onWillPop() async {
    final isDarkMode = Theme.of(Get.context!).brightness == Brightness.dark;
    return await showDialog(
            context: Get.context!,
            barrierDismissible: true,
            builder: ((context) {
              return Dialog(
                backgroundColor:
                    isDarkMode ? AppColors.blackBg : AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () => Get.back(),
                                child: SvgPicture.asset(
                                  AppSvg.cancel,
                                  height: 20,
                                ))
                          ],
                        ),
                        addVerticalSpace(25.h),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "Are you sure you want to logout?",
                            style: TextStyle(
                                fontFamily: "Mont",
                                fontSize: 14.sp,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Column(
                          children: [
                            addVerticalSpace(30.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: CustomButton(
                                title: "Yes",
                                onTap: () {
                                  pop();
                                  profileController.logout();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: CustomButton(
                                title: "Cancel",
                                onTap: () {
                                  pop();
                                },
                                color: AppColors.red,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })) ??
        false;
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
                  fontFamily: "Mont",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              addHorizontalSpace(5.w),
              Text(homeController.fullname,
                  style: TextStyle(
                    color: isDarkMode ? AppColors.white : AppColors.black,
                    fontFamily: "Mont",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ),
        addVerticalSpace(16.h),
        SizedBox(
          height:
              homeController.isApproved.value && !homeController.inReview.value
                  ? MediaQuery.of(context).size.height * 0.17
                  : MediaQuery.of(context).size.height * 0.13,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Obx((() => BalanceCard(
                    isDarkMode: isDarkMode,
                    flag: AppSvg.nigeria,
                    currency: "Naira",
                    title: "Available Balance",
                    symbol: currencySymbol,
                    naira: homeController.formatter
                        .formatAsMoney(homeController.walletBalance.value),
                    kobo: "",
                    bank: homeController.bankToUse.value,
                    accountNumber: homeController.accountNumberToUse.value,
                    buttontext: "Fund Account",
                    buttonColor: AppColors.black,
                    copyVisible: true,
                    iconVisible: true,
                    bankVisible: true,
                    buttonVisible: true,
                    showAmount: homeController.showAmount.value,
                    onTap: () {
                      storage.write('removeAll', "1");
                      push(page: FundWalletScreen());
                    },
                    setVisibility: () => {
                      homeController.showAmount.value =
                          !homeController.showAmount.value
                    },
                    isApproved: homeController.isApproved.value,
                    inReview: homeController.inReview.value,
                  ))),
              addHorizontalSpace(10.w),
              Obx((() => BalanceCard(
                    isDarkMode: isDarkMode,
                    flag: AppSvg.nigeria,
                    currency: "Naira",
                    title: "Savings Balance",
                    symbol: currencySymbol,
                    naira: f.format(homeController.savingsBalance.value),
                    kobo: "",
                    bank: "",
                    accountNumber: "",
                    buttontext: "Details",
                    buttonColor: AppColors.black,
                    copyVisible: false,
                    iconVisible: false,
                    bankVisible: false,
                    buttonVisible: true,
                    showAmount: homeController.showSavingsAmount.value,
                    onTap: () => {
                      pushUntil(
                          page: BottomNav(
                        index: 1,
                      )),
                    },
                    setVisibility: () => {
                      homeController.showSavingsAmount.value =
                          !homeController.showSavingsAmount.value
                    },
                    isApproved: homeController.isApproved.value,
                    inReview: homeController.inReview.value,
                  ))),
              // addHorizontalSpace(10.w),
              // BalanceCard(
              //   isDarkMode: isDarkMode,
              //   flag: AppSvg.usa,
              //   currency: "USD",
              //   title: "Account Balance",
              //   symbol: 'N',
              //   naira: "19,260",
              //   kobo: "00",
              //   bank: "Providus Bank",
              //   accountNumber: "0087642335",
              //   buttontext: "Details",
              //   buttonColor: AppColors.black,
              //   copyVisible: false,
              //   iconVisible: false,
              //   bankVisible: false,
              //   buttonVisible: false,
              // showAmount: homeController.showAmount.value,
              //   onTap: () => {},
              // )
            ],
          ),
        ),
        homeController.isApproved.value && !homeController.inReview.value
            ? addVerticalSpace(16.h)
            : SizedBox(),
        homeController.isApproved.value && !homeController.inReview.value
            ? getItems(isDarkMode)
            : SizedBox(),
        SizedBox(
          height: 16.h,
        ),
        Obx((() => !homeController.isApproved.value
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 160.h,
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            isDarkMode ? Color(0xFF161618) : AppColors.greyBg,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        children: [
                          homeController.isApproved.value
                              ? SizedBox()
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.83,
                                  // width: 282.w,
                                  height: 122.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Complete Account Setup",
                                          style: TextStyle(
                                              fontFamily: "Mont",
                                              fontSize: 12.sp,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        addVerticalSpace(39.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(),
                                            Container(
                                              height: 37.h,
                                              width: 127.w,
                                              decoration: BoxDecoration(
                                                  color: isDarkMode
                                                      ? AppColors.black
                                                      : AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                  child: GestureDetector(
                                                onTap: () => {
                                                  homeController.inReview.value
                                                      ? {}
                                                      : Get.to(() =>
                                                          DocumentUpload())
                                                },
                                                child: Text(
                                                  "Complete",
                                                  style: TextStyle(
                                                      fontFamily: "Mont",
                                                      fontSize: 13.sp,
                                                      color: isDarkMode
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                          // homeController.isApproved.value
                          //     ? SizedBox()
                          //     : addHorizontalSpace(10.w),
                          // Container(
                          //   width: homeController.isApproved.value
                          //       ? MediaQuery.of(context).size.width * .825
                          //       : 282.w,
                          //   height: 122.h,
                          //   decoration: BoxDecoration(
                          //       color: AppColors.primaryColor,
                          //       borderRadius: BorderRadius.circular(10)),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(15.0),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text(
                          //           "Advert will be placed here",
                          //           style: TextStyle(
                          //               fontFamily: "Mont",
                          //               fontSize: 12.sp,
                          //               color: AppColors.white,
                          //               fontWeight: FontWeight.w500),
                          //         ),
                          //         addVerticalSpace(39.h),
                          //         Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Container(),
                          //             Container(
                          //               height: 37.h,
                          //               width: 127.w,
                          //               decoration: BoxDecoration(
                          //                   color: isDarkMode
                          //                       ? AppColors.black
                          //                       : AppColors.white,
                          //                   borderRadius:
                          //                       BorderRadius.circular(10)),
                          //               alignment: Alignment.topRight,
                          //               child: Center(
                          //                   child: GestureDetector(
                          //                 onTap: () => {},
                          //                 child: Text(
                          //                   "Advert button",
                          //                   style: TextStyle(
                          //                       fontFamily: "Mont",
                          //                       fontSize: 13.sp,
                          //                       color: isDarkMode
                          //                           ? AppColors.white
                          //                           : AppColors.black,
                          //                       fontWeight: FontWeight.w400),
                          //                 ),
                          //               )),
                          //             ),
                          //           ],
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox())),
        Obx((() =>
            homeController.isApproved.value && !homeController.inReview.value
                ? addVerticalSpace(20.h)
                : SizedBox())),
        Obx((() =>
            homeController.isApproved.value && !homeController.inReview.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Transactions",
                          style: TextStyle(
                              fontFamily: "Mont",
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
                              // arguments: homeController.transactions
                            );
                          },
                          child: Text(
                            "See All",
                            style: TextStyle(
                                fontFamily: "Mont",
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
                  )
                : SizedBox())),
        Obx((() =>
            homeController.isApproved.value && !homeController.inReview.value
                ? addVerticalSpace(24.h)
                : SizedBox())),
        Obx((() =>
            homeController.isApproved.value && !homeController.inReview.value
                ? getTransactions(theme, isDarkMode)
                : SizedBox())),
        Obx((() =>
            homeController.isApproved.value && !homeController.inReview.value
                ? addVerticalSpace(10.h)
                : SizedBox())),
        Obx((() => homeController.isApproved.value &&
                !homeController.inReview.value
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            isDarkMode ? Color(0xFF161618) : AppColors.greyBg,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: isDarkMode
                                    ? AppColors.black
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 8),
                                  child: Text("Received",
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? AppColors.inputLabelColor
                                              : AppColors.black,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: HomeChart(
                                    color: AppColors.mainGreen,
                                    graph: homeController.inflowGraph.value,
                                    maxY: max(
                                        homeController
                                            .inflowGraph.value["maxY"],
                                        homeController
                                            .outflowGraph.value["maxY"]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: isDarkMode
                                    ? AppColors.black
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 8),
                                  child: Text(
                                    "Spent",
                                    style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.inputLabelColor
                                            : AppColors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: HomeChart(
                                    color: AppColors.primaryColor,
                                    graph: homeController.outflowGraph.value,
                                    maxY: max(
                                        homeController
                                            .inflowGraph.value["maxY"],
                                        homeController
                                            .outflowGraph.value["maxY"]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox())),
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
                        fontFamily: "Mont",
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
                          fontFamily: "Mont",
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
            itemCount: homeController.transactions.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () => push(
                    page: TransactionDetailsScreen(),
                    arguments: homeController.transactions[index]),
                child: HistoryCard(
                  theme: theme,
                  isDarkMode: isDarkMode,
                  transactionType:
                      homeController.transactions[index].type ?? "",
                  transactionAmount:
                      homeController.transactions[index].transactionAmount!,
                  createdAt: homeController.transactions[index].createdAt,
                  balance: homeController.transactions[index].postBalance,
                  tfFee: homeController.transactions[index].transactionFee,
                  commission: homeController.transactions[index].agentCut,
                  incoming:
                      homeController.transactions[index].type == "CASH_OUT" ||
                          homeController.transactions[index].type ==
                              "WALLET_TOP_UP",
                  narration: homeController.transactions[index].type ==
                              "DEPOSIT" ||
                          homeController.transactions[index].type ==
                              "FUNDS_TRANSFER" ||
                          homeController.transactions[index].type ==
                              "WALLET_TOP_UP"
                      ? homeController.transactions[index].narration
                      : homeController.transactions[index].type ==
                              "BILLS_PAYMENT"
                          ? homeController.transactions[index].billerPackage
                          : homeController.transactions[index].type ==
                                  "AIRTIME_VTU"
                              ? homeController.transactions[index].billerPackage
                              : homeController
                                  .transactions[index].transactionID,
                ),
              );
            })),
      );
    }
  }
}
