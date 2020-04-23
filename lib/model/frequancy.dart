import 'package:hive/hive.dart';

part 'frequancy.g.dart';

@HiveType(typeId: 2)
enum Frequancy {
  @HiveField(0)
  Daily,
  @HiveField(1)
  Weekly
}

String valueToString(f) {
  return f == Frequancy.Daily ? "Günlük" : "Haftalık";
}
