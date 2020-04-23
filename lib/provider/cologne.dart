import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:kolonya/values/initial_data.dart' as data;
import '../const/boxes.dart';
import '../model/kolonya.dart';

class CologneState with ChangeNotifier {
  Box<Cologne> _cologneBox; //= Hive.box<Cologne>(BoxName.COLOGNE);

  CologneState() {
    _cologneBox = Hive.box<Cologne>(BoxName.COLOGNE);
  }

  init() {
    _colognes = [..._cologneBox.values.toList()];
    _selectedCologne = _colognes.first;
    _selectedIndex = 0;
    notifyListeners();
  }

  List<Cologne> _colognes = data.colognes;

  List<Cologne> get colognes => [..._colognes];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int newSelectedIndex) {
    assert(newSelectedIndex >= 0 && newSelectedIndex < 4);
    // if (_selectedIndex == newSelectedIndex) {
    //   return;
    // }
    _selectedIndex = newSelectedIndex;
    _selectedCologne = _colognes[_selectedIndex];
    notifyListeners();
  }

  Cologne _selectedCologne = data.handWashing;
  Cologne get selectedCologne => _selectedCologne;

  set selectedCologne(Cologne newSelectedCologne) {
    _selectedCologne = newSelectedCologne;
    notifyListeners();
  }

  updateCologne(Cologne cologne) {
    selectedCologne = cologne;
    _cologneBox.put(cologne.key, cologne);
    notifyListeners();
  }
}
