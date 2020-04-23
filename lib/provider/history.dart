import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kolonya/values/initial_data.dart';
import '../const/boxes.dart';
import '../model/frequancy.dart';
import '../model/history.dart';
import '../model/kolonya.dart';

class HistoryState extends ChangeNotifier {
  var historyBox;
  HistoryState() {
    historyBox = Hive.box<History>(BoxName.HISTORY);
  }
  init() {
    _selectedCologne = Hive.box<Cologne>(BoxName.COLOGNE).getAt(0);
    notifyListeners();
  }

  Cologne _selectedCologne = handWashing;

  Cologne get selectedCologne => _selectedCologne;

  set selectedCologne(Cologne newSelectedCologne) {
    // if (newSelectedCologne == _selectedCologne) {
    //   return;
    // }
    _selectedCologne = newSelectedCologne;
    selectedHistories = _selectedCologne?.histories ?? [];
  }

  List<History> _selectedHistories = [];

  List<History> get selectedHistories =>
      isAllHistories ? UnmodifiableListView(_selectedHistories?.cast() ?? []) : _complatedHistory;

  set selectedHistories(List<History> histories) {
    _selectedHistories = histories == null || histories.isEmpty ? [] : histories
      ..sort((x, y) => y.cleanDate.compareTo(x.cleanDate));
    _complatedHistory = _getComplatedHistories(_selectedHistories);
    notifyListeners();
  }

  bool _isAllHistories = false;
  bool get isAllHistories => _isAllHistories;

  set isAllHistories(bool isAllHistories) {
    _isAllHistories = isAllHistories;
    notifyListeners();
  }

  List<History> _complatedHistory = [];

  List<History> _getComplatedHistories(List<History> histories) {
    var currentDate = Jiffy();

    return histories.isEmpty
        ? histories
        : UnmodifiableListView(
            histories.where(
              (h) {
                var cleanDate = Jiffy(h.cleanDate);
                if (selectedCologne.frequancy == Frequancy.Weekly && currentDate.week == cleanDate.week) {
                  return true;
                }
                if (selectedCologne.frequancy == Frequancy.Daily && cleanDate.day == currentDate.day) {
                  return true;
                }
                return false;
              },
            ).toList()
              ..sort((x, y) => y.cleanDate.compareTo(x.cleanDate)),
          );
  }

  void addHistory(History history) async {
    historyBox.add(history);
    selectedCologne.histories.add(history);
    selectedCologne.save();
    selectedHistories = [...selectedCologne.histories];
  }

  void deleteHistory(int historyId) async {
    historyBox.delete(historyId);
    selectedCologne.save();
    selectedHistories = [...selectedCologne.histories];
  }

  double get complatedPercent {
    return complatedCount == 0 ? 0 : (complatedCount / selectedCologne?.targetCleaningCount) * 100;
  }

  int get complatedCount => _complatedHistory?.length ?? 0;

  int get remainingCount => (selectedCologne?.targetCleaningCount ?? 0) - complatedCount;
}
