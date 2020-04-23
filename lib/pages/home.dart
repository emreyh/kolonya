// import 'package:firebase_admob/firebase_admob.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../const/adverts.dart';
import '../values/notification_content.dart';
import '../widget/custom_container.dart';
import '../widget/history.dart';
import '../widget/home_drawer.dart';
import '../model/history.dart';
import '../pages/notification_settings.dart';
import '../provider/cologne.dart';
import '../provider/history.dart' show HistoryState;
import '../widget/chart.dart';
import '../widget/circle_button.dart';
import '../model/kolonya.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  final String payload;
  HomePage([this.payload]);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<CologneChartState> _cologneChartKey = GlobalKey();
  final GlobalKey<ScaffoldState> _homePageKey = new GlobalKey<ScaffoldState>();
  DateTime _currentBackPressTime;
  bool _showAdverts = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (widget.payload != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        CologneState cologneState = Provider.of<CologneState>(context, listen: false);
        HistoryState historyState = Provider.of<HistoryState>(context, listen: false);
        cologneState.selectedIndex = int.parse(widget.payload);
        historyState.selectedCologne = cologneState.selectedCologne;
        _cologneChartKey.currentState.updateChart();
        await _showConfirmationDialog();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      setState(() {
        _showAdverts = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      setState(() {
        _showAdverts = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homePageKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _buildAppBar(),
      drawer: HomeDrawer(),
      body: WillPopScope(
        onWillPop: _onWillCloseApp,
        child: CustomContainer(
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0),
              Stack(
                children: <Widget>[
                  CologneChart(key: _cologneChartKey),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: CircleButton(
                      onTap: _addHistory,
                      icon: Icons.add_circle,
                      size: 30,
                      padding: 15,
                      iconColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white10,
                    ),
                  ),
                ],
              ),
              HistoryWidget(deleteHistory: _deleteHistory),
              _showAdverts ? bannerAdvertsWidget() : SizedBox.shrink(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<CologneState>(
        builder: (BuildContext context, CologneState state, Widget child) {
          return CurvedNavigationBar(
            backgroundColor: Theme.of(context).accentColor,
            height: 45,
            color: Theme.of(context).primaryColor,
            index: state.selectedIndex,
            buttonBackgroundColor: Theme.of(context).primaryColorLight,
            items: state.colognes.map((item) => _buildBottomNavigationIcon(item.imageUrl)).toList(),
            onTap: (index) => _onTapBottomNavigation(index),
          );
        },
      ),
    );
  }

  _onTapBottomNavigation(int index) {
    CologneState cologneState = Provider.of<CologneState>(context, listen: false);
    cologneState.selectedIndex = index;

    HistoryState historyState = Provider.of<HistoryState>(context, listen: false);
    historyState.selectedCologne = cologneState.selectedCologne;
    _cologneChartKey.currentState.updateChart();
  }

  _deleteHistory(int historyId) {
    HistoryState state = Provider.of<HistoryState>(context, listen: false);
    state.deleteHistory(historyId);
    _cologneChartKey.currentState.updateChart();
  }

  _addHistory() {
    HistoryState state = Provider.of<HistoryState>(context, listen: false);
    Cologne selectedCologne = state.selectedCologne;
    History history = new History(
      cologneId: selectedCologne.id,
      cleanDate: DateTime.now(),
    );
    state.addHistory(history);
    _cologneChartKey.currentState.updateChart();
  }

  Widget _buildBottomNavigationIcon(String img) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 25,
      child: Image.asset(
        img,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _homePageKey.currentState.openDrawer();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            setState(() {
              _showAdverts = false;
            });
            Navigator.pushNamed(context, NotificationSettings.routeName).then((_) {
              setState(() {
                _showAdverts = true;
              });
            });
          },
        ),
      ],
      title: Text(
        "#EvdeKal",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _showConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        Cologne cologne = Provider.of<CologneState>(context, listen: false).selectedCologne;
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    cologne.imageUrl,
                    fit: BoxFit.scaleDown,
                    height: 35.0,
                  ),
                  Text(
                    "${cologne.title}",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                height: 5,
              ),
            ],
          ),
          content: Wrap(
            direction: Axis.horizontal,
            children: [
              Text(
                NotificationContent.elementAt(cologne.id).confirmationMessage,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              splashColor: Colors.red[100],
              child: Text(
                "Vazgeç",
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                _addHistory();
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onWillCloseApp() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null || now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Kolonyadan çıkmak için tekrar dokunun.",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          backgroundColor: Colors.black87,
          gravity: ToastGravity.BOTTOM);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget bannerAdvertsWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: AdmobBanner(
        adUnitId: Adverts.instance.BANNER_ID,
        adSize: AdmobBannerSize.BANNER,
      ),
    );
  }
}
