import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import '../provider/cologne.dart';
import '../model/history.dart';
import './circle_button.dart';

class HistoryItem extends StatelessWidget {
  final History history;
  final void Function(int key) deleteHistory;
  const HistoryItem({Key key, this.history, this.deleteHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cologne =
        Provider.of<CologneState>(context, listen: false).selectedCologne;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: ListTile(
            onTap: () {},
            leading: CircleAvatar(
              child: Image.asset(
                cologne.imageUrl,
                fit: BoxFit.contain,
                height: 20,
              ),
            ),
            title: Text(
              cologne.title,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              Jiffy(history.cleanDate).fromNow(),
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            trailing: CircleButton(
              size: 20,
              padding: 15,
              icon: Icons.delete,
              iconColor: Colors.red,
              onTap: () => deleteHistory(history.key),
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
