import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprout_mobile/components/help/view/complaint.dart';
import 'package:sprout_mobile/components/home/controller/home_controller.dart';
import 'package:sprout_mobile/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/components/invoice/view/invoice.dart';
import 'package:sprout_mobile/components/notification/controller/notification_controller.dart';
import 'package:sprout_mobile/components/notification/view/notification.dart';
import 'package:sprout_mobile/public/widgets/custom_button.dart';
import 'package:sprout_mobile/utils/app_svgs.dart';
import 'package:sprout_mobile/utils/nav_function.dart';
import 'package:badges/badges.dart' as badges;

import '../../components/home/view/homepage.dart';
import '../../components/profile/view/profile.dart';
import '../../components/save/view/savings.dart';
import '../../utils/app_colors.dart';
import '../../utils/helper_widgets.dart';

late HomeController homeController = Get.put(HomeController());
late NotificationController notificationController =
    Get.put(NotificationController());
final storage = GetStorage();

getHeader(bool isDarkMode, {hideHelp = false, hideNotification = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
                onTap: () {
                  String? remove = storage.read("removeAll");
                  if (remove == "1") {
                    storage.remove("removeAll");
                    pushUntil(page: BottomNav());
                  } else
                    pop();
                },
                child: Container(
                  padding: EdgeInsets.only(right: 5, bottom: 5, top: 5),
                  child: SvgPicture.asset(
                    AppSvg.arrow_left,
                    width: 14.0,
                    height: 15.0,
                    color:
                        isDarkMode ? AppColors.greyBg : AppColors.primaryColor,
                  ),
                )),
            SizedBox(
              width: 18,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode
                      ? AppColors.greyDot
                      : Color.fromRGBO(61, 2, 230, 0.1)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    homeController.abbreviation,
                    style: TextStyle(
                        fontFamily: "Mont",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            !hideHelp
                ? InkWell(
                    onTap: () => Get.to(() => ComplaintScreen()),
                    child: SvgPicture.asset(
                      AppSvg.upload,
                      height: 18,
                      color: isDarkMode ? AppColors.white : AppColors.black,
                    ))
                : SizedBox(),
            !hideHelp && !hideNotification
                ? addHorizontalSpace(24.w)
                : SizedBox(),
            !hideNotification
                ? InkWell(
                    onTap: () => Get.to(() => NotificationScreen()),
                    child: notificationController.size.value == 0
                        ? Icon(
                            Icons.notifications,
                            color:
                                isDarkMode ? AppColors.white : AppColors.black,
                          )
                        : badges.Badge(
                            child: Icon(
                              Icons.notifications,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                            badgeContent: SizedBox(
                                width: 18,
                                height: 10, //badge size
                                child: Center(
                                  //aligh badge content to center
                                  child: Text(
                                      notificationController.size.value
                                          .toString(),
                                      style: TextStyle(
                                          color:
                                              Colors.white, //badge font color
                                          fontSize: 7.sp //badge font size
                                          )),
                                )),
                          ))
                : SizedBox(),
          ],
        )
      ],
    ),
  );
}

getPopupHeader(bool isDarkMode,
    {hideHelp = false, hideNotification = false, int size = 0}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
                onTap: () => pop(),
                child: Container(
                    padding: EdgeInsets.only(right: 5, bottom: 5),
                    child: Icon(
                      Icons.close,
                      color: isDarkMode
                          ? AppColors.greyBg
                          : AppColors.primaryColor,
                    ))),
          ],
        ),
      ],
    ),
  );
}

class PINNumber extends StatelessWidget {
  final TextEditingController? textEditingController;
  final OutlineInputBorder? outlineInputBorder;
  final String? value;
  PINNumber({this.textEditingController, this.outlineInputBorder, this.value});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 25.0,
      height: 25.0,
      child: Center(
        child: TextField(
          controller: textEditingController,
          enabled: false,
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.solid,
                      color: isDarkMode ? AppColors.white : AppColors.black)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(
                      width: 1,
                      style: BorderStyle.solid,
                      color: isDarkMode ? AppColors.white : AppColors.black)),
              filled: true,
              // fillColor: isDarkMode ? AppColors.black : Colors.white30
              fillColor: value == ""
                  ? AppColors.transparent
                  : isDarkMode
                      ? AppColors.white
                      : Colors.black),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21.0,
              color: isDarkMode ? AppColors.white : AppColors.black),
        ),
      ),
    );
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  KeyboardNumber({required this.n, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode ? AppColors.greyDot : AppColors.greyBg),
        alignment: Alignment.center,
        child: MaterialButton(
          padding: EdgeInsets.all(8.0),
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
          height: 90.0,
          child: Text(
            "$n",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21.sp,
              fontFamily: "Mont",
              fontWeight: FontWeight.w600,
            ),
          ),
        ));
  }
}

class DecisionButton extends StatelessWidget {
  const DecisionButton({
    Key? key,
    required this.isDarkMode,
    required this.buttonText,
    required this.onTap,
    this.onBack,
  }) : super(key: key);

  final bool isDarkMode;
  final String buttonText;
  final VoidCallback onTap;
  final Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 246.w,
          child: CustomButton(title: buttonText, onTap: onTap),
        ),
        addHorizontalSpace(8.w),
        Expanded(
            child: InkWell(
          onTap: () => onBack != null ? onBack!() : pop(),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.inputBackgroundColor
                    : AppColors.black,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Go Back",
                style: TextStyle(fontFamily: "Mont", color: AppColors.white),
              ),
            ),
          ),
        ))
      ],
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentTabIndex = 0;

  List pages = [HomePage(), SavingsScreen(), InvoiceScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
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
                "Savings", AppSvg.savings, AppSvg.savings, 1, isDarkMode),
            buildMaterialButton(
                "Invoice", AppSvg.invoice, AppSvg.invoice, 2, isDarkMode),
            buildMaterialButton(
                "Manage", AppSvg.profile, AppSvg.profile, 3, isDarkMode),
          ],
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
            //onTap: () => setState(() => currentTabIndex = position),
            onTap: () {
              switch (position) {
                case 0:
                  Get.to(BottomNav(index: 0));
                  break;
                case 1:
                  Get.to(BottomNav(index: 1));
                  break;
                case 2:
                  Get.to(BottomNav(index: 2));
                  break;
                case 3:
                  Get.to(BottomNav(index: 3));
                  break;
                default:
              }
            },
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
                          fontFamily: "Mont",
                          color: currentTabIndex == position
                              ? AppColors.white
                              : AppColors.greyText,
                        ),
                      )
                    : Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          fontFamily: "Mont",
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