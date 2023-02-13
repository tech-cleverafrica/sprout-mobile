import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';

enum ToastType { success, error, warning }

class CustomToastNotification {
  static show(String title,
      {ToastType type = ToastType.success, bool isFilled = false}) async {
    showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        margin: EdgeInsets.symmetric(horizontal: 50.0),
        decoration: BoxDecoration(
          color: isFilled ? getToastColor(type) : AppColors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowGrey.withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(type == ToastType.warning ? 3.0 : 2.0),
              decoration: BoxDecoration(
                color: getToastColor(type),
                shape: BoxShape.circle,
              ),
              child: Icon(getToastIcon(type),
                  color: AppColors.white,
                  size: type == ToastType.warning ? 16.0 : 20.0),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isFilled ? AppColors.white : getToastColor(type),
                  fontSize: 12.5,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showBottomToast(BuildContext context, String title) async {
    showToast(
      title,
      context: context,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      backgroundColor: AppColors.transparentBlack,
      textStyle: TextStyle(fontSize: 12.5, color: AppColors.white),
    );
  }

  static Color getToastColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return AppColors.successGreen;
      case ToastType.error:
        return AppColors.errorRed;
      case ToastType.warning:
        return AppColors.orangeWarning;

      default:
        return AppColors.successGreen;
    }
  }

  static IconData getToastIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check;
      case ToastType.error:
        return Icons.close;
      case ToastType.warning:
        return Icons.warning_amber_rounded;

      default:
        return Icons.check;
    }
  }
}
