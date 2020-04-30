import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import './pages/welcome.dart';
import './const/boxes.dart';
import './model/frequancy.dart';
import './model/history.dart';
import './model/kolonya.dart';
import './model/notification.dart';
import './provider/cologne.dart';
import './provider/history.dart';
import './provider/notification.dart';
import './util/routes.dart';
import './util/theme.dart';

void main() async {
  // await _initHive();
  await Hive.initFlutter();
  Hive.registerAdapter(CologneAdapter());
  Hive.registerAdapter(FrequancyAdapter());
  Hive.registerAdapter(HistoryAdapter());
  Hive.registerAdapter(NotificationModelAdapter());
  await Hive.openBox<Cologne>(BoxName.COLOGNE);
  await Hive.openBox<History>(BoxName.HISTORY);
  await Hive.openBox<NotificationModel>(BoxName.NOTIFICATION);
  await Hive.openBox<String>(BoxName.APP);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(KolonyaApp());
  });
}

class KolonyaApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => CologneState(),
        ),
        ChangeNotifierProxyProvider<CologneState, NotificationState>(
          create: (ctx) => NotificationState(),
          update: (ctx, c, s) => s..cologneModel = c,
        ),
        ChangeNotifierProxyProvider<CologneState, HistoryState>(
          create: (ctx) => HistoryState(),
          update: (ctx, c, h) => h..selectedCologne = c.selectedCologne,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kolonya',
        theme: ThemeUtil().light,
        initialRoute: WelcomePage.routeName,
        onGenerateRoute: onGenerateRoutes,
        navigatorKey: navigatorKey,
      ),
    );
  }
}