import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/repository/preference_repository.dart';
import 'package:sprout_mobile/src/utils/constants.dart';
import '../service/notification_service.dart';

class NotificationController extends GetxController {
  TextEditingController emailController = new TextEditingController();
  final PreferenceRepository preferenceRepository =
      Get.put(PreferenceRepository());
  final push = PushNotificationService();

  String notifications = "";
  int notification_length = 0;

  @override
  void onInit() {
    super.onInit();
    push.initialise();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getNotifications() async {
    notifications = await preferenceRepository.getStringPref(NOTIFICATIONS);
    notification_length = jsonDecode(notifications)?.length;
  }
}
