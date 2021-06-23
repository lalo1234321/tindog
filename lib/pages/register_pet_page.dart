
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tindog/services/user_service.dart';
import 'package:tindog/widgets/btn_azul.dart';
import 'package:tindog/widgets/wave_widget.dart';
enum SingingCharacter { macho, hembra }
 
 class RegisterPet extends StatefulWidget{
  @override
  _InputState createState() => _InputState();
   
 }

 class _InputState extends State<RegisterPet>{
  File imageFile, imageFile2;
  SingingCharacter _gender = SingingCharacter.macho;
  String _namePet =  '';
  String _especiepet = '';
  String _breed = '';
  String _userName = '';
  bool _picked = false;
  bool _picked1 = false;
  List<int> ages = [1,2,3,4,5,6,7,8,9,10,11,12,13];
  int selectedOption = 1;
  UserService userService;
  List<String> _vregist= [];
  List<Widget> _widgetvacunas =[];
  String _vacunaf='';
  int _i = 0;
  @override
  Widget build(BuildContext context) {
    this.userService = Provider.of<UserService>(context, listen: false);
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
                  'Registro Mascota',
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
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 150),
                _cargarImagen(),
                SizedBox(height: 25),
                _userNameInput(),
                SizedBox(height: 25),
                _crearNombreMascota(),
                SizedBox(height: 25),
                _genero(),
                SizedBox(height: 25),
                _especie(),
                SizedBox(height: 25),
                _breedInput(),
                SizedBox(height: 25),
                _createDropDown(),
                SizedBox(height: 25),
                ElevatedButton(onPressed: (){
                  _getFromGallery2();
                  _picked1 = true;
                }, 
                child: Text('Elije la foto del certificado médico')),
                SizedBox(height: 25),
                _vacunas(context),
                SizedBox(height: 25),
                _btnEnviar(),
                SizedBox(height: 25),

               ],
             ),
             )
           ),
         ],
       ),
     );
  }


 Widget _cargarImagen(){
  return Column(
    children: [
     Padding(
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          _getFromGallery();
          // print(imageFile.path);
          _picked = true;
        },
        child: CircleAvatar(
          backgroundImage:(_picked) ? FileImage(File(imageFile.path))
          : NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png'),
          radius: 70,
        ),
      ),
    )
   ],
  );
 }

 Widget _crearNombreMascota(){
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        suffixIcon: Icon(
          Icons.pets,
          color: Colors.blue,
        ),
        icon: Icon(Icons.pets),
        hintText: 'Escribe el nombre de tu mascota',
        labelText: 'Nombre De Tu Mascota',
      ),
      onChanged: (valor){
        setState((){
          _namePet  = valor;
        });
      },
    );
  }

  Widget _userNameInput(){
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        suffixIcon: Icon(
          Icons.pets,
          color: Colors.blue,
        ),
        icon: Icon(Icons.pets),
        hintText: 'Escribe el nombre de usuario de tu mascota',
        labelText: 'Nombre de usuario De Tu Mascota',
      ),
      onChanged: (valor){
        setState((){
          _userName  = valor;
        });
      },
    );
  }

  Widget _genero(){
     return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Macho'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.macho,
            groupValue: _gender,
            onChanged: (SingingCharacter value){
              setState(() {
                _gender = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Hembra'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.hembra,
            groupValue: _gender,
            onChanged: (SingingCharacter value){
              setState(() {
                  _gender = value;            
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _especie(){
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        suffixIcon: Icon(
          Icons.pets,
          color: Colors.blue,
        ),
        icon: Icon(Icons.pets),
        hintText: 'Puede ser Perro, Gato, etc.',
        labelText: 'Especie De Tu Mascota',
      ),
      onChanged: (valor){
        setState((){
          _especiepet = valor;
        });
      },
    );
  }

  Widget _breedInput(){
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        suffixIcon: Icon(
          Icons.pets,
          color: Colors.blue,
        ),
        icon: Icon(Icons.pets),
        hintText: 'Ingrese la raza de la mascota',
        labelText: 'Raza De Tu Mascota',
      ),
      onChanged: (valor){
        setState((){
          _breed = valor;
        });
      },
    );
  }

  void agregar(){
    setState(() {
          _widgetvacunas.add(SizedBox(height: 20),);
          _widgetvacunas.add(_textFvacuna());
        });
  }

  void quitar(){
    setState(() {
          _widgetvacunas.removeLast();
          _widgetvacunas.removeLast();
          _vregist.removeLast();
    });
  }

  Widget _textFvacuna(){
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        suffixIcon: Icon(
          Icons.healing,
          color: Colors.blue,
        ),
        icon: Icon(Icons.pets),
        hintText: 'Escribe la vacuna de tu mascota',
        labelText: 'Vacuna de Tu Mascota',
      ),
      onChanged: (valor){
        setState((){
          _vacunaf=valor;
        });
        _vregist.add(_vacunaf);
      },
    );
  }

  Widget _vacunas(BuildContext context){
    return Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(onPressed: (){
                if(_i<5){
                  agregar();
                  _i++;
                  }else{
                   _showAlertDialog(context,"No permitido","No se puede agregar mas de 5 vacunas",() {
                          Navigator.of(context).pop();
                        });
                  }
              },icon: Icon(Icons.add),label: Text("Agregar Vacuna"),),
              FlatButton.icon(onPressed: (){
                if(_i>0){
                  _i--;
                  quitar();
                }else{
                  _showAlertDialog(context,"Error","No se pueden quitar mas vacunas",() {
                          Navigator.of(context).pop();
                        });
                }
              },icon: Icon(Icons.remove),label: Text("Quitar"),),
            ],
          ),
          Column(
            children: _widgetvacunas,
          ),
        ],
    );
  }

  Widget _btnEnviar(){
     return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: BtnAzul(texto: "Enviar", onPressed: (userService.autenticando) ? null :() async{
        if(!_picked||!_picked1) {
          _showAlertDialog(context, 'Error', 'No has seleccionado la imágen de perfil o el certificado médico', () {
            Navigator.of(context).pop();

          });
        }
        String realGender;
        String realAge = selectedOption.toString();
      if(_gender == SingingCharacter.hembra) {
        realGender = 'F';
      } else {
        realGender = 'M';
      }
      print(imageFile.path);
      print(imageFile2.path);
      print(realGender);
      print(_namePet);
      print(_especiepet);
      print(_breed);
      print(_userName);
      print(realAge);
      final response = await userService.registerPet(_userName, _namePet, realAge, _especiepet, _breed, imageFile, imageFile2, realGender,_vregist);
      if(response == false) {
        _showAlertDialog(context, 'Error', 'No se han enviado correctamemte los datos', () {
          Navigator.of(context).pop();
        });
      } else {
        _showAlertDialog(context, 'Mascota registrada con éxito', 'Ya puedes usar tu mascota para interactuar con otras mascotas',() {
          Navigator.pushReplacementNamed(context, 'profile');

        });

      }
      }),
     );

  }

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  _getFromGallery2() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile2 = File(pickedFile.path);
      });
    }
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
            },
          )
  
          ],
        ),
        Container(
          child: Text('   Ingrese la edad de la mascota'),
        )
      ],
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

 }