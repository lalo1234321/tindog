import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/get_all_sales_response.dart';
import 'package:tindog/services/user_service.dart';
import 'package:flutter/src/rendering/box.dart';



class PublicationsPage extends StatefulWidget {
  @override
  _PublicationsPageState createState() => _PublicationsPageState();
}

class _PublicationsPageState extends State<PublicationsPage> {
  UserService userService;
  @override
  Widget build(BuildContext context) {
    this.userService = Provider.of<UserService>(context);
    return Container(
      child: _listViewSales(),
    );
  }

  Widget _listViewSales( ) {
    final userService = Provider.of<UserService>(context);
    // final authService = Provider.of<AuthService>(context);
    // final socketService = Provider.of<SocketService>(context, listen: false);

    
    return FutureBuilder(
      future: userService.getAllSales(),
      builder: ( BuildContext context, AsyncSnapshot<dynamic> snapshot ) {
        if(snapshot.hasData) {
          List<Sale> sales = snapshot.data;
          // String result = snapshot.data[0].profileImageUri.replaceAll("localhost", "192.168.100.6");
          
        return (sales.length == 0) ? Center(
                  child: Text('Sin resultados'),
                
          ) :
           ListView.builder(
            itemCount:  sales.length,
            itemBuilder: (BuildContext context, int i) {
              String result = sales[i].pet.profileImageUri.replaceAll("localhost", Env.ip);
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'saleDetail',arguments: {
                    'username': sales[i].pet.username,
                    'imageprofile': sales[i].pet.profileImageUri,
                    'certificate': sales[i].pet.medicalCertificateImageUri,
                    'location':sales[i].location,
                    'ownerId': sales[i].pet.owner,
                    'stars': sales[i].pet.stars,
                    'encounters': sales[i].pet.meetingsNumber,
                    'price': sales[i].price
                  });

                },
                child: ListTile(
                  focusColor: Colors.blue[100],
                  title: Text('\$${sales[i].price}'),
                  subtitle: Text('${sales[i].pet.username}  \nEspecie: ${sales[i].pet.specie}      Raza: ${sales[i].pet.breed}'),
                  trailing: CircleAvatar(
                    backgroundImage: NetworkImage('http://'+result),
                  ),
                ),
              );
            }
          );
        } else {
          return CircularProgressIndicator();
        }

           
        }    
        );   
    //     ListView.builder(
    //     itemCount: ownedPets.length,
    //     itemBuilder: (BuildContext context, int i) {
    //       String result = ownedPets[i].profileImageUri.replaceAll("localhost", Env.ip);
    //       final authService = Provider.of<AuthService>(context);
    //       return Padding(
    //         padding: EdgeInsets.only(right: 20, left: 20,top: 370),
    //         child: Column(
    //           children: [
    //             GestureDetector(
    //               onTap: () async{
    //                 await authService.savePetName(ownedPets[i].name);
    //                 await authService.savePetId(ownedPets[i].id);
    //                 await authService.savePetUserName(ownedPets[i].username);
    //                 socketService.connect();
    //                 Navigator.pushNamed(context, 'match');
    //               },
    //               child: CircleAvatar(
    //                 radius: 65,
    //                 backgroundImage: NetworkImage('http://'+result),
                    
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Text(
    //               ownedPets[i].username,
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 20 
    //               ),
    //             )
    //           ],
    //         ),
    //       );
    //   },
    //   scrollDirection: Axis.horizontal,
      
    // );
  }
}