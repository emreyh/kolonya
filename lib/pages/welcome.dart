import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kolonya/provider/cologne.dart';
import 'package:kolonya/provider/history.dart';
import 'package:provider/provider.dart';
import '../const/boxes.dart';
import '../const/adverts.dart';
import '../helper/notification_helper.dart';
import '../model/history.dart';
import '../model/kolonya.dart';
import '../model/notification.dart';
import '../pages/home.dart';
import '../values/initial_data.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = "/welcome";
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/app_icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 48.0,
                      margin: EdgeInsets.only(bottom: 25.0),
                      width: 48.0,
                    ),
                    Text(
                      'Kolonya App',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Hayat Eve Sığar',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _init() async {
    DateTime start = DateTime.now();
    Admob.initialize(Adverts.instance.APP_MOB_ID);
    // initialize local notification plugin
    await NotificationHelper.instance.init(context);

    // initialize jiffy
    await Jiffy.locale("tr");
    var appParamBox = Hive.box<String>(BoxName.APP);
    var isInitialized = appParamBox.get("isInitialized", defaultValue: "false");

    if (isInitialized == "false") {
      var historyBox = Hive.box<History>(BoxName.HISTORY);
      var cologneBox = Hive.box<Cologne>(BoxName.COLOGNE);
      var notfBox = Hive.box<NotificationModel>(BoxName.NOTIFICATION);
      // initialize colognes
      colognes.forEach((c) async {
        c.histories = HiveList(historyBox);
        await cologneBox.add(c);
      });
      await notfBox.addAll(notifications);
      // initialize notification
      await NotificationHelper.instance.generateNotifications(
          notfBox.values.cast<NotificationModel>().toList());

      // initialize finished
      appParamBox.put("isInitialized", "true");
    }
    Provider.of<CologneState>(context, listen: false).init();
    Provider.of<HistoryState>(context, listen: false).init();

    DateTime end = DateTime.now();
    print(end.millisecondsSinceEpoch - start.millisecondsSinceEpoch);

    NotificationAppLaunchDetails notificationDetail =
        await NotificationHelper.instance.getNotificationAppLaunchDetails();

    Timer(Duration(milliseconds: 1500), () {
      if (notificationDetail.didNotificationLaunchApp) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (Route<dynamic> route) => false,
          arguments: notificationDetail.payload,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (Route<dynamic> route) => false,
        );
      }
    });
  }
}
