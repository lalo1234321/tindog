import 'package:flutter/material.dart';


class BtnAzul extends StatelessWidget {

  final String texto;
  final Function onPressed;

  const BtnAzul({
    Key key, 
    @required this.texto, 
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        backgroundColor:  (this.onPressed==null) ? MaterialStateProperty.all(Colors.grey):MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          // side: BorderSide(color: Colors.red)
          )
        ),
      ),
      
      child: Container(
        height: 40,
        child: Center(
          child: Text(this.texto, style: TextStyle(color: Colors.white, fontSize: 17)),
        )
      )
    );
  }
}