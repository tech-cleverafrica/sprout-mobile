import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprout_mobile/src/components/notification/view/widgets.dart';

import '../../../public/widgets/custom_text_form_field.dart';
import '../../../public/widgets/general_widgets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helper_widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeader(isDarkMode, hideNotification: true),
                addVerticalSpace(35.h),
                ListView.builder(
                    itemCount: 7,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return NotificationCard(
                          theme: theme,
                          isDarkMode: isDarkMode,
                          date: "01 Feb 2023, 18:05",
                          notification:
                              "Lorem ipsum dolor sit amet consectetur. Cursus aliquam at aliquet quis volutpat arcu feugiat dui. Non mus facilisi facilisi id sodales leo diam pellentesque volutpat arcu feugiat dui. Non mus facilisi facilisi id sodales leo diam pellentesque...");
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
