import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprout_mobile/src/repository/preference_repository.dart';
import 'package:sprout_mobile/src/utils/constants.dart';

class NotificationController extends GetxController {
  final PreferenceRepository preferenceRepository =
      Get.put(PreferenceRepository());

  var notifications = Rxn<dynamic>();
  RxInt size = 0.obs;

  @override
  void onInit() {
    notifications.value = [];
    super.onInit();
    SharedPreferences.getInstance().then((prefs) => {prefs.reload()});
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
    notifications.value =
        notificationsString != "" ? jsonDecode(notificationsString) : [];
    size.value =
        notificationsString != "" ? jsonDecode(notificationsString)?.length : 0;
  }

  Future updateNotification(int index) async {
    notifications.value.removeAt(index);
    size.value = notifications.value.length;
    preferenceRepository.setStringPref(
        NOTIFICATIONS, jsonEncode(notifications));
  }
}
