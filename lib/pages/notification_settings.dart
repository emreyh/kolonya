import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/custom_container.dart';
import '../const/adverts.dart';
import '../const/notification.dart';
import '../widget/notification_day.dart';
import '../widget/notification_time.dart';
import '../model/frequancy.dart';
import '../provider/notification.dart';

class NotificationSettings extends StatefulWidget {
  static const routeName = "/notifications";

  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  final List<DropdownMenuItem<Frequancy>> _notificationFrequancyItems =
      NotificationConstant.notificationFrequancyList
          .map(
            (frequancy) => DropdownMenuItem<Frequancy>(
              value: frequancy,
              child: Text(valueToString(frequancy)),
            ),
          )
          .toList();

  final List<DropdownMenuItem<int>> _notificationCountItems =
      NotificationConstant.notificationCount
          .map(
            (c) => DropdownMenuItem<int>(
              value: c,
              child: Text('$c'),
            ),
          )
          .toList();
  @override
  void initState() {
    super.initState();
    Provider.of<NotificationState>(context, listen: false)
        .initDataNotificationPage();
  }

  @override
  Widget build(BuildContext context) {
    final title = Provider.of<NotificationState>(context, listen: false)
        .selectedCologne
        .title;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Ayarlar',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomContainer(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            Divider(
              color: Colors.grey,
              height: 5.0,
            ),
            SizedBox(height: 10.0),
            _buildNotificationFrequancy(context),
            SizedBox(height: 10.0),
            _buildNotificationCount(context),
            NotificationDayWidget(),
            SizedBox(height: 10.0),
            NotificationTimeWidget(),
          ],
        ),
      ),
      bottomNavigationBar: bannerAdvertsWidget(),
    );
  }

  _buildNotificationCount(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.format_list_numbered),
            Text(
              "Bildirim Sayısı:",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Consumer<NotificationState>(
            builder: (ctx, state, _) {
              return DropdownButton(
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 42,
                underline: SizedBox.shrink(),
                value: state.notificationCount,
                items: _notificationCountItems,
                hint: Text('Seçiniz'),
                disabledHint: Text("${state.notificationCount}"),
                onChanged: null,
              );
            },
          ),
        ),
      ],
    );
  }

  _buildNotificationFrequancy(context) {
    final frequancy = Provider.of<NotificationState>(context).frequancy;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.notifications_active),
            Text(
              "Bildirim Sıklığı:",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox.shrink(),
            hint: Text("Seçiniz"),
            disabledHint: Text('${valueToString(frequancy)}'),
            items: _notificationFrequancyItems,
            value: frequancy,
            onChanged:
                null, //TODO : feature, (newVal) => state.frequancy = newVal,
          ),
        ),
      ],
    );
  }

  Widget bannerAdvertsWidget() {
    return Container(
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: AdmobBanner(
        adUnitId: Adverts.instance.BANNER_ID,
        adSize: AdmobBannerSize.BANNER,
      ),
    );
  }
}
