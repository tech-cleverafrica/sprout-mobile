import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/src/repository/preference_repository.dart';
import 'package:sprout_mobile/src/utils/constants.dart';

class NotificationController extends GetxController {
  TextEditingController emailController = new TextEditingController();
  final PreferenceRepository preferenceRepository =
      Get.put(PreferenceRepository());

  List<dynamic> notifications = [];
  RxInt size = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
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
    String notificationsString =
        await preferenceRepository.getStringPref(NOTIFICATIONS);
    notifications =
        notificationsString != "" ? jsonDecode(notificationsString) : [];
    size.value =
        notificationsString != "" ? jsonDecode(notificationsString)?.length : 0;
  }

  Future updateNotification(int index) async {
    notifications.removeAt(index);
    size.value = notifications.length;
    preferenceRepository.setStringPref(
        NOTIFICATIONS, jsonEncode(notifications));
  }
}
