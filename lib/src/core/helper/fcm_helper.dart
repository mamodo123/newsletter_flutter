import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> _handleRemoteMessage(RemoteMessage remoteMessage) async {
  debugPrint(remoteMessage.notification?.title);
  debugPrint(remoteMessage.notification?.body);
  // debugPrint(remoteMessage.data.toString());
}

abstract class FCMHelper {
  static Future<void> initNotifications() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission();
    await firebaseMessaging.subscribeToTopic('newsletter');

    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
    FirebaseMessaging.onBackgroundMessage(_handleRemoteMessage);
  }

  static Future<HttpsCallableResult?> sendNotificationToTopic({
    required String topic,
    required String title,
    required String body,
  }) async {
    try {
      final firebaseFunctionsInstance = FirebaseFunctions.instance;
      final callable =
          firebaseFunctionsInstance.httpsCallable('sendNotificationToTopic');

      return await callable.call({
        'topic': topic,
        'title': title,
        'body': body,
      });
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
