import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/owned_pets_response.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/services/user_service.dart';
import 'package:tindog/widgets/btn.dart';
import 'package:tindog/widgets/btn_azul.dart';
import 'package:tindog/widgets/custom_input.dart';


class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  Text hintText = Text('Ingrese la cantidad', style: TextStyle(color: Colors.blue),);
  String userNameSelected = '';
  TextEditingController priceCtl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    priceCtl.text = '';
    return Stack(
        children: <Widget>[
          _fondoApp(),
          Padding(
            padding: EdgeInsets.only(left: 74,top:10),
            child: Text(
              'Selecciona la mascota que venderás',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 40,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
          
          
  
          
            // SingleChildScrollView(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       SizedBox(height: 540,),
            //       TextField(
            //         keyboardType: TextInputType.number,
            //         style: TextStyle(
                      
            //           color: Colors.blue
            //         ),
            //         decoration: InputDecoration(
                      
            //           hintText: 'Ingrese cantidad',
            //           prefixIcon: Icon(
            //             Icons.monetization_on,
            //             size:18,
            //             color: Colors.blue
            //           ),
            //           enabledBorder: UnderlineInputBorder(
            //             borderRadius: BorderRadius.circular(10),
            //             borderSide: BorderSide.none
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10),
            //             borderSide: BorderSide(color: Colors.blue)
            //           ),
            //           suffixIcon: GestureDetector(
            //             onTap: () {
            //               print('Yeah');
            //             },
            //             child: Icon(
            //               Icons.keyboard_arrow_right,
            //               size: 18,
            //               color: Colors.blue,
            //             ),
            //           ),
            //           labelStyle: TextStyle(color: Colors.white)
            //           ),
          
            //           obscureText: false,
            //           controller: this.priceCtl,
            //         ),
            //         SizedBox(height: 30,),
            //         BtnAzul(texto: 'Registrar venta', onPressed: () {
            //           print('Mascota seleccionada $userNameSelected');
            //           print('Precio establecido: ${priceCtl.text}');
            //         }),
            //       ],
            //     ),
            // ),
            _listViewPets(),
            
        ],
      );
  }


  Widget _listViewPets( ) {
    final userService = Provider.of<UserService>(context);
    final authService = Provider.of<AuthService>(context);

    
    return FutureBuilder(
      future: userService.ownedPets(),
      builder: ( BuildContext context, AsyncSnapshot<dynamic> snapshot ) {
        if(snapshot.hasData) {
          List<OwnedPet> ownedPets = snapshot.data;
          
          // String result = snapshot.data[0].profileImageUri.replaceAll("localhost", "192.168.100.6");
          
        return (ownedPets.length == 0) ? Padding(
            padding: EdgeInsets.only(right: 20, left: 20,top: 200),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async{
                    print('Invitado');
                  },
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage('https://image.shutterstock.com/image-vector/avatar-man-icon-profile-placeholder-260nw-1229859850.jpg'),
                    
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Invitado',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20 
                  ),
                )
              ],
            ),
          ) :
        
        ListView.builder(
        itemCount: ownedPets.length,
        itemBuilder: (BuildContext context, int i) {
          String result = ownedPets[i].profileImageUri.replaceAll("localhost", Env.ip);
          final authService = Provider.of<AuthService>(context);
          return Padding(
            padding: EdgeInsets.only(right: 20, left: 20,top: 200),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async{
                    userNameSelected = ownedPets[i].username;
                    
                    print('presionaste ${ownedPets[i].username}');
                    print('precio : ${priceCtl.text}');
                    
                      _showAlertDialog(context, () async{
                      if(priceCtl.text == '') {
                      _showAlertDialogText(context, 'Error', 'Profavor ingrese una cantidad para vender', (){
                        Navigator.of(context).pop();
                        // return;
                      });
                     }
                     else { 
                       String message = await userService.sellAPet(ownedPets[i].username, priceCtl.text);
                      Navigator.of(context).pop();
                      _showAlertDialogText(context, 'Importante', message, () {
                        priceCtl.text = '0';
                        Navigator.of(context).pop();
                      });
                     } 
                      
                    }, priceCtl);
                    
                    
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('http://'+result),
                    
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  ownedPets[i].username,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20 
                  ),
                )
              ],
            ),
          );
      },
      scrollDirection: Axis.horizontal,
      
    );
          
          // return Center(
          //   child: CircleAvatar(
          //     radius: 65,
          //     backgroundImage: NetworkImage('http://'+result),
              
          //   ),
          // );
        } else {
          return Container(
            height: 900,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
       // String result = snapshot.data[0].profileImageUri.replaceAll("localhost", "192.168.100.6");
        // snapshot.data[0].profileImageUri = result;
        
        //print(snapshot.data[0].profileImageUri);
        //print(snapshot.data[0].profileImageUri);
        //print(result);
        // return Center(
        //   child: Text('Extracting info'),
        // );
      },
    );
    // return ListView.builder(
    //   itemCount: pets.length,
    //   itemBuilder: (BuildContext context, int i) {
    //     final authService = Provider.of<AuthService>(context);
    //     return Padding(
    //       padding: EdgeInsets.only(right: 20, left: 20,top: 370),
    //       child: Column(
    //         children: [
    //           GestureDetector(
    //             onTap: () async{
    //               await authService.savePetName(pets[i].name);
    //               Navigator.pushNamed(context, 'match');
    //             },
    //             child: CircleAvatar(
    //               radius: 65,
    //               backgroundImage: NetworkImage(pets[i].image),
                  
    //             ),
    //           ),
    //           SizedBox(height: 10,),
    //           Text(
    //             pets[i].name,
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 20 
    //             ),
    //           )
    //         ],
    //       ),
    //     );
    //   },
    //   scrollDirection: Axis.horizontal,
      
    // );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          //Para que el gradiente sea vertical se omiten las constantes 
          //begin y end
          begin:FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Colors.white,
            Colors.white
          ],
        ),
      ),
    );
  //Positioned nos ayuda a posicionar un widget con coordenadas específicas
    return Stack(
      children: [
        gradiente
      ],
    );
  }
  void _showAlertDialog( BuildContext context, Function accept, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text('Editando'),
          content: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      
                      color: Colors.blue
                    ),
                    decoration: InputDecoration(
                      
                      hintText: 'Ingrese cantidad',
                      prefixIcon: Icon(
                        Icons.monetization_on,
                        size:18,
                        color: Colors.blue
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue)
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          print('Yeah');
                        },
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: 18,
                          color: Colors.blue,
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.white)
                      ),
          
                      obscureText: false,
                      controller: this.priceCtl,
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

