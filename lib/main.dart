


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/home_view.dart';
import 'package:tindog/pages/login_page.dart';
import 'package:tindog/pages/register_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (BuildContext context ) => HomeView())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          
          'login': ( BuildContext context ) => LoginPage(),
          'register' : (BuildContext context) => RegisterPage()
        },
      ),
    );
  }
}