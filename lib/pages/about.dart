import 'package:flutter/material.dart';
import 'package:kolonya/pages/loading.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  static const String routeName = "/about";
  About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  PackageInfo packageInfo;
  bool isPackageInfo = false;

  @override
  void initState() {
    super.initState();
    loadPackageInfo();
  }

  void gitHub() async {
    const url = 'https://github.com/emreyh/kolonya';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void loadPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      isPackageInfo = true;
    });
  }

  void licenses(BuildContext ctx) {
    showAboutDialog(
        context: ctx,
        applicationIcon: Image.asset(
          'assets/img/app_icon.png',
          height: 50,
        ),
        applicationName: "Kolonya App",
        applicationLegalese: "@All Copyright Reserved",
        applicationVersion: "${packageInfo.version}",
        children: <Widget>[]);
  }

  @override
  Widget build(BuildContext context) {
    if (!isPackageInfo) {
      return LoadingPage();
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 45, 30, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/img/app_icon.png', height: 110),
                SizedBox(height: 15),
                Text(
                  "Kolonya App",
                  style: TextStyle(
                    color: Color(0xff057163),
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "Version ${packageInfo.version}",
                  style: TextStyle(color: Color(0xff057163)),
                ),
                SizedBox(height: 20),
                OutlineButton(
                  borderSide: BorderSide(color: Color(0xff026c5d)),
                  splashColor: Color(0xffe9f4f3),
                  highlightColor: Color(0xffe9f4f3),
                  textColor: Color(0xff026c5d),
                  child: Text("License"),
                  onPressed: () {
                    licenses(context);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Kolonya App, temizlikle ilgili hatırlatıcı bildirimler almanızı sağlar. Bu uygulama açık kaynaktır ve kodlarına Github'dan erişebilirisiniz.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff057163),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: gitHub,
                  child: FittedBox(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/img/github.png', height: 25),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Fork the project on GitHub",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.link,
                            color: Colors.blueAccent,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Made with "),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 16,
                    ),
                    Text(" by "),
                    Text(
                      "Yunus Emre Reyhanlıoğlu",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Designed by "),
                    Text(
                      "Büşra Reyhanlıoğlu",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
