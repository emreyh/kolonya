import 'package:flutter/material.dart';
import '../pages/about.dart';
import '../pages/loading.dart';
import '../pages/welcome.dart';
import '../pages/home.dart';
import '../pages/notification_settings.dart';

PageRoute onGenerateRoutes(RouteSettings settings) {
  var arguments = settings.arguments;

  switch (settings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(
          builder: (_) => HomePage(arguments), settings: settings);
    case NotificationSettings.routeName:
      return MaterialPageRoute(
          builder: (_) => NotificationSettings(), settings: settings);
    case About.routeName:
      return MaterialPageRoute(builder: (_) => About(), settings: settings);
    case LoadingPage.routeName:
      return MaterialPageRoute(
          builder: (_) => LoadingPage(), settings: settings);
    case WelcomePage.routeName:
      return MaterialPageRoute(
          builder: (_) => WelcomePage(), settings: settings);
    default:
      return MaterialPageRoute(builder: (_) => HomePage(), settings: settings);
  }
}
