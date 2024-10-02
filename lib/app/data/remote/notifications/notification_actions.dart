import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_starter_kit_2024/app/data/config/logger.dart';

/// Handle onMessage, onLaunch and onResume events
void notificationAction(RemoteMessage? remoteMessage) {
  //Todo(ASHISH): Set Firebase notification callback
  logD(remoteMessage?.data.toString() ?? 'No Data');
}

/// Handle local notification
void localNotificationAction(Map<String, dynamic>? remoteMessageData) {
  //Todo(ASHISH): Set local notification callback
  logD(remoteMessageData?.toString() ?? 'No Local Data');
}
