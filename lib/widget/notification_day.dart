import 'package:flutter/material.dart';
import '../const/notification.dart';
import '../model/frequancy.dart';
import '../provider/notification.dart';
import 'package:provider/provider.dart';

class NotificationDayWidget extends StatelessWidget {
  const NotificationDayWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationState>(
      builder: (context, state, _) {
        var frequancy = state.frequancy;
        return frequancy == Frequancy.Daily
            ? SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.calendar_today),
                          Text(
                            "Bildirim Günleri:",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 4.0,
                    runSpacing: 1.0,
                    direction: Axis.horizontal,
                    children: Day.values.map(
                      (d) {
                        return FilterChip(
                          backgroundColor: Colors.white10,
                          selectedColor: Colors.green[200],
                          avatar: CircleAvatar(child: SizedBox.shrink()),
                          label: Text(d.day),
                          selected:
                              state.selectedDays.any((n) => n.day == d.val),
                          onSelected: (bool value) {
                            if (value) {
                              state.addNotificationDay(d);
                            } else {
                              state.removeNotificationDay(d);
                            }
                          },
                        );
                      },
                    ).toList(),
                  ),
                ],
              );
      },
    );
  }
}
