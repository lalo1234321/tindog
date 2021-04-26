import 'package:flutter/material.dart';
enum SingingCharacter { macho, hembra }
 
 class RegistroMascota extends StatefulWidget{
  @override
  _InputState createState() => _InputState();
   
 }

 class _InputState extends State<RegistroMascota>{
  SingingCharacter _character = SingingCharacter.macho;
  String _nombre ='';
  String _edad = '';
  List<String> _especie = ['Perro', 'Gato', 'Roedor', 'Otro'];
  List<String> _razaPerro = ['Pitbull', 'Labrador', 'San Bernardo', 'Otro'];
  List<String> _razaGato = [ 'Bengala','Siamés','Persa','Otro'];
  List<String> _razaRoedor = [ '','Otro'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro  De Mascota'),
        backgroundColor: Colors.cyan,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical:20),
        children: [
          _CargarImagen(),
          SizedBox(height: 10),
          _crearNombreMascota(),
          _Genero(),
          SizedBox(height: 10),
          _Edad(),

          
        ],
      ),
    );
  }

 Widget _CargarImagen(){
  return Column(
    children: [
     Padding(
      padding: EdgeInsets.all(20),
      child: CircleAvatar(
        backgroundImage: NetworkImage('https://cdn.generadormemes.com/media/templates/xperrito_ofrecele_algo_a_las_visitas.jpg.pagespeed.ic.plantilla-memes.jpg'),
        radius: 70,
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
          color: Colors.red,
        ),
        icon: Icon(Icons.pets),
        hintText: 'Escribe el nombre de tu mascota',
        labelText: 'Nombre De Tu Mascota',
      ),
      onChanged: (valor){
        setState((){
          _nombre = valor;
        });
      },
    );
  }

  Widget _Genero(){
     return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Macho'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.macho,
            groupValue: _character,
            onChanged: (SingingCharacter value){
              _character = value;
            },
          ),
        ),
        ListTile(
          title: const Text('Hembra'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.hembra,
            groupValue: _character,
            onChanged: (SingingCharacter value){
              _character = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _Edad(){
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        suffixIcon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        icon: Icon(Icons.emoji_nature),
        hintText: 'Escribe la edad de tu mascota',
        labelText: 'Edad de tu Mascota',
      ),
      onChanged: (valor) {
        setState(() {
          _edad = valor;
        });
      },
    );
  }

 }