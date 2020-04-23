import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../values/notification_content.dart';
import '../const/boxes.dart';
import '../const/notification.dart';
import '../helper/notification_helper.dart';
import '../model/frequancy.dart';
import '../model/kolonya.dart';
import '../model/notification.dart';
import '../provider/cologne.dart';

class NotificationState extends ChangeNotifier {
  var notificationBox;
  NotificationState() {
    notificationBox = Hive.box<NotificationModel>(BoxName.NOTIFICATION);
  }

  CologneState _cologneModel;
  set cologneModel(CologneState model) {
    _cologneModel = model;
  }

  Cologne _selectedCologne = Cologne(id: null);
  Cologne get selectedCologne => _selectedCologne;

  int _notificationCount = 0;
  int get notificationCount => _notificationCount;

  Frequancy _frequancy;
  Frequancy get frequancy => _frequancy;

  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => [..._notifications];

  List<NotificationModel> _selectedDays = [];

  List<NotificationModel> get selectedDays => [..._selectedDays];

  List<NotificationModel> _notificationTimes = [];

  List<NotificationModel> get notificationTimes => [..._notificationTimes]..sort((x, y) => x.time.compareTo(y.time));

  void initDataNotificationPage() {
    _selectedCologne = _cologneModel.selectedCologne;
    _frequancy = _selectedCologne.frequancy;

    _notifications = notificationBox.values.cast<NotificationModel>().where(
      (n) {
        return int.parse(n.payload) == _selectedCologne.id;
      },
    ).toList();

    _selectedDays = _selectedCologne.frequancy == Frequancy.Daily ? [] : [..._notifications];

    _notificationTimes = _frequancy == Frequancy.Daily ? [..._notifications] : [_notifications?.first];

    _notificationCount = _frequancy == Frequancy.Daily ? notificationTimes.length : selectedDays.length;
  }

  addNotificationDay(Day day) async {
    var content = NotificationContent.elementAt(_selectedCologne.id);
    var notificationModel = NotificationModel(
      day: day.val,
      frequancy: Frequancy.Weekly,
      payload: _selectedCologne.id.toString(),
      time: _notificationTimes.first.time,
      title: content.title,
      body: content.body,
    );
    notificationBox.add(notificationModel);
    _selectedDays.add(notificationModel);

    _selectedCologne.targetCleaningCount = ++_notificationCount;
    _cologneModel.updateCologne(_selectedCologne);

    await NotificationHelper.instance.showWeeklyNotificationAtTime(notificationModel);
    notifyListeners();
  }

  removeNotificationDay(Day day) async {
    NotificationModel removedNotification = _selectedDays.firstWhere((element) => element.day == day.val);
    await NotificationHelper.instance.cancelNotification(removedNotification.key);

    _selectedDays.remove(removedNotification);
    await removedNotification.delete();

    _selectedCologne.targetCleaningCount = --_notificationCount;
    await _cologneModel.updateCologne(_selectedCologne);
    notifyListeners();
  }

  addNotificationTime(DateTime newTime) async {
    if (_existingNotificationTime(newTime)) return;

    var content = NotificationContent.elementAt(_selectedCologne.id);
    var notificationModel = NotificationModel(
      frequancy: Frequancy.Daily,
      payload: _selectedCologne.id.toString(),
      time: newTime,
      title: content.title,
      body: content.body,
    );
    notificationBox.add(notificationModel);
    _notificationTimes.add(notificationModel);

    await NotificationHelper.instance.showDailyNotificationAtTime(notificationModel);

    _selectedCologne.targetCleaningCount = ++_notificationCount;
    _cologneModel.updateCologne(_selectedCologne);
    notifyListeners();
  }

  updateNotificationModel(int notificationKey, DateTime newTime) async {
    if (_existingNotificationTime(newTime)) return;

    List<NotificationModel> newNotifications = [];
    if (frequancy == Frequancy.Weekly) {
      newNotifications = _selectedDays.map((n) {
        n.time = newTime;
        n.save();
        return n;
      }).toList();
    } else {
      var notification = _notificationTimes.firstWhere((n) => n.key == notificationKey);
      notification.time = newTime;
      notification.save();
      newNotifications = [notification];
    }
    newNotifications.forEach((n) async => await NotificationHelper.instance.cancelNotification(n.key));
    await NotificationHelper.instance.generateNotifications(newNotifications);
    notifyListeners();
  }

  removeNotificationTime(NotificationModel removedNotification) async {
    await NotificationHelper.instance.cancelNotification(removedNotification.key);

    _notificationTimes.remove(removedNotification);
    await removedNotification.delete();

    // NotificationHelper.instance.getPendingNotifications();
    _selectedCologne.targetCleaningCount = --_notificationCount;
    _cologneModel.updateCologne(_selectedCologne);
    notifyListeners();
  }

  bool _existingNotificationTime(DateTime time) {
    return _notificationTimes.any((t) => t.time.hour == time.hour && t.time.minute == time.minute);
  }
}
