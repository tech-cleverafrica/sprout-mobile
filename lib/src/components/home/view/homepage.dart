import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/home/view/widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../utils/app_images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          addVerticalSpace(20.h),
          getHomeHeader(isDarkMode),
          addVerticalSpace(20.h),
          getDisplaySwitch(isDarkMode)
        ])),
      ),
    );
  }

  getInvoiceDisplay() {
    return Container(
      width: double.infinity,
      //height: 284.h,
      decoration: BoxDecoration(
          color: AppColors.deepOrange,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage(AppImages.invoice), fit: BoxFit.cover)),
      child: Column(
        children: [
          addVerticalSpace(50.h),
          Container(
              width: 200.w,
              child: Text(
                "Generate Invoices",
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 44.sp,
                    letterSpacing: 1,
                    color: AppColors.white,
                    fontWeight: FontWeight.w900),
              )),
          addVerticalSpace(10.h),
          Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(AppImages.invoice_overlay),
                      fit: BoxFit.cover)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 110.w,
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur. Placerat lorem neque risus.",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 12.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                        width: 100.w,
                        child: CustomButton(
                          title: "Get Started",
                          color: AppColors.black,
                          onTap: () {
                            //  Get.to(() => SavingsDashboard());
                          },
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }

  getHomeDisplay(isDarkMode, theme) {
    return Column(
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
              Text(
                "Mubarak,",
                style: theme.textTheme.headline2,
              )
            ],
          ),
        ),
        addVerticalSpace(20.h),
        getDisplaySwitch(isDarkMode),
        addVerticalSpace(10.h),
        SizedBox(
          height: 160.h,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            children: [
              BalanceCard(
                isDarkMode: isDarkMode,
                flag: AppSvg.nigeria,
                currency: "Naira",
                title: "Available Balance",
                symbol: "N",
                balance: "19,260.00",
                bank: "Providus Bank",
                accountNumber: "0087642335",
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
                balance: "19,260.00",
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
                balance: "120.00 ",
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
        addVerticalSpace(15.h),
        getItems(isDarkMode),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: 132.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              Container(
                width: 210.w,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Complete Account Setup",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 12.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      addVerticalSpace(50.h),
                      Container(
                        height: 37.h,
                        width: 127.w,
                        decoration: BoxDecoration(
                            color:
                                isDarkMode ? AppColors.black : AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.topRight,
                        child: Center(
                            child: Text(
                          "Complete",
                          style: theme.textTheme.headline3,
                        )),
                      )
                    ],
                  ),
                ),
              ),
              addHorizontalSpace(10.w),
              Container(
                width: 210.w,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Complete Account Setup",
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 12.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      addVerticalSpace(50.h),
                      Container(
                        height: 37.h,
                        width: 127.w,
                        decoration: BoxDecoration(
                            color:
                                isDarkMode ? AppColors.black : AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.topRight,
                        child: Center(
                            child: Text(
                          "Complete",
                          style: theme.textTheme.headline3,
                        )),
                      )
                    ],
                  ),
                ),
              )
            ],
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
              Text(
                "Sell All",
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    fontSize: 12.sp,
                    color: isDarkMode
                        ? AppColors.inputLabelColor
                        : AppColors.greyText,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        addVerticalSpace(24.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: HistoryCard(
              theme: theme, isDarkMode: isDarkMode, text: "Fund Transfer"),
        )
      ],
    );
  }
}
