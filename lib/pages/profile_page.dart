import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/owned_pets_response.dart';
import 'package:tindog/models/pet.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/services/user_service.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  String token = "";  
  // final List<Pet> pets = [
  //   Pet('Osqui', 21, 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2016/05/19091354/Weimaraner-puppy-outdoors-with-bright-blue-eyes.20190813165758508-1.jpg'),
  //   Pet('Daniel', 18,'https://i.guim.co.uk/img/media/20098ae982d6b3ba4d70ede3ef9b8f79ab1205ce/0_0_969_1005/master/969.jpg?width=700&quality=85&auto=format&fit=max&s=470657ebd2a0e704df88997d393aea15'),
  //   Pet('Gato201', 12, 'https://www.redaccionmedica.com/images/destacados/coronavirus-gatos-perros-anticuerpos-reinfeccion-vacuna-covid--2116.jpg'),
  //   Pet('Invitado', 12, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTugu0kegXOT1Gh1sgDVHvYjkGW29w19Hl9gQ&usqp=CAU'),
  // ]; 
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    // final socketService = Provider.of<SocketService>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          Padding(
            padding: EdgeInsets.only(left: 74,top:200),
            child: Text(
              'Elije un perfil ${AuthService.user.firstName}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
          
          _listViewPets()
        ],
      )
    );
    
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
            Color.fromRGBO(52, 130, 200, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
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

  Widget _listViewPets( ) {
    final userService = Provider.of<UserService>(context);
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context, listen: false);

    
    return FutureBuilder(
      future: userService.ownedPets(),
      builder: ( BuildContext context, AsyncSnapshot<dynamic> snapshot ) {
        if(snapshot.hasData) {
          List<OwnedPet> ownedPets = snapshot.data;
          // String result = snapshot.data[0].profileImageUri.replaceAll("localhost", "192.168.100.6");
          
        return (ownedPets.length == 0) ? Padding(
            padding: EdgeInsets.only(right: 20, left: 20,top: 370),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async{
                    await authService.savePetName('Invitado');
                    Navigator.pushNamed(context, 'match');
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
            padding: EdgeInsets.only(right: 20, left: 20,top: 370),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async{
                    await authService.savePetName(ownedPets[i].name);
                    await authService.savePetId(ownedPets[i].id);
                    await authService.savePetUserName(ownedPets[i].username);
                    socketService.connect();
                    Navigator.pushNamed(context, 'match');
                  },
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage('http://'+result),
                    
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  ownedPets[i].username,
                  style: TextStyle(
                    color: Colors.white,
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
}