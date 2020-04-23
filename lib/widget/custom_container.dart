import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const CustomContainer({Key key, @required this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: SingleChildScrollView(
                child: child,
                padding: padding ?? EdgeInsets.all(0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
