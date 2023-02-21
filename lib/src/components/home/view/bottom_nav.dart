import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprout_mobile/src/components/cards/view/cards.dart';
import 'package:sprout_mobile/src/components/home/view/homepage.dart';
import 'package:sprout_mobile/src/components/invoice/view/invoice.dart';
import 'package:sprout_mobile/src/components/profile/view/profile.dart';
import 'package:sprout_mobile/src/components/save/view/savings.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';

import '../../../utils/app_colors.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  List bottomNavPages = [
    HomePage(),
    CardsScreen(),
    SavingsScreen(),
    InvoiceScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: bottomNavPages[currentTabIndex],
      bottomNavigationBar: BottomAppBar(
        color: isDarkMode ? AppColors.black : AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            height: Platform.isIOS ? 55.0 : 66.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isDarkMode ? AppColors.greyDot : AppColors.white),
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildMaterialButton(
                    "Home", AppSvg.home, AppSvg.home_filled, 0, isDarkMode),
                // buildMaterialButton("Cards", AppSvg.cards, AppSvg.cards, 1),
                buildMaterialButton(
                    "Savings", AppSvg.savings, AppSvg.savings, 2, isDarkMode),
                buildMaterialButton(
                    "Invoice", AppSvg.invoice, AppSvg.invoice, 3, isDarkMode),
                buildMaterialButton(
                    "Manage", AppSvg.profile, AppSvg.profile, 4, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildMaterialButton(String title, String image, String imageFilled,
      int position, bool isDark) {
    return StreamBuilder<int>(builder: (context, snapshot) {
      return Expanded(
        child: Container(
          child: InkWell(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            onTap: () => setState(() => currentTabIndex = position),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 5.0),
                isDark
                    ? SvgPicture.asset(
                        currentTabIndex == position ? imageFilled : image,
                        width: 18.0,
                        height: 20.0,
                        color: currentTabIndex == position
                            ? AppColors.primaryColor
                            : AppColors.greyBg,
                      )
                    : SvgPicture.asset(
                        currentTabIndex == position ? imageFilled : image,
                        width: 18.0,
                        height: 20.0,
                        color: currentTabIndex == position
                            ? AppColors.primaryColor
                            : AppColors.greyText,
                      ),
                SizedBox(height: 8.0),
                isDark
                    ? Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          fontFamily: "DMSans",
                          color: currentTabIndex == position
                              ? AppColors.white
                              : AppColors.greyText,
                        ),
                      )
                    : Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          fontFamily: "DMSans",
                          color: currentTabIndex == position
                              ? AppColors.black
                              : AppColors.greyText,
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
