import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MaterialCircleButton extends StatelessWidget {
  MaterialCircleButton({@required this.icon, @required this.buttonDiameter, @required this.onTap})
      : iconSize = buttonDiameter / 2;

  final IconData icon;
  final double buttonDiameter;
  final double iconSize;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return new SizedBox.fromSize(
      size: Size(buttonDiameter, buttonDiameter), // button width and height
      child: ClipOval(
        child: Material(
          color: Colors.white, // button color
          child: InkWell(
            splashColor: Colors.grey, // splash color
            onTap: onTap, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: iconSize), // icon
              ],
            ),
          ),
        ),
      ),
    );
  }
}
