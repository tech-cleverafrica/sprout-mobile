import 'package:flutter/material.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';

class CantFindMyIssue extends StatefulWidget {
  CantFindMyIssue({required this.title, required this.phone});
  final String title;
  final String phone;
  @override
  _CantFindMyIssueState createState() => _CantFindMyIssueState();
}

class _CantFindMyIssueState extends State<CantFindMyIssue>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Material(
        color: AppColors.transparent,
        child: Stack(alignment: Alignment.center, children: [
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                color: Colors.transparent,
                width: double.infinity,
              )),
          ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              height: 200.h,
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isDarkMode ? AppColors.black : AppColors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Can't find your issue?",
                    style: TextStyle(
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Please call our customer support line on contact us on WhatsApp",
                    style: TextStyle(
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 12.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      color: AppColors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                          Image.asset(
                            isDarkMode
                                ? AppImages.call_light
                                : AppImages.call_dark,
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      color: AppColors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                          Image.asset(
                            AppImages.whatsapp,
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
