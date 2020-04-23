import "../model/frequancy.dart";

class NotificationConstant {
  static const notificationCount = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  static const maxNotificationCount = 9;

  static const notificationFrequancyList = [Frequancy.Daily, Frequancy.Weekly];
}

class Day {
  final int val;
  final String day;
  const Day(this.val, this.day);

  static const Sunday = Day(1, "Pazar");
  static const Monday = Day(2, "Pazartesi");
  static const Tuesday = Day(3, "Salı");
  static const Wednesday = Day(4, "Çarşamba");
  static const Thursday = Day(5, "Perşembe");
  static const Friday = Day(6, "Cuma");
  static const Saturday = Day(7, "Cumartesi");

  static List<Day> get values => [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday];

  static Day getDay(int val) {
    return values.firstWhere((v) => v.val == val);
  }
}
