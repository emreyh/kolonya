import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';
import '../model/notification.dart';
import '../const/notification.dart';
import '../model/frequancy.dart';
import '../provider/notification.dart';
import '../widget/notification_time_item.dart';
import './circle_button.dart';

class NotificationTimeWidget extends StatelessWidget {
  @override
  build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    final NotificationState state =
        Provider.of<NotificationState>(context, listen: false);
    final frequancy = state.frequancy;
    final notificationCount = state.notificationCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.access_alarm),
                Text(
                  "Bildirim Saatleri:",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            CircleButton(
              icon: Icons.add_circle,
              iconColor: Theme.of(context).primaryColor,
              size: 30,
              padding: 15,
              onTap: frequancy == Frequancy.Weekly ||
                      NotificationConstant.maxNotificationCount ==
                          notificationCount
                  ? null
                  : () => _showNotificationTimePicker(context),
            ),
          ],
        ),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        Container(
          height: height * (frequancy == Frequancy.Daily ? 0.42 : 0.35),
          child: Consumer<NotificationState>(
            builder: (ctx, state, _) {
              final notificationTimes = state.notificationTimes;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3.5,
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3),
                itemBuilder: (context, index) {
                  return NotificationTimeItem(index, notificationTimes[index],
                      _showNotificationTimePicker);
                },
                itemCount: notificationTimes.length,
              );
            },
          ),
        ),
      ],
    );
  }

  _showNotificationTimePicker(context, [NotificationModel ntf]) {
    var state = Provider.of<NotificationState>(context, listen: false);
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 24),
          NumberPickerColumn(begin: 0, end: 59),
        ]),
        // PickerDataAdapter<String>(pickerdata: notificationTimesData, isArray: true),
        changeToFirst: true,
        hideHeader: false,
        cancelTextStyle: TextStyle(color: Colors.red),
        cancelText: 'Vazgeç',
        confirmText: 'Tamam',
        selecteds:
            ntf?.time == null ? [] : [ntf?.time?.hour, ntf?.time?.minute],
        confirmTextStyle: TextStyle(color: Colors.green),
        onConfirm: (Picker picker, List value) {
          int hour = value[0];
          int minute = value[1];
          var newTime = DateTime(2020, 1, 1, hour, minute);
          if (ntf == null) {
            state.addNotificationTime(newTime);
          } else {
            state.updateNotificationModel(ntf.key, newTime);
          }
        }).showModal(context); //_scaffoldKey.currentState);
  }
}
