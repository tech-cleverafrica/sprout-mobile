import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sprout_mobile/src/components/home/view/bottom_nav.dart';
import 'package:sprout_mobile/src/utils/nav_function.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_svgs.dart';
import '../../utils/helper_widgets.dart';
import '../widgets/custom_button.dart';
import 'package:get/get.dart';

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({
    super.key,
    this.containShare = true,
    this.heading = "Successful",
    this.messages = "",
  });

  final String heading;
  final String messages;
  final bool containShare;

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
                    messages,
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
                  containShare
                      ? Row(
                          children: [
                            Container(
                              width: 246.w,
                              child: CustomButton(
                                  title: "Back To Profile",
                                  onTap: () {
                                    pushUntil(
                                        page: BottomNav(
                                      index: 3,
                                    ));
                                  }),
                            ),
                            addHorizontalSpace(8.w),
                            Expanded(
                                child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.inputBackgroundColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  Center(child: SvgPicture.asset(AppSvg.share)),
                            ))
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: CustomButton(
                                    title: "Back To Profile",
                                    onTap: () {
                                      pushUntil(
                                          page: BottomNav(
                                        index: 3,
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
