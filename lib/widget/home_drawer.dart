import 'package:flutter/material.dart';
import 'package:kolonya/pages/about.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/img/app_icon.png",
                  fit: BoxFit.contain,
                  height: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kolonya App",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Hayat Eve Sığar",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
              trailing: Icon(Icons.info),
              title: Text(
                "Hakkında",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700]),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, About.routeName);
              })
        ],
      ),
    );
  }
}
