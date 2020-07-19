import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  Function callback;
  IconData icon;

  ActionButton({@required this.icon, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      child: InkWell(
        onTap: () {
          callback();
        },
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Icon(icon),
        ),
      ),
    );
  }
}
