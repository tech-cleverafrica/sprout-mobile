import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Lottie.asset(
                  'assets/lottie/coming_soon.json',
                  height: 300.h,
                  repeat: true,
                  reverse: true,
                  animate: true,
                ),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(100))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    Text(
                      "Coming Soon",
                      style: TextStyle(
                          fontFamily: "DMSans",
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: 350.w,
                      child: Text(
                        "We are currently working on this feature and will be back soon!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "DMSans",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomButton(
                        title: "Go Back",
                        color: AppColors.black,
                        borderRadius: 30,
                        onTap: () {
                          pop();
                        },
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
