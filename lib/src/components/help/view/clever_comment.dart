import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleverComment extends StatelessWidget {
  CleverComment(
      {required this.cleverResponse, required this.cleverResponseTime});
  final String cleverResponse;
  final String cleverResponseTime;

  DateTime localDate(String date) {
    return DateTime.parse(date).toLocal();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDarkMode ? AppColors.mainGreen : AppColors.greyText,
                width: 0.5,
              ),
            ),
            child: Text(
              cleverResponse,
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.white
                    : Color.fromRGBO(29, 30, 31, 1),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            )),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              DateFormat('dd-MM-yyyy \thh:mm:ssa')
                  .format(localDate(cleverResponseTime)),
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.white
                    : Color.fromRGBO(29, 30, 31, 1),
                fontSize: 10.sp,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
