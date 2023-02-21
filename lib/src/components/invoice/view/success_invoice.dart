import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../public/widgets/custom_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_svgs.dart';
import '../../../utils/helper_widgets.dart';

class SuccessfulInvoice extends StatelessWidget {
  const SuccessfulInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addVerticalSpace(60.h),
            Text(
              "Successful",
              style: TextStyle(
                  color: AppColors.white,
                  fontFamily: "DMSans",
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700),
            ),
            addVerticalSpace(26.h),
            Container(
                height: 220.h,
                width: 250.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD9D9D9).withOpacity(0.2)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    AppSvg.mark,
                    color: AppColors.white,
                  ),
                )),
            addVerticalSpace(20.h),
            Container(
                width: 150.w,
                child: Text(
                  "You have successfully created an invoice to tadainic Company",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white),
                )),
            addVerticalSpace(150.h),
            Row(
              children: [
                Container(
                  width: 246.w,
                  child: CustomButton(title: "Back To Invoices", onTap: () {}),
                ),
                addHorizontalSpace(8.w),
                Expanded(
                    child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.inputBackgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(child: SvgPicture.asset(AppSvg.share)),
                ))
              ],
            ),
            addVerticalSpace(20.h),
            Image.asset(AppImages.sprout_dark),
          ],
        ),
      ),
    );
  }
}
