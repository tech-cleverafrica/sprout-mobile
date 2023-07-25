import 'package:flutter/material.dart';
import 'package:sprout_mobile/utils/app_colors.dart';

class IssueHeading extends StatelessWidget {
  IssueHeading(
      {required this.title, required this.subtitle, required this.offset});
  final String title;
  final String subtitle;
  final double offset;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: isDarkMode
                          ? AppColors.white
                          : Color.fromRGBO(29, 30, 31, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Mont"),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * offset,
                  child: Text(
                    subtitle,
                    style: TextStyle(
                        color: isDarkMode
                            ? AppColors.white
                            : Color.fromRGBO(29, 30, 31, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Mont"),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Divider(
          height: 1,
          thickness: 1,
        )
      ],
    );
  }
}
