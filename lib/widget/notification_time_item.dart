import '../model/frequancy.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import '../provider/notification.dart';
import '../model/notification.dart';

class NotificationTimeItem extends StatelessWidget {
  final index;
  final NotificationModel ntf;
  final Function notificationTimePicker;
  const NotificationTimeItem(this.index, this.ntf, this.notificationTimePicker);

  @override
  Widget build(BuildContext context) {
    var jiffyTime = Jiffy(ntf.time).Hm;
    return Material(
      color: Colors.transparent,
      type: MaterialType.transparency,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          splashColor: Colors.green[200],
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onTap: () => notificationTimePicker(context, ntf),
          onLongPress: () => ntf.frequancy == Frequancy.Weekly
              ? null
              : _showDialog(context, ntf, jiffyTime),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridTile(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.access_time),
                      SizedBox(width: 15),
                      Text('$jiffyTime'),
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(context, NotificationModel ntf, String time) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Seçtiğiniz bildirim silinsin mi?"),
              Divider(
                color: Colors.grey,
                height: 5,
              ),
            ],
          ),
          content: Text(
              "$time saatinde alınan bildirim silinecek. Devam etmek istiyor musunuz?"),
          actions: <Widget>[
            new FlatButton(
              splashColor: Colors.red[100],
              child: Text("Vazgeç", style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                Provider.of<NotificationState>(context, listen: false)
                    .removeNotificationTime(ntf);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
