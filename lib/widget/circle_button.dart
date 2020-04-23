import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function onTap;
  final double size;
  final double padding;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  CircleButton({
    Key key,
    @required this.icon,
    @required this.onTap,
    this.size,
    this.padding,
    this.iconColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onTap == null
        ? SizedBox.shrink()
        : ClipOval(
            child: Material(
              type: MaterialType.transparency,
              color: Colors.transparent,
              child: InkWell(
                splashColor:
                    Theme.of(context).primaryColorLight, // inkwell color
                child: Container(
                  padding: EdgeInsets.all(padding ?? 20),
                  child: Icon(
                    icon ?? Icon(Icons.tag_faces),
                    color: iconColor ?? Colors.grey,
                    size: size ?? 15,
                  ),
                ),
                onTap: onTap,
              ),
            ),
          );
  }
}
