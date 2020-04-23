import '../model/notification.dart';

import '../model/frequancy.dart';
import '../model/kolonya.dart';
import './notification_content.dart';

var handWashing = new Cologne(
  title: "El Temizliği",
  imageUrl: "assets/img/hand-wash.png",
  frequancy: Frequancy.Daily,
  targetCleaningCount: 8,
  id: 0,
);

var cleanPhone = new Cologne(
  title: "Telefon Temizliği",
  imageUrl: "assets/img/clean-phone.png",
  frequancy: Frequancy.Daily,
  targetCleaningCount: 7,
  id: 1,
);

var cleanHome = new Cologne(
  title: "Ev Temizliği",
  imageUrl: "assets/img/clean-home.png",
  frequancy: Frequancy.Weekly,
  targetCleaningCount: 2,
  id: 2,
);

var shower = new Cologne(
  title: "Duş",
  imageUrl: "assets/img/shower.png",
  frequancy: Frequancy.Weekly,
  targetCleaningCount: 3,
  id: 3,
);

final List<Cologne> colognes = [handWashing, cleanPhone, cleanHome, shower];

final List<NotificationModel> handWashingNotifications = [
  DateTime(2020, 1, 1, 09, 30, 0),
  DateTime(2020, 1, 1, 11, 30, 0),
  DateTime(2020, 1, 1, 13, 30, 0),
  DateTime(2020, 1, 1, 15, 30, 0),
  DateTime(2020, 1, 1, 17, 30, 0),
  DateTime(2020, 1, 1, 19, 30, 0),
  DateTime(2020, 1, 1, 21, 30, 0),
  DateTime(2020, 1, 1, 23, 30, 0),
]
    .map(
      (time) => NotificationModel(
        title: NotificationContent.handWashing.title,
        body: NotificationContent.handWashing.body,
        frequancy: Frequancy.Daily,
        payload: "0",
        time: time,
      ),
    )
    .toList();

final List<NotificationModel> cleanSmartphoneNotifications = [
  DateTime(2020, 1, 1, 10, 30, 0),
  DateTime(2020, 1, 1, 12, 30, 0),
  DateTime(2020, 1, 1, 14, 30, 0),
  DateTime(2020, 1, 1, 16, 30, 0),
  DateTime(2020, 1, 1, 18, 30, 0),
  DateTime(2020, 1, 1, 20, 30, 0),
  DateTime(2020, 1, 1, 22, 30, 0),
]
    .map(
      (time) => NotificationModel(
        title: NotificationContent.cleanSmartphone.title,
        body: NotificationContent.cleanSmartphone.body,
        payload: "1",
        frequancy: Frequancy.Daily,
        time: time,
      ),
    )
    .toList();

final List<NotificationModel> showerDays =
    [DateTime.monday, DateTime.wednesday, DateTime.friday]
        .map(
          (day) => NotificationModel(
            title: NotificationContent.shower.title,
            body: NotificationContent.shower.body,
            payload: "3",
            frequancy: Frequancy.Weekly,
            day: day,
            time: DateTime.utc(2020, 1, 1, 21, 35, 0),
          ),
        )
        .toList();

final List<NotificationModel> cleanHomeDays =
    [DateTime.saturday, DateTime.wednesday]
        .map(
          (day) => NotificationModel(
            title: NotificationContent.cleanHome.title,
            body: NotificationContent.cleanHome.body,
            payload: "2",
            frequancy: Frequancy.Weekly,
            day: day,
            time: DateTime(2020, 1, 1, 10, 40, 0),
          ),
        )
        .toList();

final List<NotificationModel> notifications = []
  ..addAll(handWashingNotifications)
  ..addAll(cleanSmartphoneNotifications)
  ..addAll(cleanHomeDays)
  ..addAll(showerDays);
