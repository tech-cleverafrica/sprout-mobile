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
  List<dynamic> _notifications = [];

  @override
  Widget build(BuildContext context) {
    notificationController = Get.put(NotificationController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    notificationController.getNotifications();
    _notifications = notificationController.notifications;
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
                    itemCount: notificationController.size,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          notificationController.updateNotification(index);
                        },
                        child: NotificationCard(
                          theme: theme,
                          isDarkMode: isDarkMode,
                          date: _notifications[index]["date"],
                          notification: _notifications[index]["body"],
                          select: () => {},
                        ),
                        background: Container(
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
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
