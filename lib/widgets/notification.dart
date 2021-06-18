import 'package:flutter/material.dart';



class Notify extends StatelessWidget {
  final String from;

  const Notify({Key key, this.from}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
    
    // Con esta propiedad modificamos la forma de nuestro card
    // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    
    // Con esta propiedad agregamos margen a nuestro Card
    // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
    margin: EdgeInsets.all(15),
    
    // Con esta propiedad agregamos elevación a nuestro card
    // La sombra que tiene el Card aumentará
    elevation: 10,

    // La propiedad child anida un widget en su interior
    // Usamos columna para ordenar un ListTile y una fila con botones
    child: Column(
      children: <Widget>[

        // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: Text('Solicitud de emparejamiento'),
          subtitle: Text(
              '$from quiere hablar contigo!!!'),
          leading: Icon(Icons.network_locked),
        ),
        
        // Usamos una fila para ordenar los botones del card
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(onPressed: () => {}, child: Icon(Icons.mark_chat_read)),
            TextButton(onPressed: () => {}, child: Icon(Icons.not_interested, color: Colors.red,))
          ],
        )
      ],
    ),
  );
  }
}