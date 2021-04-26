import 'package:flutter/material.dart';
import 'package:tindog/pages/home_page.dart';
import 'package:tindog/pages/registromascota_page.dart';


 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': ( BuildContext context ) => HomePage(),
        'registromascota': (BuildContext context) => RegistroMascota(),
        
        


      },
    );
  }
}