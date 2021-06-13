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
  final movieService = new MovieService();
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _swiperTarjetas(userService)
        ],
      );
  }
  Widget _swiperTarjetas (UserService userService) {
    return FutureBuilder(
      future: userService.preMatch(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          return CardSwiper(
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