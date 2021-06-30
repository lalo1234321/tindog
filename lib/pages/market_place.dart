import 'package:flutter/material.dart';
import 'package:tindog/pages/publications_page.dart';
import 'package:tindog/pages/sell_page.dart';


class MarketPlace extends StatefulWidget {
  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compra y venta'),
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
      break;
    }
  }
}