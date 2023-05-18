import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../../utils/app_colors.dart';

class CardlessFeedback extends StatelessWidget {
  CardlessFeedback({
    required this.title,
    required this.message,
  });
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
          height: 120,
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
                title,
                style: TextStyle(
                  color: isDarkMode ? AppColors.white : AppColors.black,
                  fontSize: 12.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                message + ".",
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
            ],
          )),
    );
  }
}

class NFCFeedback extends StatelessWidget {
  NFCFeedback({
    required this.title,
    required this.message,
    this.expanded = false,
    this.request,
  });
  final String title;
  final String message;
  final bool expanded;
  final VoidCallback? request;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      backgroundColor: isDarkMode ? AppColors.blackBg : AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
          height: expanded ? 300 : 200,
          width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 12.sp,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
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
                ],
              ),
              expanded
                  ? CustomButton(
                      onTap: () {
                        pop();
                        request!();
                      },
                      title: "REQUEST",
                    )
                  : SizedBox()
            ],
          )),
    );
  }
}
