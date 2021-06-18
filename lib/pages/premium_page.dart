
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:slimy_card/slimy_card.dart';

class PremiumPage extends StatefulWidget {
  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        automaticallyImplyLeading: false,
        title: Text("Planes de pago"),
      ),
      body: StreamBuilder(
        initialData: false,
        stream: slimyCard.stream,
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 70),
              SlimyCard(
                color: Colors.indigo[300],
                topCardWidget: topCardWidget((snapshot.data)
                    ? 'assets/img/pets.jpg'
                    : 'assets/img/pets1.jpg'),
                bottomCardWidget: bottomCardWidget(),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: _getFAB(),
    );
  }

  Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage(imagePath)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Plan Mensual \$10 /mes',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 15),
        Center(
          child: Text(
            'Con esta suscripción podrás registrar mascotas, realizar compras y ventas de mascotas'
                ' \nPresiona para adquirir este plan',
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget bottomCardWidget() {
    return Column(
      children: [
        Text(
          'Plan anual \$50 /anualmente',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Expanded(
          child: Text(
            'Obtendrás todos los beneficios del plan mensual pero tu suscrición '
                'durará un año '
            ,    
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
  Widget _getFAB() {
        return SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22),
          backgroundColor: Colors.indigo[300],
          visible: true,
          curve: Curves.bounceIn,
          children: [
                // FAB 1
                SpeedDialChild(
                child: Icon(Icons.assignment_turned_in),
                backgroundColor: Colors.indigo[300],
                onTap: () { 
                  Navigator.pushNamed(context, 'payment', arguments: {
                    'plan':1
                  });
                },
                label: 'Comprar suscripción mensual',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.indigo[300]),
                // FAB 2
                SpeedDialChild(
                child: Icon(Icons.assignment_turned_in),
                backgroundColor: Colors.indigo[300],
                onTap: () {
                  Navigator.pushNamed(context, 'payment',arguments: {
                    'plan':2
                  });
                  setState(() {
                    _counter = 0;
                  });
                },
                label: 'Comprar suscripción anual',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.indigo[300])
          ],
        );
  }
}


// import 'package:flutter/material.dart';
// import 'package:slimy_card/slimy_card.dart';


// class PremiumPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       // body: Row(
//       //   children: [
//       //     _mensualPlan()
//       //   ],
//       // )
//     );
//   }

//   Widget _mensualPlan() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, top: 30,bottom: 200),
      
//       child: Container(
//         margin:EdgeInsets.only(left: 10,right: 50), 
//         decoration: BoxDecoration(
//           color: Colors.deepPurpleAccent,
//           borderRadius: BorderRadius.circular(20)
//         ),
//         //color: Colors.deepPurpleAccent,
//         child: Container(
//         //  margin: EdgeInsets.only(left: 10,right: 30),
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(right: 200),
//                 child: Text(
//                   'Mensual', 
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.only(right: 150),
//                 child: Row(
//                   children: [
//                     Text(
//                       '\$99', 
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 50
//                       ),
//                     ),
//                     Text(
//                       ' /mes', 
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 30
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Padding(
//                 padding: const EdgeInsets.only(right: 50),
//                 child: Text(
//                   'Al contratar este plan obtendrás \nacceso a los siguientes beneficios', 
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                     color: Colors.white54,
//                     fontSize: 18
//                   ),
//                 ),
//               ),
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _listTile(String text) {
//     return ListTile(
//       title: Text(text),
//       trailing: Icon(Icons.check),
//     );
//   }

//   Widget slimmy() {
//     return StreamBuilder(
//   initialData: false,
//   stream: slimyCard.stream,
//   builder: ((BuildContext context, AsyncSnapshot snapshot) {
//     return ListView(
//       padding: EdgeInsets.zero,
//       children: <Widget>[
//         SizedBox(height: 70),
//         SlimyCard(
//           color: Colors.indigo[300],
//           topCardWidget: topCardWidget((snapshot.data)
//               ? 'assets/images/devs.jpg'
//               : 'assets/images/flutter.png'),
//           bottomCardWidget: bottomCardWidget(),
//         ),
//       ],
//     );
//   }),
//   );
//   }
//   Widget topCardWidget(String imagePath) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       Container(
//         height: 70,
//         width: 70,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           image: DecorationImage(image: AssetImage(imagePath)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 20,
//               spreadRadius: 1,
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 15),
//       Text(
//         'Flutter',
//         style: TextStyle(color: Colors.white, fontSize: 20),
//       ),
//       SizedBox(height: 15),
//       Center(
//         child: Text(
//           'Flutter is Google’s UI toolkit for building beautiful, natively compiled applications'
//               ' for mobile, web, and desktop from a single codebase.',
//           style: TextStyle(
//               color: Colors.white.withOpacity(0.8),
//               fontSize: 12,
//               fontWeight: FontWeight.w500),
//           textAlign: TextAlign.center,
//         ),
//       ),
//       SizedBox(height: 10),
//     ],
//   );
// }
// Widget bottomCardWidget() {
//   return Column(
//     children: [
//       Text(
//         'https://flutterdevs.com/',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//         ),
//         textAlign: TextAlign.center,
//       ),
//       SizedBox(height: 15),
//       Expanded(
//         child: Text(
//           'FlutterDevs specializes in creating cost-effective and efficient '
//               'applications with our perfectly crafted,creative and leading-edge '
//               'flutter app development solutions for customers all around the globe.',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     ],
//   );
// }

// }