import 'package:flutter/material.dart';
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

  runApp(KolonyaApp());
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
        title: 'Kolonya',
        theme: ThemeUtil().light,
        initialRoute: WelcomePage.routeName,
        onGenerateRoute: onGenerateRoutes,
        navigatorKey: navigatorKey,
      ),
    );
  }
}

// Future<void> loadInitialData() async {
//   DateTime start = DateTime.now();

//   await Hive.initFlutter();
//   Hive.registerAdapter(CologneAdapter());
//   Hive.registerAdapter(FrequancyAdapter());
//   Hive.registerAdapter(HistoryAdapter());
//   Hive.registerAdapter(NotificationModelAdapter());

//   var colognesBox = await Hive.openBox<Cologne>(BoxName.COLOGNE);
//   var historyBox = await Hive.openBox<History>(BoxName.HISTORY);
//   var notfBox = await Hive.openBox<NotificationModel>(BoxName.NOTIFICATION);
//   var appParamBox = await Hive.openBox<String>(BoxName.APP);
//   // initialize local notification plugin
//   await NotificationHelper.init(context);

//   // initialize jiffy
//   await Jiffy.locale("tr");

//   var isInitialized = appParamBox.get("isInitialized", defaultValue: "false");

//   if (isInitialized == "false") {
//     // initialize colognes
//     colognes.forEach((c) async {
//       c.histories = HiveList(historyBox);
//       await colognesBox.add(c);
//     });
//     await notfBox.addAll(notifications);
//     // initialize notification
//     await NotificationHelper.instance.generateNotifications(
//         notfBox.values.cast<NotificationModel>().toList());

//     // initialize finished
//     appParamBox.put("isInitialized", "true");
//   }

//   DateTime end = DateTime.now();
//   print(end.millisecondsSinceEpoch - start.millisecondsSinceEpoch);
// }
