import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_starter_kit_2024/app/data/remote/notifications/local_notifications.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

/// Get firebase notification instance
FirebaseMessaging get firebaseMessagingInstance => _firebaseMessaging;

/// Firebase push notification token
Future<String?> pushNotificationToken() async => _firebaseMessaging.getToken();

/// When user clicks on the notification
void notificationActions({
  @required Function(RemoteMessage?)? action,
  bool localNotification = false,
  Function(Map<String, dynamic>)? localNotificationAction,
}) {
  //Make sure that the [localNotificationAction] is not null when
  //localNotification is [true]
  if (localNotification) {
    assert(localNotificationAction != null);
  }

  if (Platform.isIOS) {
    _requestPermissions();
  }

  if (localNotification) {
    FlutterLocalNotificationHelper().initializeSettings(
      actionCallback: localNotificationAction,
    );
  }

  _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
    action!(message);
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    action!(message);
    if (localNotification) {
      FlutterLocalNotificationHelper().showNotificationWithDefaultSound(
        title: message.notification?.title,
        body: message.notification?.body,
        payload: jsonEncode(message.data),
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    action!(message);
  });
}

void _requestPermissions() {
  _firebaseMessaging.requestPermission(
    provisional: true,
  );
}
