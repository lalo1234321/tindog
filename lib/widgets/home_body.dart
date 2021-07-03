import 'dart:math';
import 'package:dart_random_choice/dart_random_choice.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/services/movie_service.dart';
import 'package:tindog/services/user_service.dart';
import 'package:tindog/widgets/card_swiper.dart';


class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var random = [1,2,3,4,5,6,7,8,9];
  final movieService = new MovieService();
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    int selectedValue = randomChoice(random);

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 200,
            width:200,
            child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  margin: EdgeInsets.all(1.0),
                  color: Colors.blue,
                  child: Image(image: AssetImage('assets/img/anuncio${selectedValue}.jpg'),)
                ),
          ),
          _swiperTarjetas(userService)
        ],
      );
  }
  Widget _swiperTarjetas (UserService userService) {
    return FutureBuilder(
      future: userService.preMatch(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          
          return (snapshot.data.length == 0) ?  
          Center(
            child: Text('No se han registrado mascotas con esas características'),
          )
          : CardSwiper(
            results: snapshot.data,
          );
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

}