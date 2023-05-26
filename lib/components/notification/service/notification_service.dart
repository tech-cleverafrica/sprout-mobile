import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sprout_mobile/components/notification/controller/notification_controller.dart';
import 'package:sprout_mobile/public/widgets/general_widgets.dart';
import 'package:sprout_mobile/repository/preference_repository.dart';
import 'package:get/get.dart';
import 'package:sprout_mobile/utils/app_colors.dart';
import 'package:sprout_mobile/utils/constants.dart';
import 'package:sprout_mobile/utils/global_function.dart';

class PushNotificationService {
  late FirebaseMessaging _fcm;
  final PreferenceRepository preferenceRepository =
      Get.put(PreferenceRepository());
  final NotificationController notificationController =
      Get.put(NotificationController());

  Future initialise() async {
    // Firebase.
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _fcm = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _saveNotification(message);
        _popupNotification(message);
      });

      FirebaseMessaging.onBackgroundMessage(_myBackgroundMessageHandler);
    } else {
      print('User declined or has not accepted permission');
    }

    String? token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");
    preferenceRepository.setStringPref(NOTIFICATION_ID, jsonEncode(token));
    _fcm.subscribeToTopic('sprout');
  }

  _popupNotification(RemoteMessage message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkTheme = prefs.getBool("darkTheme") ?? false;
    if (message.data['title'] != null && message.data['body'] != null) {
      Future.delayed(
          const Duration(milliseconds: 2000),
          () => {
                Get.snackbar(
                  message.data['title'],
                  message.data['body'],
                  duration: Duration(seconds: 4),
                  animationDuration: Duration(milliseconds: 400),
                  snackPosition: SnackPosition.TOP,
                  colorText: darkTheme ? AppColors.white : AppColors.black,
                  isDismissible: true,
                )
              });
    } else if (message.data['title'] != null && message.data['body'] != null) {
      Future.delayed(
          const Duration(milliseconds: 2000),
          () => {
                Get.snackbar(
                  message.data['title'],
                  message.data['body'],
                  duration: Duration(seconds: 4),
                  animationDuration: Duration(milliseconds: 400),
                  snackPosition: SnackPosition.TOP,
                  colorText: darkTheme ? AppColors.white : AppColors.black,
                  isDismissible: true,
                )
              });
    }
  }
}

Future _myBackgroundMessageHandler(RemoteMessage message) async {
  await _saveNotification(message);
  return Future<void>.value();
}

Future _saveNotification(RemoteMessage message) async {
  List<dynamic> _notifications = [];
  dynamic notification;

  // if (await storage.containsKey(key: "notifications") == true) {
  if (await preferenceRepository.getKeyBoolean(NOTIFICATIONS)) {
    Future<String> notifications =
        preferenceRepository.getStringPref(NOTIFICATIONS);
    _notifications = jsonDecode(await notifications);
  }
  if (Platform.isIOS) {
    if (message.notification != null &&
        message.notification?.body != null &&
        message.notification?.title != null) {
      notification = {
        "id": DateTime.now().millisecondsSinceEpoch,
        "title": message.notification?.title,
        "body": message.notification?.body,
        "date": await _dateNow(),
        "read": false
      };
      _notifications.insert(0, notification);
      preferenceRepository.setStringPref(
          NOTIFICATIONS, jsonEncode(_notifications));
      notificationController.getNotifications();
    }
  } else {
    if (message.notification != null &&
        message.notification?.body != null &&
        message.notification?.title != null) {
      notification = {
        "id": DateTime.now().millisecondsSinceEpoch,
        "title": message.notification?.title,
        "body": message.notification?.body,
        "date": await _dateNow(),
        "read": false
      };
      print(_notifications);
      _notifications.insert(0, notification);
      preferenceRepository.setStringPref(
          NOTIFICATIONS, jsonEncode(_notifications));
      notificationController.getNotifications();
    }
  }
}

String localDate(String date) {
  return DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(date).toLocal().toString();
}

Future<String> _dateNow() async {
  var dateTime = DateTime.now().toIso8601String();
  return DateFormat('dd-MM-yyyy hh:mma').format(DateTime.parse(dateTime));
}
