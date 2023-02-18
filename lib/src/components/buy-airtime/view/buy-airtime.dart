import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/buy-airtime/view/select_network.dart';
import 'package:sprout_mobile/src/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/helper_widgets.dart';
import 'package:badges/badges.dart' as badges;

class BuyAirtimeScreen extends StatelessWidget {
  const BuyAirtimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeader(isDarkMode),
              addVerticalSpace(15.h),
              InkWell(
                onTap: () {
                  Get.to(() => SelectNetworkScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDarkMode ? AppColors.greyDot : AppColors.grey),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Send to my phone number",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            addVerticalSpace(10.h),
                            Row(
                              children: [
                                Image.asset(AppImages.airtel),
                                addHorizontalSpace(5.w),
                                Text(
                                  "+234-7082136463",
                                  style: TextStyle(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp),
                                )
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.arrow_forward))
                      ],
                    ),
                  ),
                ),
              ),
              addVerticalSpace(20.h),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDarkMode ? AppColors.greyDot : AppColors.grey),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AppImages.airtel,
                            height: 40,
                            width: 40,
                          ),
                          Image.asset(
                            AppImages.mtn,
                            height: 40,
                            width: 40,
                          ),
                          Image.asset(
                            AppImages.glo,
                            height: 40,
                            width: 40,
                          ),
                          Image.asset(
                            AppImages.nine_mobile,
                            height: 40,
                            width: 40,
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Divider(
                        thickness: 1.2,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Quick Actions',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      addVerticalSpace(20.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AmountCard(
                              isDarkMode: isDarkMode,
                              amount: "N3000",
                            ),
                            AmountCard(
                              isDarkMode: isDarkMode,
                              amount: "N5000",
                            ),
                            AmountCard(
                              isDarkMode: isDarkMode,
                              amount: "N10000",
                            )
                          ],
                        ),
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AmountCard(
                            isDarkMode: isDarkMode,
                            amount: "N300",
                          ),
                          AmountCard(
                            isDarkMode: isDarkMode,
                            amount: "N500",
                          ),
                          AmountCard(
                            isDarkMode: isDarkMode,
                            amount: "N500",
                          ),
                          AmountCard(
                            isDarkMode: isDarkMode,
                            amount: "N1000",
                          )
                        ],
                      ),
                      addVerticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AmountCard(
                            isDarkMode: isDarkMode,
                            amount: "N300",
                          ),
                          AmountCard(
                            isDarkMode: isDarkMode,
                            amount: "N500",
                          ),
                          AmountCard(
                            isDarkMode: isDarkMode,
                            amount: "N500",
                          ),
                          AmountCard(
                            isDarkMode: isDarkMode,
                            amount: "N1000",
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              addVerticalSpace(20.h),
              Text(
                "Send airtime to",
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? AppColors.white : AppColors.black,
                    fontSize: 12.sp),
              ),
              addVerticalSpace(5.h),
              getRecentContacts(isDarkMode)
            ],
          ),
        ),
      ),
    );
  }
}

class AmountCard extends StatelessWidget {
  const AmountCard({Key? key, required this.isDarkMode, required this.amount})
      : super(key: key);

  final bool isDarkMode;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isDarkMode ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          amount,
          style: TextStyle(
              fontFamily: "Outfit",
              color: isDarkMode ? AppColors.greyText : AppColors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

getRecentContacts(isDarkMode) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode ? AppColors.greyDot : AppColors.grey),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Contacts"),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz,
                      color: isDarkMode ? AppColors.greyDot : AppColors.grey))
            ],
          ),
          addVerticalSpace(5.h),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ContactCard(
                  text: "DJ",
                  background: AppColors.primaryColor,
                ),
                ContactCard(
                  text: "MI",
                  background: AppColors.errorRed,
                ),
                ContactCard(
                  text: "AA",
                  background: Colors.purple,
                ),
                ContactCard(
                  text: "AJ",
                  background: Colors.orange,
                ),
                ContactCard(
                  text: "HM",
                  background: Colors.green,
                ),
                ContactCard(
                  text: "GT",
                  background: AppColors.primaryColor,
                ),
                ContactCard(
                  text: "GT",
                  background: AppColors.primaryColor,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class ContactCard extends StatelessWidget {
  ContactCard({
    Key? key,
    required this.text,
    required this.background,
  }) : super(key: key);
  final String text;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: badges.Badge(
        position: badges.BadgePosition.bottomEnd(bottom: 12, end: -10),
        badgeStyle: badges.BadgeStyle(badgeColor: Colors.green),
        badgeContent: Container(
            height: 10,
            width: 10,
            child: Center(
              child: Icon(
                Icons.arrow_forward,
                size: 9,
                color: AppColors.white,
              ),
            )),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: background),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? AppColors.white : AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
