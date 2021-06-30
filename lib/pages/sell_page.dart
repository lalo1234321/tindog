import 'package:flutter/material.dart';


class SellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Center(child: 
        Text('Elige una mascota para vender', style: TextStyle(fontSize: 20),),
        ),
        SizedBox(height: 30,),
        Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Row(
                children: [
                  CircleAvatar(
              backgroundImage: NetworkImage('http://c.files.bbci.co.uk/48DD/production/_107435681_perro1.jpg'),
            ),
            SizedBox(width: 40,),
            CircleAvatar(
              backgroundImage: NetworkImage('http://c.files.bbci.co.uk/48DD/production/_107435681_perro1.jpg'),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('http://c.files.bbci.co.uk/48DD/production/_107435681_perro1.jpg'),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('http://c.files.bbci.co.uk/48DD/production/_107435681_perro1.jpg'),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('http://c.files.bbci.co.uk/48DD/production/_107435681_perro1.jpg'),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('http://c.files.bbci.co.uk/48DD/production/_107435681_perro1.jpg'),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('http://c.files.bbci.co.uk/48DD/production/_107435681_perro1.jpg'),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('http://c.files.bbci.co.uk/48DD/production/_107435681_perro1.jpg'),
            ),
                ],
              ),
            ),
            
          ],
        )
      ],
    );
  }
}

