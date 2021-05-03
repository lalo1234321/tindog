import 'package:flutter/material.dart';
import 'package:tindog/widgets/wave_widget.dart';
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
    final size = MediaQuery.of(context).size;
    // para saber si el keyboard está abierto
    final bool keyBoardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    
    return Scaffold(
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
              yOffset: size.height / 5.0,
              color: Colors.white
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20 ),
            child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
              SizedBox(height: 40),
              _Titulo(),
              _CargarImagen(),
              SizedBox(height: 10),
              _crearNombreMascota(),
              _Genero(),
              SizedBox(height: 10),
              _Edad(),
              ],
            ),
            )
          ),
          /*_CargarImagen(),
          SizedBox(height: 10),
          _crearNombreMascota(),
          _Genero(),
          SizedBox(height: 10),
          _Edad(),*/

          
        ],
      ),
    );
  }

Widget _Titulo(){
  return Text(
    'Registro Mascota',
      style: TextStyle(
         color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w900
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