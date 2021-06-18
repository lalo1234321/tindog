import 'package:flutter/material.dart';


class Alerts extends StatelessWidget {
  final title;
  final subtitle;

  const Alerts({Key key, @required this.title, @required this.subtitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: <Widget>[
            TextButton(
              child: Text("CERRAR", style: TextStyle(color: Colors.white),),
              onPressed: (){ Navigator.of(context).pop(); },
            )
          ],
        );
  }
}