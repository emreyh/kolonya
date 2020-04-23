import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kolonya/pages/home.dart';
import '../main.dart';
import '../model/notification.dart';
import '../model/frequancy.dart';

class NotificationHelper {
  NotificationHelper._internal();
  static final NotificationHelper _instance = new NotificationHelper._internal();

  factory NotificationHelper() => _instance;
  static NotificationHelper get instance => _instance;

  static BuildContext _context;
  FlutterLocalNotificationsPlugin _plugin;

  Future<FlutterLocalNotificationsPlugin> get plugin async {
    if (_plugin != null) {
      return _plugin;
    }
    _plugin = FlutterLocalNotificationsPlugin();
    return _plugin;
  }

  init(BuildContext context) async {
    _context = context;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = await instance.plugin;
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _onSelectNotification);
  }

  Future<dynamic> _onSelectNotification(String payload) async {
    await KolonyaApp.navigatorKey.currentState.pushNamedAndRemoveUntil(
      HomePage.routeName,
      (Route<dynamic> route) => false,
      arguments: payload,
    );
  }

  Future<void> showNotification(NotificationModel notificationModel) async {
    var bigTextStyleInformation = BigTextStyleInformation(notificationModel.body,
        htmlFormatBigText: true,
        contentTitle: '<b>${notificationModel.title}</b>',
        htmlFormatContentTitle: true,
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'nocoronId', 'nocoronChannelName', 'temizlik imanın yarısıdır.',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        visibility: NotificationVisibility.Public,
        styleInformation: bigTextStyleInformation);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _plugin.show(999, notificationModel.title, notificationModel.body, platformChannelSpecifics,
        payload: notificationModel.payload);
  }

  Future<void> showDailyNotificationAtTime(NotificationModel ntf) async {
    var bigTextStyleInformation = BigTextStyleInformation(ntf.body,
        htmlFormatBigText: true,
        contentTitle: '<b>${ntf.title}</b>',
        htmlFormatContentTitle: true,
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'nocoronId', 'Günlük Bildirimler', 'Günlük Bildirimler',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        visibility: NotificationVisibility.Public,
        styleInformation: bigTextStyleInformation);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await _plugin.showDailyAtTime(
      ntf.key,
      ntf.title,
      ntf.body,
      Time(ntf.time.hour, ntf.time.minute, ntf.time.second),
      platformChannelSpecifics,
      payload: ntf.payload,
    );
  }

  Future<void> showWeeklyNotificationAtTime(NotificationModel ntf) async {
    var bigTextStyleInformation = BigTextStyleInformation(ntf.body,
        htmlFormatBigText: true,
        contentTitle: '<b>${ntf.title}</b>',
        htmlFormatContentTitle: true,
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'nocoronId2', 'Haftalık Bildirimler', 'Haftalık bildirimler.',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        visibility: NotificationVisibility.Public,
        styleInformation: bigTextStyleInformation);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _plugin.showWeeklyAtDayAndTime(
      ntf.key,
      ntf.title,
      ntf.body,
      Day(ntf.day),
      Time(ntf.time.hour, ntf.time.minute, ntf.time.second),
      platformChannelSpecifics,
      payload: ntf.payload,
    );
  }

  Future<void> generateNotifications(List<NotificationModel> notifications) async {
    if (notifications == null || notifications.isEmpty) {
      return;
    }
    notifications.forEach((n) {
      if (n.frequancy == Frequancy.Daily) {
        showDailyNotificationAtTime(n);
      } else if (n.frequancy == Frequancy.Weekly) {
        showWeeklyNotificationAtTime(n);
      }
    });
  }

  Future<void> getPendingNotifications() async {
    await _plugin.pendingNotificationRequests().then(
      (res) {
        res.forEach((p) => print('${p.id} ${p.payload} ${p.title} ${p.body}'));
      },
    );
  }

  Future<void> cancelNotification(int notificationId) async {
    await _plugin.cancel(notificationId);
  }

  Future<NotificationAppLaunchDetails> getNotificationAppLaunchDetails() async {
    return await _plugin.getNotificationAppLaunchDetails();
  }
}
