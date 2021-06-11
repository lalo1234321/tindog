import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/services/auth_service.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final petName = authService.petName;
    return Scaffold(
      
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 60,),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.all(8.0),
              color: Colors.blue,
              child: ListTile(
                onTap: () {},
                title: Text(petName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                trailing: Icon(Icons.edit, color: Colors.white,),
              ),
            ),
            SizedBox(height: 50,),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.lock_outline, color: Colors.blue,),
                    title: Text('Cambiar password'),
                    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                  ),
                  ListTile(
                    leading: Icon(Icons.money, color: Colors.blue,),
                    title: Text('Cambiar a premium'),
                    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                  ),
                  ListTile(
                    leading: Icon(Icons.pets, color: Colors.blue,),
                    title: Text('Registrar una mascota'),
                    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.blue,),
                    title: Text('Cerrar sesión'),
                    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                    onTap: () async{
                      //TODO desconectar de nuestro socket server
                      // como yo no quiero instanciar todo el authservice podemos entrar a los métodos estáticos
                      // por eso es imporetante trabajar con métodos estáticos según nos convenga
                      // socketService.disconnect();
                      await authService.logout();
                      Navigator.pushReplacementNamed(context, 'login');
                      // AuthService.deleteToken();
                      //  en este punto ya se borró el token y cuand0 reiniciemos la app la loading page nos
                      // redirigirá al login page
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.blue,),
                    title: Text('Acerca de'),
                    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                  )
                ],
              ),
            )

            
          ],
        ),
      ),
    );
  }
}