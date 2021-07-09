import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              });
            },
          )
  
          ],
        ),
      ],
    );
}

}