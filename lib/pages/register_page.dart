import 'package:tindog/helpers/home_view.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/widgets/btn.dart';

import 'package:flutter/material.dart';
import 'package:tindog/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
final firstNameCtl= TextEditingController();

final lastNameCtl = TextEditingController();

final userNameCtl = TextEditingController();

final emailCtl= TextEditingController();

final passwordCtl= TextEditingController();

final ageCtl= TextEditingController();

final stateCtl= TextEditingController();

final townCtl= TextEditingController();

TextEditingController _inputFieldDateController = new TextEditingController(); 

List<int> ages = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50];

String _date = '';

int selectedOption = 1;

  @override
  Widget build(BuildContext context) {  
    final model = Provider.of<HomeView>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(title: Text('Registrar'),),
        body: SingleChildScrollView(
          child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CustomInput(
                    hintText: 'Nombre',
                    obscureText: false,
                    prefixIconData: Icons.account_circle,
                    textController: firstNameCtl
                  ),
                  SizedBox(height: 5,),
                  CustomInput(
                    hintText: 'Apellidos',
                    obscureText: false,
                    prefixIconData: Icons.account_circle,
                    textController: lastNameCtl,
                  ),
                  SizedBox(height: 5,),
                  CustomInput(
                    hintText: 'Nombre de usuario',
                    obscureText: false,
                    prefixIconData: Icons.account_circle,
                    textController: userNameCtl,
                  ),
                  SizedBox(height: 5,),
                  CustomInput(
                    hintText: 'Correo',
                    obscureText: false,
                    prefixIconData: Icons.email,
                    textController: emailCtl,
                  ),
                  SizedBox(height: 5,),
                  CustomInput(
                    hintText: 'Contraseña',
                    obscureText: model.isVisible ? true : false,
                    prefixIconData: Icons.lock_outline,
                    sufixIconData: model.isVisible ? Icons.visibility : Icons.visibility_off ,
                    textController: passwordCtl,
                  ),
                  SizedBox(height: 5,),
                  _createDate(context),
                  SizedBox(height: 5,),
                  CustomInput(
                    hintText: 'Estado',
                    obscureText: false,
                    prefixIconData: Icons.location_on,
                    textController: stateCtl,
                  ),
                  SizedBox(height: 5,),
                  CustomInput(
                    hintText: 'Municipio',
                    obscureText: false,
                    prefixIconData: Icons.home_work_outlined,
                    textController: townCtl,
                  ),
                  SizedBox(height: 25,),
                  Btn(
                    title: 'Registrarse',
                  hasBorder: true,
                  onChanged: authService.autenticando ? null :
                    () async{
                      // print('email ${emailCtl.text}\npassword ${passCtl.text}' );
                      final registerOk = await authService.register(
                        firstNameCtl.text,
                        lastNameCtl.text,
                        userNameCtl.text,
                        emailCtl.text,
                        passwordCtl.text,
                        _inputFieldDateController.text,
                        stateCtl.text,
                        townCtl.text

                            );
                      String message = "Favor de verificar tu correo";
                      if( registerOk == true ) {
                        //TODO mostrar alertas en caso de que falle el login
                        //socketServide.connect();
                        _showAlertDialog(context,'Gracias por registrarse', message, () {
                          Navigator.pushReplacementNamed(context, 'login');
                        });

                      } else {
                        _showAlertDialog(context,'Error', registerOk.toString(), () {
                          Navigator.of(context).pop();
                        });
                      }
                      
                    },
            ),
          ],
        ),
            ),
          ],
        )
        )
    );    
  }

  void _showAlertDialog( BuildContext context, String title, String subtitle, Function accept) {
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

  Widget _createDropDown() {
    return Row(
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
        },
      )
  
      ],
    );
    
    
    
}
   Widget _createDate(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ), 
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        suffixIcon: Icon(
          Icons.calendar_today,
          color: Colors.blue,
        ),
        icon: Icon(Icons.call_to_action),
      ),
      onTap: (){
        FocusScope.of(context).requestFocus( new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async{
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime(1980), 
      firstDate: new DateTime(1980), 
      lastDate: new DateTime(2021),
    );
    if(picked != null){
      final now = DateTime.now();
      Duration duration = now.difference(picked);
      
      setState(() {
        _date = duration.inDays.toString();
        int days = int.parse(_date);
        double years = days/365;
        print( years.round() );
        _inputFieldDateController.text = years.round().toString();
      });
      
    }
  }

}

