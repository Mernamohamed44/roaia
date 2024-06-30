import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:roaia/core/helpers/cache_helper.dart';

// Initialize local notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initialize Firebase Messaging instance
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

// Function to handle notification initialization and permissions
void requestPermissionAndSetupNotifications() async {
  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Initialize local notifications settings
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Handle incoming messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showNotification(message);
  });

  // Handle notification when the app is in the foreground
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    // Optionally handle the message here
  });

  // Get the token for this device
  String? token = await firebaseMessaging.getToken();
  CacheHelper.put(key: 'deviceToken', value: token);
  print('Firebase token is $token');
}

// Function to show local notification
void showNotification(RemoteMessage message) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification!.title,
    message.notification!.body,
    platformChannelSpecifics,
    payload: message.data['data'],
  );
}
