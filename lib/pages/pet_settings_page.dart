import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tindog/widgets/btn_azul.dart';
import 'package:tindog/widgets/custom_input.dart';



class PetSettingsPage extends StatefulWidget {
  @override
  _PetSettingsPageState createState() => _PetSettingsPageState();
}

class _PetSettingsPageState extends State<PetSettingsPage> {
  bool _picked = false;
  bool _picked1 = false;
  File imageFile, imageFile2;
  List<int> ages = [1,2,3,4,5,6,7,8,9,10,11,12,13];
  int selectedOptionAge = 1;
  List _cities =
  ["Nombre", "Edad", "Foto de perfil", "Foto de certificado médico"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  @override
  void initState() { 
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
    
  }
  String _currentCity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar datos de la máscota'),
      ),
      body: Column(
        children:[
          Container(
            padding: EdgeInsets.only(left: 30, top: 40),
            child: DropdownButton(
                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              ),
          ),
          SizedBox(height: 100,),
          selectedOption()
        ]
      )
            
      // Center(
      //   child: Column(
      //     children: <Widget>[
      //       SizedBox(height: 30,),
      //       CustomInput(
      //         hintText: 'Modificar nombre de la mascota',
      //         prefixIconData: Icons.pets,
      //         sufixIconData: Icons.pest_control_rounded,
      //         obscureText: false,
      //       ),
      //       SizedBox(height: 20),
      //       BtnAzul(texto: 'Guardar cambios', onPressed: () {
      //         print('Guardar cambios');
      //       })
      //     ],
      //   )
      // ),
    );
    
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }
  void changedDropDownItem(String selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity = selectedCity;
    });
  }
  Widget selectedOption() {
    switch(_currentCity) {
      case 'Nombre': {
        return Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            CustomInput(
              hintText: 'Modificar nombre de la mascota',
              prefixIconData: Icons.pets,
              sufixIconData: Icons.pest_control_rounded,
              obscureText: false,
            ),
            SizedBox(height: 20),
            BtnAzul(texto: 'Guardar cambios', onPressed: () {
              print('Guardar cambios');
            })
          ],
        )
      );
      
      }
      break;
      case 'Edad': {
        return _createDropDown();
      } 
      break;
      case 'Foto de perfil': {
        return  _cargarImagen();
      }
      break;

      case 'Foto de certificado médico': {
        return _cargarImagen2();
      }
      break;

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
    return Center(
      
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 70),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.select_all),
                    SizedBox(width:30.0),
                    DropdownButton(
                    value: selectedOptionAge,
                    items:getOpcionesDropdown(),
                    onChanged: (opt) {
                      setState(() {
                        selectedOptionAge=opt;
                      });
                    },
                  )
  
                  ],
                ),
              ),
              Container(
                child: Text('Ingrese la edad de la mascota'),
              )
            ],
          ),
          SizedBox(height: 30,),
          BtnAzul(texto: 'Guardar cambios', onPressed: () {
            print('Guardando edad ${selectedOptionAge}');
          })
        ],
      ),
    );
}
  Widget _cargarImagen(){
  return Center(
    child: Column(
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
            : NetworkImage('https://extyseg.com/wp-content/uploads/2019/04/EXTYSEG-imagen-no-disponible.jpg'),
            radius: 70,
          ),
        ),
      ),
      BtnAzul(texto: 'Guardar cambios', onPressed: () {
        print('Imagen de perfil');
      })
     ],
    ),
  );
 }
  Widget _cargarImagen2(){
  return Center(
    child: Column(
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
            : NetworkImage('https://extyseg.com/wp-content/uploads/2019/04/EXTYSEG-imagen-no-disponible.jpg'),
            radius: 70,
          ),
        ),
      ),
      BtnAzul(texto: 'Guardar cambios', onPressed: () {
        print('Guardando imagen de certificado médico');
      })
     ],
    ),
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

}