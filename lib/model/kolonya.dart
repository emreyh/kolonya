import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'frequancy.dart';
import 'history.dart';

part 'kolonya.g.dart';

@HiveType(typeId: 0)
class Cologne extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String imageUrl;
  @HiveField(3)
  Frequancy frequancy;
  @HiveField(4)
  int targetCleaningCount;
  @HiveField(5)
  HiveList<History> histories;
  // NotificationData notification;
  Cologne({
    @required this.id,
    this.title,
    this.imageUrl,
    this.frequancy,
    this.targetCleaningCount,
    this.histories,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Cologne &&
        o.id == id &&
        o.title == title &&
        o.imageUrl == imageUrl &&
        o.frequancy == frequancy &&
        o.targetCleaningCount == targetCleaningCount &&
        o.histories == histories;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        frequancy.hashCode ^
        targetCleaningCount.hashCode ^
        histories.hashCode;
  }

  @override
  String toString() {
    return 'Cologne(id: $id, title: $title, imageUrl: $imageUrl, frequancy: $frequancy, targetCleaningCount: $targetCleaningCount, histories: $histories)';
  }
}
