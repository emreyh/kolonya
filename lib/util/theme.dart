import 'package:flutter/material.dart';

class ThemeUtil {
  static final ThemeUtil _instance = new ThemeUtil._internal();

  factory ThemeUtil() {
    return _instance;
  }
  ThemeUtil._internal();

  static final Map<int, Color> _color = {
    50: Color.fromRGBO(13, 164, 109, .1),
    100: Color.fromRGBO(13, 164, 109, .2),
    200: Color.fromRGBO(13, 164, 109, .3),
    300: Color.fromRGBO(13, 164, 109, .4),
    400: Color.fromRGBO(13, 164, 109, .5),
    500: Color.fromRGBO(13, 164, 109, .6),
    600: Color.fromRGBO(13, 164, 109, .7),
    700: Color.fromRGBO(13, 164, 109, .8),
    800: Color.fromRGBO(13, 164, 109, .9),
    900: Color.fromRGBO(13, 164, 109, 1),
  };

  static final ThemeData _cologneLightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: MaterialColor(0xFF0DA46D, _color),
    accentColor: Color(0xFFF1F1F1),
    fontFamily: 'Baloo2',
  );

  static final ThemeData _cologneDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    accentColor: Color(0xFFF1F1F1),
    fontFamily: 'Baloo2',
  );

  ThemeData get light => _cologneLightTheme;
  ThemeData get dark => _cologneDarkTheme;
}
