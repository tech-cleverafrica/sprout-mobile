import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/components/notification/controller/notification_controller.dart';
import 'package:sprout_mobile/src/components/notification/view/widgets.dart';

import '../../../public/widgets/general_widgets.dart';
import '../../../utils/helper_widgets.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  late NotificationController notificationController;

  @override
  Widget build(BuildContext context) {
    notificationController = Get.put(NotificationController());
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
                            "Lorem ipsum dolor sit amet consectetur. Cursus aliquam at aliquet quis volutpat arcu feugiat dui. Non mus facilisi facilisi id sodales leo diam pellentesque volutpat arcu feugiat dui. Non mus facilisi facilisi id sodales leo diam pellentesque...",
                        select: () => {},
                      );
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
