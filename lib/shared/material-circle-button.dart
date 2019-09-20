import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MaterialCircleButton extends StatelessWidget {
  MaterialCircleButton(
      {@required this.icon,
      @required this.buttonDiameter,
      @required this.onTap,
      @required this.color,
      @required this.iconColor,
      @required this.isDisabled})
      : iconSize = buttonDiameter / 2;

  final IconData icon;
  final double buttonDiameter;
  final double iconSize;
  final GestureTapCallback onTap;
  final Color color;
  final Color iconColor;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: new SizedBox.fromSize(
        size: Size(buttonDiameter, buttonDiameter), // button width and height
        child: ClipOval(
          child: Material(
            color: isDisabled ?? false ? Colors.grey : color, // button color
            child: InkWell(
              splashColor: Colors.grey, // splash color
              onTap: isDisabled ?? false ? () => {} : onTap, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon,
                      size: iconSize,
                      color: isDisabled ?? false
                          ? Colors.grey[800]
                          : iconColor), // icon
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
