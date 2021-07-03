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
  List<int> ages = [1,2,3,4,5,6,7,8,9,10,11,12,13];
  int selectedOption = 1;
  TextEditingController newPasswordCtl= TextEditingController();
  TextEditingController newTownCtl = TextEditingController();
  TextEditingController newStateCtl = TextEditingController();
  TextEditingController newPetNameCtl = TextEditingController();
  TextEditingController newPetAgeCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen:  true);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    bool premium = AuthService.user.premium;
    String petName = authService.petName;
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
                  onTap: (premium) ? () {
                    _showAlertDialog(context, () async{
                          
                          await userService.updatePetName(this.newPetNameCtl.text);
                          Navigator.of(context).pop();
                          await authService.savePetName(newPetNameCtl.text);
                          setState(() {
                             
                          });
                        },this.newPetNameCtl);
                  } : null,
                  title: Text(petName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                  trailing: Icon(Icons.edit, color: Colors.white,),
                ),
              ),
              // Card(
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              //   margin: EdgeInsets.all(8.0),
              //   color: Colors.blue,
              //   child: ListTile(
              //     onTap: (premium) ? () {
              //       _showAlertDialogAge(context, () async{
              //             await userService.updatePetAge(selectedOption);
              //             Navigator.of(context).pop();
                          
              //           },this.newPetAgeCtl);
              //     } : null,
              //     title: Text('Modificar edad de la mascota', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
              //     trailing: Icon(Icons.edit, color: Colors.white,),
              //   ),
              // ),
              SizedBox(height: 30,),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async{
                        //await userService.updateTown('Guanajuato');
                        //await userService.updatePassword('nada');
                        _showAlertDialog(context, () async{
                          print(newPasswordCtl.text);
                          print(this.newPasswordCtl.text);
                          await userService.updatePassword(this.newPasswordCtl.text);
                          Navigator.of(context).pop();
                        },this.newPasswordCtl);
                      },
                      child: ListTile(
                        leading: Icon(Icons.lock_outline, color: Colors.blue,),
                        title: Text('Cambiar contraseña'),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showAlertDialog(context, () async{
                          
                          await userService.updateState(this.newStateCtl.text);
                          Navigator.of(context).pop();
                        },this.newStateCtl);
                      },
                      child: ListTile(
                        leading: Icon(Icons.house, color: Colors.blue,),
                        title: Text('Cambiar estado'),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showAlertDialog(context, () async{
                          await userService.updateTown(this.newTownCtl.text);
                          Navigator.of(context).pop();
                        },this.newTownCtl);
                      },
                      child: ListTile(
                        leading: Icon(Icons.house_outlined, color: Colors.blue,),
                        title: Text('Cambiar municipio'),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                      ),
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
                      leading: Icon(Icons.monetization_on, color: Colors.blue,),
                      title: Text('Comprar o vender una mascota'),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
                      onTap: () async{
                        Navigator.pushNamed(context, 'marketPlace');
                      },
                    ) : Container(
                      color: Colors.blue[300],
                      child: ListTile(
                        
                        leading: Icon(Icons.monetization_on, color: Colors.white,),
                        title: Text('Comprar o vender una mascota'),
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
                    GestureDetector(
                      onTap: () {
                        _showAlertDialogText(context, 'Tinpets v1.0.0', 'Asesor: Mauro Sanchez Sanchez \nColaboradores:\nEduardo Domínguez Cordero\nAbraham Emanuel Morales Vallejo\nJaquelin Milagros Jardon Garcia\nCarlos Sanchez Montoya\nBruno Daniel Camacho Carbajal\nIssac Samuel carrillo Ortiz\nEmiliano Adolfo Nava Ceballos', () {
                          Navigator.of(context).pop();
                        });
                      },
                      child: ListTile(
                        leading: Icon(Icons.info, color: Colors.blue,),
                        title: Text('Acerca de'),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        
                        print('Eliminando usuario');
                      },
                      child: ListTile(
                          leading: Icon(Icons.delete, color: Colors.blue,),
                          title: Text('Eliminar mi cuenta'),
                          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
                      ),
                    ),
                    
                  ],
                ),
              )

              
            ],
          ),
        ),
      ),
    );
  }
  void _showAlertDialog( BuildContext context, Function accept, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text('Editando'),
          content: TextField(
            controller: controller,
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
  void _showAlertDialogAge( BuildContext context, Function accept, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text('Editando'),
          content: _createDropDown( buildcontext),
          actions: <Widget>[
            TextButton(
            child: Text("Aceptar"),
            onPressed: accept),
          ],
        );
        
      }
    );
  }

  List<DropdownMenuItem<int>> getOpcionesDropdown() {
    List<DropdownMenuItem<int>> lista = new List();
    ages.forEach((element) {
      lista.add( DropdownMenuItem(
          child: Text(element.toString()),
          value: element,
      ));  
    });
    return lista;
  }

  Widget _createDropDown(BuildContext context) {
    return Row(
      children: [
        Row(
          children: <Widget>[
            Icon(Icons.select_all),
            SizedBox(width:30.0),
            DropdownButton(
              
            value: selectedOption,
            items:getOpcionesDropdown(),
            onChanged: (opt) {
              setState(() {
                selectedOption=opt;
              });
              print(selectedOption);
            },
          )
  
          ],
        ),
        Container(
          child: Text('Edad elegida $selectedOption'),
        )
      ],
    );
}

  void _showAlertDialogText( BuildContext context, String title, String subtitle, Function accept) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
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