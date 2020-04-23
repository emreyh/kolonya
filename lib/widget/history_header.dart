import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/history.dart';

class HistortHeader extends StatelessWidget {
  const HistortHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "Temizlik Geçmişi",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Tümünü Göster"),
                  Consumer<HistoryState>(
                    builder: (context, state, child) {
                      return Switch(
                        value: state.isAllHistories,
                        onChanged: (value) => state.isAllHistories = value,
                        activeTrackColor: Theme.of(context).primaryColorLight,
                        activeColor: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey[500],
            height: 5,
          ),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
