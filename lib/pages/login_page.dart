

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/home_view.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/widgets/alerts.dart';
import 'package:tindog/widgets/btn.dart';
import 'package:tindog/widgets/custom_input.dart';
import 'package:tindog/widgets/wave_widget.dart';


class LoginPage extends StatelessWidget {
  final emailCtl = TextEditingController();
  final passCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeView>(context);
    final authService = Provider.of<AuthService>(context);
    // final socketServide = Provider.of<SocketService>(context);
    final size = MediaQuery.of(context).size;
    // para saber si el keyboard está abierto
    final bool keyBoardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: size.height -200,
            color: Colors.blue
          ),
          AnimatedPositioned(
            duration: Duration( milliseconds: 500 ),
            curve: Curves.easeOutQuad,
            top: keyBoardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: Colors.white
            ),
          ),
          Padding(
            padding: const EdgeInsets.only( top: 100 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CustomInput(
                  hintText: 'Correo',
                  obscureText: false,
                  prefixIconData: Icons.mail_outline,
                  textController: emailCtl,
                ),
                SizedBox(height: 10,),
                CustomInput(
                  hintText: 'Contraseña',
                  obscureText: model.isVisible ? true : false,
                  prefixIconData: Icons.lock_outline,
                  sufixIconData: model.isVisible ? Icons.visibility : Icons.visibility_off ,
                  textController: passCtl,
                ),
                SizedBox(height: 20,),
                Btn(
                  title: 'Iniciar sesión',
                  hasBorder: false,
                  onChanged:  authService.autenticando ? null :
                    () async{
                      print('email ${emailCtl.text}\npassword ${passCtl.text}' );
                      final loginOk = await authService.login(emailCtl.text, passCtl.text);
                      if( loginOk == true ) {
                        //TODO mostrar alertas en caso de que falle el login
                        //socketServide.connect();
                        Navigator.pushReplacementNamed(context, 'profile');
                      } else {
                        _showAlertDialog(context,'Error', loginOk.toString());
                      }
                      
                    },
                  // onChanged: () {
                    
                  //   print('email ${emailCtl.text} \npassword ${passCtl.text}');
                  //   Navigator.pushReplacementNamed(context, 'profile');
                  // },
                ),
                SizedBox(height: 20,),
                Btn(
                  title: 'Registrarse',
                  hasBorder: true,
                  onChanged: () {
                    Navigator.pushReplacementNamed(context, 'register');
                  },
                ),
                
              ],
          ),
        ),
        ],
        
      )

    );
  }

  void _showAlertDialog( BuildContext context, String title, String subtitle ) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: <Widget>[
            TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
          ],
        );
      }
    );
  }
}