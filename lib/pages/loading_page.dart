import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/widgets/fli%E1%B9%95_loader.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( BuildContext context, AsyncSnapshot<dynamic> snapshot ) {
          return Center(
            child: FlipLoader(
              loaderBackground: Colors.blue,
              iconColor: Colors.white,
              icon: Icons.email,
              animationType: "full_flip"),
          );
        } ,
      )
    );
  }

  Future checkLoginState( BuildContext context ) async{
    final authService = Provider.of<AuthService>(context, listen: false);
    //final socketService = Provider.of<SocketService>(context, listen: false);
    final auth = await authService.isLoogedIn();

    if( auth ) {
      //socketService.connect();
      Navigator.pushReplacementNamed(context, 'profile');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}