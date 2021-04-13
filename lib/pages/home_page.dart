import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tindog/widgets/btn_azul.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('página principal'),
            SizedBox(height: 30.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: BtnAzul(texto: "botón personalizado", onPressed: () {

              }),
            ),
            SizedBox(height: 30.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text('Pueden refactorizar componenetes al crear sus propios widgets en la carpeta widgets',
              style: TextStyle(fontSize: 20),)
            )
          ],
        )
      ),
    );
  }
}