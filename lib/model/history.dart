import 'dart:convert';

import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(1)
  int cologneId;
  @HiveField(2)
  DateTime cleanDate;
  History({this.cologneId, this.cleanDate});

  @override
  String toString() => 'History(cologneId: $cologneId, cleanDate: $cleanDate)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is History && o.cologneId == cologneId && o.cleanDate == cleanDate;
  }

  @override
  int get hashCode => cologneId.hashCode ^ cleanDate.hashCode;
}
