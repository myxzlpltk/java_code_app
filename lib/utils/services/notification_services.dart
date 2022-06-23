import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:java_code_app/configs/routes/app_routes.dart';
import 'package:java_code_app/configs/themes/colors.dart';
import 'package:java_code_app/constants/commons/constants.dart';
import 'package:java_code_app/constants/cores/api_const.dart';
import 'package:java_code_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:java_code_app/utils/services/api_services.dart';
import 'package:java_code_app/utils/services/local_db_services.dart';

class NotificationServices {
  NotificationServices._();

  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String notifImage = 'app_icon';
  static const String notifChannelId = 'default_notification_channel_id';
  static const String notifChannelName = 'default_notification_channel_name';
  static const String notifChanelDesc = 'default_notification_channel_desc';

  static const InitializationSettings initializationSettings =
      InitializationSettings(
    android: AndroidInitializationSettings(notifImage),
  );

  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(
    android: AndroidNotificationDetails(
      notifChannelId,
      notifChannelName,
      channelDescription: notifChanelDesc,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      color: AppColor.blueColor,
    ),
  );

  static Future<void> init() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            notifChannelId,
            notifChannelName,
            description: notifChanelDesc, // description,
            importance: Importance.max,
          ),
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          final data = json.decode(payload);

          if (data['id_promo'] != null) {
            /// Mendapatkan user dan token dari local DB service
            var user = await LocalDBServices.getUser();
            var token = await LocalDBServices.getToken();

            if (user != null && token != null) {
              DashboardController.to.tabIndex.value = 0;

              /// Navigasi ke detail promo jika sudah login
              await Get.offNamedUntil(
                AppRoutes.detailPromoView,
                ModalRoute.withName(AppRoutes.dashboardView),
                arguments: int.parse(data['id_promo'].toString()),
              );
            }
          } else if (data['id_order'] != null) {
            /// Mendapatkan user dan token dari local DB service
            var user = await LocalDBServices.getUser();
            var token = await LocalDBServices.getToken();

            if (user != null && token != null) {
              DashboardController.to.tabIndex.value = 1;

              /// Navigasi ke detail promo jika sudah login
              await Get.offNamedUntil(
                AppRoutes.detailOrderView,
                ModalRoute.withName(AppRoutes.dashboardView),
                arguments: int.parse(data['id_order'].toString()),
              );
            }
          }
        }
      },
    );

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen(listen);
      FirebaseMessaging.onBackgroundMessage(listenBackground);
    }
  }

  static void listen(RemoteMessage message) {
    onMessageHandler(message);
  }

  static Future<void> listenBackground(RemoteMessage message) async {
    onMessageHandler(message);
  }

  static Future<void> onMessageHandler(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: json.encode(message.data),
    );
  }

  static Future<void> sendNotification(
      String title, String body, Map<String, dynamic> data) async {
    /// Cek FCM token
    final String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken == null) return;

    /// Kirim notifikasi
    await ApiServices.dioCall(
      authorization: 'key=${AppConst.firebaseCloudMessagingKey}',
    ).post(
      ApiConst.firebaseCloudMessaging,
      data: {
        'notification': {'title': title, 'body': body},
        'priority': 'high',
        'data': data,
        'to': fcmToken,
      },
    );
  }
}
