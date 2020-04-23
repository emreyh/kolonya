import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:provider/provider.dart';
import '../provider/history.dart';
import '../model/kolonya.dart';
import '../model/frequancy.dart';

class CologneChart extends StatefulWidget {
  CologneChart({Key key}) : super(key: key);

  @override
  CologneChartState createState() => CologneChartState();
}

class CologneChartState extends State<CologneChart> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  Color labelColor = Colors.red[200];
  final _chartSize = const Size(180.0, 180.0);

  @override
  Widget build(BuildContext context) {
    return _buildChart();
  }

  Widget _buildChart() {
    HistoryState state = Provider.of<HistoryState>(context);
    Cologne cologne = state.selectedCologne;
    double complated = state.complatedPercent;
    int complatedCount = state.complatedCount;
    int remainigCount = state.remainingCount;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
        color: Colors.white60,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Tooltip(
            message: '${valueToString(cologne?.frequancy)} temizlik yüzdesi',
            child: AnimatedCircularChart(
              key: _chartKey,
              size: _chartSize,
              initialChartData: generateChartData(complated),
              chartType: CircularChartType.Radial,
              percentageValues: true,
              edgeStyle: SegmentEdgeStyle.round,
              holeLabel: '%${complated.toStringAsFixed(1)} ',
              holeRadius: 60,
              duration: Duration(milliseconds: 700),
              labelStyle: Theme.of(context).textTheme.title.merge(
                    TextStyle(color: labelColor, fontSize: 35.0),
                  ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildChartInformation(Icons.timelapse, Colors.blueGrey,
                  valueToString(cologne?.frequancy), 'Bildirim sıklığı'),
              _buildChartInformation(
                  Icons.notifications_active,
                  Colors.blueGrey,
                  cologne.targetCleaningCount.toString(),
                  'Toplam bildirim sayısı'),
              _buildChartInformation(Icons.check, Colors.greenAccent,
                  complatedCount.toString(), 'Tamamlanan temizlik sayısı'),
              _buildChartInformation(
                  Icons.close,
                  Colors.blueGrey,
                  remainigCount < 0 ? '0' : remainigCount.toString(),
                  'Kalan temizlik sayısı'),
            ],
          ),
        ],
      ),
    );
  }

  _buildChartInformation(
      IconData icon, Color iconColor, String info, String mesg) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 5.0, bottom: 5.0),
          child: Tooltip(
            message: mesg,
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
        ),
        Text(
          info,
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  void updateChart() {
    HistoryState state = Provider.of<HistoryState>(context, listen: false);
    _chartKey.currentState
        .updateData(generateChartData(state.complatedPercent));
  }

  List<CircularStackEntry> generateChartData(double value) {
    Color dialColor = Colors.green[300];
    if (value > 0 && value <= 30) {
      dialColor = Colors.red[200];
    } else if (value > 30 && value <= 50) {
      dialColor = Color(0xFFF49762);
    } else if (value > 50 && value <= 70) {
      dialColor = Color(0xFFFFD301);
    } else if (value > 70 && value <= 99.99) {
      dialColor = Color(0xFFBBCD49);
    }

    labelColor = dialColor;

    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value,
            dialColor,
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage',
      ),
    ];

    if (value > 100) {
      labelColor = Colors.green[200];

      data.add(
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              value - 100,
              Colors.green[200],
              rankKey: 'percentage',
            ),
          ],
          rankKey: 'percentage2',
        ),
      );
    }

    return data;
  }
}
