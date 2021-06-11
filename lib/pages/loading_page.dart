import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/services/auth_service.dart';


class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( BuildContext context, AsyncSnapshot<dynamic> snapshot ) {
          return Center(
            child: Text('Espere un momento'),
          );
        } ,
      )
    );
  }
  Future checkLoginState( BuildContext context ) async{
    final authService = Provider.of<AuthService>(context, listen: false);

    final auth = await authService.isLoogedIn();

    if( auth ) {
      Navigator.pushReplacementNamed(context, 'profile');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}