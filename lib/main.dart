


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/home_view.dart';
import 'package:tindog/pages/chat_page.dart';
import 'package:tindog/pages/login_page.dart';
import 'package:tindog/pages/match_page.dart';
import 'package:tindog/pages/profile_page.dart';
import 'package:tindog/pages/register_page.dart';
import 'package:tindog/pages/users_page.dart';
import 'package:tindog/services/auth_service.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (BuildContext context ) => HomeView()),
        ChangeNotifierProvider(create: ( BuildContext context ) => AuthService())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          
          'login': ( BuildContext context ) => LoginPage(),
          'register' : (BuildContext context) => RegisterPage(),
          'profile' : (BuildContext context) => ProfilePage(),
          'chats' : (BuildContext context) => UsersPage(),
          'match' : (BuildContext context) => MatchPage(),
          'chat' : (BuildContext context) => ChatPage()
        },
      ),
    );
  }
}