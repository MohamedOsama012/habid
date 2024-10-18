import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_track/feature/home/data/notification_firebase_operation.dart';
import 'package:habit_track/service/cash_helper.dart';
import 'package:habit_track/service/const_varible.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  //init notfication

  static Future<void> initFirebaseMessaging() async {
    isNotificationEnabled =
        await CashNetwork.GetFromCash(key: 'isNotificationEnabled');
    log(isNotificationEnabled.toString());
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationFirebaseOperation notficationfirebase =
        NotificationFirebaseOperation();
    // Initialize flutter local notifications
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Check if notification permission is already granted
    PermissionStatus permissionStatus = await Permission.notification.status;
    if (!permissionStatus.isGranted) {
      permissionStatus = await Permission.notification.request();
      if (permissionStatus.isGranted) {
        log('User granted notification permission.');
      } else {
        log('User denied notification permission.');
      }
    } else {
      log('Notification permission already granted.');
    }

    // Get the FCM token to send notifications to this device
    token = await messaging.getToken();
    log('FCM Token: $token');

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        await notficationfirebase.setNotfication(
            massageText: message.notification!.body!);
        // Display local notification when the app is in the foreground
        if (message.notification != null) {
          await _showLocalNotification(
            flutterLocalNotificationsPlugin,
            message.notification!.title,
            message.notification!.body,
          );
        }
      },
    );

    // Handle background notifications (when the app is opened by clicking a notification)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log('Notification clicked and app opened: ${message.notification?.title}');
      await notficationfirebase.setNotfication(
          massageText: message.notification!.body!);
    });
  }

  //handel local notfication
  static Future<void> _showLocalNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String? title,
    String? body,
  ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title, // Notification Title
      body, // Notification Body
      platformChannelSpecifics,
    );
  }

//get accsess token
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "habit-track-6d4ba",
      "private_key_id": "637349c6092e18d4265b8005f59e16b7477161f8",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCx8onqvdGZzNm+\nOFK0m6VuOB/O8x/TJ8rBG/vDxjmHgTODkhhefzL2YLDOkttrNVLzADQkeXuQ3RPP\nmSNWsbNFWrmcmXRXfRWmHNDB7H4kMeWAjgH/dpygxRfOTqVIuCmcgRE6NZpY4Smy\ns6p35Xa02cU8NrqfwYg+n4jYynJpk/XBKrwO3ojXFNljOg6/syQk/xv8cNH08E/2\ntY2P1AWiGBPLTbLpc6IstH3EftqP4MkWFrss/N/DXhYFlKau2FSSFcVRnq/BUfFh\nGLqCkR5/UBGHDBeULMq+NyvcZYNzwW4XAs87l087TyYjNh8sO6qsqxSPHwgnFslf\nVif9peLFAgMBAAECggEACldVOamsKDM4qzPe5eU5XQP7degjSb7hVaLF7o0S6Pjy\nm1s5OdKhYvfgW9zlI0rpxg/qt9JB1/u/tpEzIHW6vJV8ExRIPSZahKOzjmArPiNn\n2jZGekgJwakP4VrTgvvwL8rAtiCJK/ryf1KuyIFytNSxVYwRATmQF02STcD0GwZX\nvEukQL/V10p3lF8NV6J/0wqL860kCsqEd51c3tIu2r8mZjWuVfSn8D/IR84R9sSX\nV+YNDmw7rO/KVJnylvTea8zFgE5IGWB66twYWKvTDIkzljp7DROdiRxZWnOG8mlr\n50Z50YAAZG5oqkt5Yb6SuV0teLWc9Yb2qdMZN/Sx8QKBgQD2fMaCud8Ty4VfVk69\n34Yxlm9CjMzTNDTOPKamOChCAUICznnlWBhAoHCjcZ++icDUYHiexQKLtbBmvIuI\n2FvGzMHzpOvZ0ApecSbi3iVj3PSJ54UvknBb0A7qiy2aiEWTAdi4d6uxl1ddWdJW\nS9MrCRAhGUFcWJQzn8T/m+wv8QKBgQC40JukCkOO7/39UvphZ20O3RF/2uDiYA9N\niRGZVLLZbY+TCHvqDBhSo0cJu8o0Lq+zykQMomoXetiZ8hmqwK7ihQQlqvFxctne\nL5HpESvgEnDw816aMyELHYIFDHEC9vyX9ZM7Vp8aP25MKLXZkLKsmZoqq20d5ywu\nmKXXOxk0FQKBgEoYpkAkCfhUZQqM0mznpdqAQ3/4/ZW8Cue4ecxb81YsNKDNWv1j\npx6+XD316TSJCouNWJU52hMPkjDAGx4PFD/Fy8QnXrMChCtxzmPCrfDAOk6+Z14u\nolInUGSXZCUhM/EGTBTf/KANQ7kPSFiiwJ8eQVgB1JEjG6INNFY2lCCxAoGBAJ8l\nrFE3MXP+ABbMBKYp/QTGo5IY9nyZwbO/6/LAt/551SAFN0eVQMCwr7SXDImhBlZp\nP+4tUfSEKc9vZmDe6fpQFwEk0iMihrBJAHnV+pVK7AzhVb6tdq/uqg8U5qBp9ZwZ\nsb5wWjOtGZrll6sRanstDk/eLOmKL0a01mKgFpT9AoGBAMwDQe5/n+dzoz7a7Mx/\nLyxbpDaGO+V3I7pvBM6T7Y7AreQuBeLYOmzGa9/p8Gfdob0H9Z8euiAzIxH+3hxG\n3Qe4l3S1iGM8uLSPNygL5GmPkztDuf3BjY80DbavrKvjtHK8TZS175b0HliAW+YC\neWEMovNfTF0OGRs/GfdKarYN\n-----END PRIVATE KEY-----\n",
      "client_email": "notifcation@habit-track-6d4ba.iam.gserviceaccount.com",
      "client_id": "102417540832199525698",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/notifcation%40habit-track-6d4ba.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    client.close();
    return credentials.accessToken.data;
  }

  static Future<void> sendNotification(
      String deviceToken, String title, String body) async {
    final String accessToken = await getAccessToken();
    String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/habit-track-6d4ba/messages:send';
    final Map<String, dynamic> message = {
      "message": {
        "token": deviceToken,
        "notification": {"title": title, "body": body},
        "data": {
          "route": "serviceScreen",
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      log('Notification sent successfully');
    } else {
      log('Failed to send notification');
    }
  }
}
