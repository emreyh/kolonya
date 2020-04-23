import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/kolonya.dart';
import '../widget/history_item.dart';
import '../provider/history.dart';

class HistoryList extends StatelessWidget {
  final Function(int key) deleteHistory;
  const HistoryList({Key key, this.deleteHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.33,
      child: Consumer<HistoryState>(
        builder: (context, state, child) {
          var histories = state.selectedHistories;
          return histories.isEmpty
              ? _buildEmptyContainer(context, state.selectedCologne)
              : ListView.builder(
                  itemBuilder: (context, index) => HistoryItem(
                    history: histories[index],
                    deleteHistory: deleteHistory,
                  ),
                  itemCount: histories.length,
                );
        },
      ),
    );
  }

  Widget _buildEmptyContainer(context, Cologne cologne) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Henüz bir temizlik yapmadın.",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "Hemen şimdi temizlik yap ve buraya ekle!",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
