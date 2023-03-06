import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/notification_service.dart';

class NotificationController extends GetxController {
  TextEditingController emailController = new TextEditingController();
  final push = PushNotificationService();

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
}
