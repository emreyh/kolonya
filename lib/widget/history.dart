import 'package:flutter/material.dart';
import 'package:kolonya/widget/history_list.dart';
import './history_header.dart';

class HistoryWidget extends StatelessWidget {
  final Function(int key) deleteHistory;
  HistoryWidget({this.deleteHistory});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          HistortHeader(),
          HistoryList(deleteHistory: deleteHistory),
        ],
      ),
    );
  }
}
