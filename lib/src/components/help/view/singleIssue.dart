import 'package:flutter/material.dart';
import 'package:sprout_mobile/src/components/help/model/issues_model.dart';
import 'package:sprout_mobile/src/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleIssue extends StatelessWidget {
  SingleIssue({required this.onTap, required this.issue});
  final Function(Issues) onTap;
  final Issues issue;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => onTap(issue),
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Case ID: ",
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.white
                            : Color.fromRGBO(29, 30, 31, 1),
                        fontSize: 14.sp,
                        fontFamily: 'MontSerrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        issue.caseId ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.white
                              : Color.fromRGBO(29, 30, 31, 1),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: isDarkMode ? AppColors.white : AppColors.black,
                  size: 12,
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              thickness: 0.7,
            )
          ],
        ),
      ),
    );
  }
}
