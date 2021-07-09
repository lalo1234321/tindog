import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/env.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/notification_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tindog/services/user_service.dart';



class PetSaleDetailPage extends StatefulWidget {
  @override
  _PetSaleDetailPageState createState() => _PetSaleDetailPageState();
}

class _PetSaleDetailPageState extends State<PetSaleDetailPage> {
  double visualStars;
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context,listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String result = arguments['imageprofile'].replaceAll("localhost", Env.ip);
    String result1 = arguments['certificate'].replaceAll("localhost", Env.ip);
    double stars = arguments['stars'];
    int meetings = arguments['encounters'];
    String idSeller = arguments['ownerId'];
    
    if(stars == 0 && meetings == 0) {
      visualStars = 0;
    } else {
      visualStars = stars/meetings;
    }
    return Scaffold(
        body: SafeArea(
          child: Column(
            
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://cdn1.vectorstock.com/i/1000x1000/24/45/beautiful-shiny-pattern-on-dark-background-vector-8722445.jpg"
                    ),
                    fit: BoxFit.cover
                  )
                ),
              child: Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(0.0,2.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'http://'+result
                    ),
                    radius: 60.0,
                  ),
                ),
              ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                arguments['username']
                ,style: TextStyle(
                  fontSize: 25.0,
                  color:Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400
              ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Se vende en: ${arguments['location']}"
                ,style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Precio: \$${arguments['price']}"
                ,style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                elevation: 2.0,
                child: _createRatingBar()
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Información"
                ,style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left:10),
                              child: Text("Emparejamientos",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600
                                ),),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(meetings.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w300
                              ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () async{
                      String message = await userService.createChatForSale( idSeller );
                      print('Estas apunto de hablar con un vendedor');
                      _showAlert(context, 'Información', message, () {
                      //   String petUserName = await AuthService.getPetUserName();
                      // print(arguments['petId']);
                      // socketService.emit('notify',{
                      //   'from': petUserName,
                      //   'to': arguments['username']
                      // });
                        Navigator.of(context).pop();
                      });
                      
                      // notificationService.petTo.id = arguments['id'];
                    },
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.blue,Colors.blue]
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 180.0,maxHeight: 40.0,),
                        alignment: Alignment.center,
                        child: Text(
                          "Hablar con el vendedor",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      print('Mostrando certificado médico');
                      _showAlertDialog(context, 'http://'+result1);
                    },
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.blue,Colors.blue]
                        ),
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                        alignment: Alignment.center,
                        child: Text(
                          "Certificado",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      );
  }

  void _showAlertDialog( BuildContext context, String certificateImageUri ) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Image.network(certificateImageUri,width: 270, height: 270, fit: BoxFit.contain,)
            ],
          ),
          actions: <Widget>[
            TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
          ],
        );
      }
    );
  }

  void _showAlert( BuildContext context, String title, String subtitle, Function accept) {
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

  Widget _createRatingBar() {
    return RatingBarIndicator(
      rating: visualStars,
      itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 50.0,
      direction: Axis.horizontal,
      );
  }
}