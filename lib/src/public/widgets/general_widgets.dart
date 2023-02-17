import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/public/widgets/custom_button.dart';
import 'package:sprout_mobile/src/utils/app_images.dart';
import 'package:sprout_mobile/src/utils/app_svgs.dart';

import '../../utils/app_colors.dart';
import '../../utils/helper_widgets.dart';

getHeader(bool isDarkMode) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back)),
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
                    "HM",
                    style: TextStyle(
                        fontFamily: "DMSans",
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
            Image.asset(
              AppImages.question,
              height: 20,
              color: isDarkMode ? AppColors.white : AppColors.black,
            ),
            addHorizontalSpace(10.w),
            SvgPicture.asset(
              AppSvg.notification,
              color: isDarkMode ? AppColors.white : AppColors.black,
            ),
          ],
        )
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
              fontFamily: "DMSans",
              fontWeight: FontWeight.w600,
            ),
          ),
        ));
  }
}

class DecisionButton extends StatelessWidget {
  const DecisionButton(
      {Key? key,
      required this.isDarkMode,
      required this.buttonText,
      required this.onTap})
      : super(key: key);

  final bool isDarkMode;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 190.w,
          child: CustomButton(title: buttonText, onTap: onTap),
        ),
        addHorizontalSpace(8.w),
        Expanded(
            child: Container(
          height: 50,
          decoration: BoxDecoration(
              color:
                  isDarkMode ? AppColors.inputBackgroundColor : AppColors.black,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              "Go Back",
              style: TextStyle(fontFamily: "DMSans", color: AppColors.white),
            ),
          ),
        ))
      ],
    );
  }
}
