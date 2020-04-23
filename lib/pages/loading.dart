import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  static const routeName = "/loading";
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
