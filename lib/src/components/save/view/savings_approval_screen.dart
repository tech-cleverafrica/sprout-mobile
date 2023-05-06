import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sprout_mobile/src/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/src/components/save/model/saving_model.dart';
import 'package:sprout_mobile/src/components/save/model/savings_model.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

class SavingsApprovalScreen extends StatelessWidget {
  const SavingsApprovalScreen({
    super.key,
    this.message = "You have successfully saved money for Housing",
    this.heading = "Successful",
  });

  final String message;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          pushUntil(
              page: BottomNav(
            index: 0,
          ));
          return Future.value(true);
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.mainGreen,
                  AppColors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              image: DecorationImage(
                  image: AssetImage("assets/images/rough_background.png"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Container(
                      height: 150.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFD9D9D9).withOpacity(0.4)),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: SvgPicture.asset(
                          AppSvg.mark,
                          color: AppColors.white,
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                      child: Text(
                    heading,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: "Mont",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                      child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Mont",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: CustomButton(
                              title: "Back To Savings",
                              onTap: () {
                                pushUntil(
                                    page: BottomNav(
                                  index: 1,
                                ));
                              }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Image.asset(
                    AppImages.sprout_dark,
                    height: 27.h,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
