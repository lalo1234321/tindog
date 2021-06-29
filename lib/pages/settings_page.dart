import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/services/user_service.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController newPasswordCtl= TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen:  true);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    bool premium = AuthService.user.premium;
    final petName = authService.petName;
    return Scaffold(
      
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
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
              SizedBox(height: 30,),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _showAlertDialog(context, () async{
                          await userService.updatePassword(this.newPasswordCtl.text);
                          Navigator.of(context).pop();
                        });
                      },
                      child: ListTile(
                        leading: Icon(Icons.lock_outline, color: Colors.blue,),
                        title: Text('Cambiar contraseña'),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.house, color: Colors.blue,),
                      title: Text('Cambiar estado'),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                    ),
                    ListTile(
                      leading: Icon(Icons.house_outlined, color: Colors.blue,),
                      title: Text('Cambiar municipio'),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'premium');
                      },
                      child: ListTile(
                        leading: Icon(Icons.money, color: Colors.blue,),
                        title: Text('Cambiar a premium'),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                      ),
                    ),
                    (premium) ? GestureDetector(
                      onTap: () {
                          print('navegando');
                          Navigator.pushNamed(context, 'registerPet'); 
                      },
                      child: ListTile(
                        leading: Icon(Icons.pets, color: Colors.blue,),
                        title: Text('Registrar una mascota'),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                      ),
                    ) : Container(
                      color: Colors.blue[300],
                      child: ListTile(
                        
                        leading: Icon(Icons.pets, color: Colors.white,),
                        title: Text('Registrar una mascota'),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                        
                      ),
                    )
                    ,
                    (premium) ? ListTile(
                      leading: Icon(Icons.place, color: Colors.blue,),
                      title: Text('Buscar veterinarias más cercanas'),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                      onTap: () async{
                        Navigator.pushNamed(context, 'search');
                      },
                    ) : Container(
                      color: Colors.blue[300],
                      child: ListTile(
                        
                        leading: Icon(Icons.pets, color: Colors.white,),
                        title: Text('Buscar veterinarias más cercanas'),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                      ),
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
                        await socketService.disconnect();
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
      ),
    );
  }
  void _showAlertDialog( BuildContext context, Function accept) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text('Editando'),
          content: TextField(
            controller: this.newPasswordCtl,
            decoration: InputDecoration(
              labelText: 'editar',
              prefixIcon: Icon(
                Icons.house,
                size:18,
                color: Colors.blue
              ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
            ),
          ),
          ),
          actions: <Widget>[
            TextButton(
            child: Text("Aceptar"),
            onPressed: accept),
          ],
        );
        
      }
    );
  }
}