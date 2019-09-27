import 'package:flutter/material.dart';

class BottomRowElement extends StatelessWidget {
  final IconData iconData;
  final String text;

  BottomRowElement(this.text, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        children: <Widget>[
          iconData != null
              ? Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Icon(iconData,
                      size: 16, color: Color.fromARGB(180, 0, 0, 0)),
                )
              : null,
          Text(text)
        ].where((widget) => widget != null).toList(),
      ),
    );
  }
}
