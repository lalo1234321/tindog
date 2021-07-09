import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/get_all_sales_response.dart';
import 'package:tindog/pages/chats_market_page.dart';
import 'package:tindog/pages/publications_page.dart';
import 'package:tindog/pages/sell_page.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/user_service.dart';


class MarketPlace extends StatefulWidget {
  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  List<String> ages = ['Especie'];
  List<String> breeds = ['Raza'];
  String selectedOption2 = 'Raza';
  String selectedOption = 'Especie';
  int page = 0;
  UserService userService;
  @override
  void initState() { 
    super.initState();
    this.userService = Provider.of<UserService>(context, listen: false);
    // breeds.removeRange(0, breeds.length);
    loadingSpecies();
  }
  void loadingSpecies() async{
    
    List<String> speciesInApp = await this.userService.getAllSpecies();
    if(mounted) {
      setState(() {
        ages.insertAll(0, speciesInApp);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    print('El id de la sesión actual es ${AuthService.user.id}');
    // if( page == 0 ) {
      
    // }
    return Scaffold(
      appBar:  (page ==0 ) ? AppBar(
        actions: <Widget>[
          _createDropDown2(),
          _createDropDown(),
          

        ],
      ) : AppBar(
        title:Text('Compra y venta'),
      ),
      body: Center(
        child: _selectPage()
      ),
      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        //CAmbiar el color de el navigationBar
        canvasColor: Color.fromRGBO(0, 160, 255, 1.0),
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme
                  .copyWith(caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0))) 
      ),
      child: BottomNavigationBar(
        currentIndex: page,
        onTap: (int index) {
          setState(() {
            this.page = index;
          });
          // Navigator.pushNamed(context, 'chats');
        },
        items: [
          
          BottomNavigationBarItem(
            icon: Icon(Icons.pets_outlined,size: 30.0,),
            label: 'Comprar Mascotas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on,size: 30.0,),
            label: 'Vender Mascotas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,size: 30.0,),
            label: 'Chatear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,size: 30.0,),
            label: 'Ventas por filtro',
          ),
        ],
      ),
    );
  }

  Widget _selectPage() {
    switch(page) {
      case 0: {
        return PublicationsPage();
      }
      // break;
      case 1: {
        return SellPage();
      }
      break;
      // case 2: {
      //   return NotificationsPage();
      // }
      // break;
      // case 3: {
      //   return SettingsPage();
      // }
      case 2: {
        return ChatsMarketPage();
      }
      case 3: {
        return Container(
          child: _listViewSales(),
        );
      }
      break;
    }
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
      
    ages.forEach((element) {
      lista.add( DropdownMenuItem(
          child: Text(element.toString()),
          value: element,
      ));  
    });
    return lista;
  }

   List<DropdownMenuItem<String>> getOpcionesDropdown2() {
    List<DropdownMenuItem<String>> lista = new List();
    breeds.forEach((element) {
      lista.add( DropdownMenuItem(
          child: Text(element.toString()),
          value: element,
      ));  
    });
    return lista;
  }

  Widget _createDropDown() {
    return Row(
      children: [
        Row(
          children: <Widget>[
            
            SizedBox(width:30.0),
            DropdownButton(
              iconEnabledColor: Colors.white,
            value: selectedOption,
            items:getOpcionesDropdown(),
            onChanged: (opt) async{
              selectedOption=opt;
              print(selectedOption);
              setState(() {
                this.breeds = ['Raza'];
                selectedOption2 = 'Raza';
                // selectedOption = 'Especie';
              });
              List<String> extractingInfo = await this.userService.getAllBreedsBySpeciePet(selectedOption);
              print(extractingInfo);
              this.breeds.insertAll(0, extractingInfo);
              setState(() {
                
              });
              
            },
          )
  
          ],
        ),
        Container(
          child: Text('Filtros'),
        )
      ],
    );
}

    Widget _createDropDown2() {
    return Row(
      children: [
        Row(
          children: <Widget>[
            
            SizedBox(width:30.0),
            DropdownButton(
              iconEnabledColor: Colors.white,
            value: selectedOption2,
            items:getOpcionesDropdown2(),
            onChanged: (opt) {
              setState(() {
                selectedOption2=opt;
                if(selectedOption2 != 'Raza') {
                  this.page = 3;
                }
              });
            },
          )
  
          ],
        ),
      ],
    );
}

  Widget _listViewSales( ) {
    final userService = Provider.of<UserService>(context);
    // final authService = Provider.of<AuthService>(context);
    // final socketService = Provider.of<SocketService>(context, listen: false);

    
    return FutureBuilder(
      future: userService.getAllSalesByBreedAndSpecie(this.selectedOption2,this.selectedOption),
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
                  subtitle: Text('${sales[i].pet.username}    Vendedor: ${sales[i].idSeller.userName} \nEspecie: ${sales[i].pet.specie}      Raza: ${sales[i].pet.breed}'),
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