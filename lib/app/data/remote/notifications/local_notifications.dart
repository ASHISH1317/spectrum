import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_starter_kit_2024/app/data/config/logger.dart';

/// Helper class for local notifications
class FlutterLocalNotificationHelper {
  /// Constructor
  factory FlutterLocalNotificationHelper() => _instance;

  FlutterLocalNotificationHelper._();

  static final FlutterLocalNotificationHelper _instance =
      FlutterLocalNotificationHelper._();

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  late Function(Map<String, dynamic>) _localNotificationCallback;

  /// Initialize local notifications
  Future<void> initializeSettings({
    @required Function(Map<String, dynamic>)? actionCallback,
  }) async {
    if (actionCallback != null) {
      _localNotificationCallback = actionCallback;
    }
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotification);

    //On notification click
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      await onSelectNotification(notificationAppLaunchDetails?.notificationResponse);
    }
  }

  /// WHEN USER CLICKS TO NOTIFICATION
  Future<void> onSelectNotification(NotificationResponse? notificationResponse) async {
    logD('Payload :: ${notificationResponse!.payload}');
    if (notificationResponse.payload != null) {
      final Map<String, dynamic> payloadJson =
          jsonDecode(notificationResponse.payload!) as Map<String, dynamic>;
      _localNotificationCallback(payloadJson);
    }
  }

  /// SHOW LOCAL NOTIFICATION
  ///  'your channel id', 'your channel name', IS NOT NEEDED
  Future<void> showNotificationWithDefaultSound(
      {@required String? title,
      @required String? body,
      @required String? payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max, priority: Priority.high);
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
