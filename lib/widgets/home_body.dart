import 'package:flutter/material.dart';
import 'package:tindog/services/movie_service.dart';
import 'package:tindog/widgets/card_swiper.dart';


class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final movieService = new MovieService();
  Widget build(BuildContext context) {
    
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _swiperTarjetas()
        ],
      );
  }
  Widget _swiperTarjetas () {
    return FutureBuilder(
      future: movieService.getMovies(),
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