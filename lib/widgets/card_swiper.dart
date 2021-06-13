import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/prematch_response.dart';




class CardSwiper extends StatelessWidget {

  final List<Match> results;

  const CardSwiper({Key key, this.results}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     //De esta forma podemos modificar el tamaño de las cards
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      
      child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight:_screenSize.height * 0.5,
          itemBuilder: (BuildContext context,int index){
            String result = results[index].profileImageUri.replaceAll("localhost", Env.ip);

            return Hero(
                tag:results[index].id,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                    onTap: (){
                      print('Presionaste ${results[index].username}');
                    },
                    child: FadeInImage(               
                    image: NetworkImage('http://'+result),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit:BoxFit.cover,
                  ),
                ),
              ),
            ); 
            
          },
          itemCount: results.length,
          //Esta línea muestra con puntos la cantidad de cards que hay en el swipe
          //pagination: new SwiperPagination(),
          //Nos indica la dirección a donde podremos rotar las cards
          //control: new SwiperControl(),
      ),
    );
  }
}