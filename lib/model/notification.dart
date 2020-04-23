import 'package:hive/hive.dart';

import '../model/frequancy.dart';

part 'notification.g.dart';

@HiveType(typeId: 3)
class NotificationModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String body;
  @HiveField(2)
  Frequancy frequancy;
  @HiveField(3)
  DateTime time;
  @HiveField(4)
  int day;
  @HiveField(5)
  String payload; // cologneId
  NotificationModel({
    this.title,
    this.body,
    this.frequancy,
    this.time,
    this.day,
    this.payload,
  });

  @override
  String toString() {
    return 'NotificationModel(title: $title, body: $body, frequancy: $frequancy, time: $time, day: $day, payload: $payload)';
  }
}
