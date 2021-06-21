


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/home_view.dart';
import 'package:tindog/models/place.dart';
import 'package:tindog/pages/chat_page.dart';
import 'package:tindog/pages/loading_page.dart';
import 'package:tindog/pages/login_page.dart';
import 'package:tindog/pages/match_page.dart';
import 'package:tindog/pages/payment_page.dart';
import 'package:tindog/pages/pet_detail_page.dart';
import 'package:tindog/pages/premium_page.dart';
import 'package:tindog/pages/profile_page.dart';
import 'package:tindog/pages/register_page.dart';
import 'package:tindog/pages/register_pet_page.dart';
import 'package:tindog/pages/search_page.dart';
import 'package:tindog/pages/settings_page.dart';
import 'package:tindog/pages/users_page.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/geolocator_service.dart';
import 'package:tindog/services/places_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/services/user_service.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (BuildContext context ) => HomeView()),
        ChangeNotifierProvider(create: ( BuildContext context ) => AuthService()),
        ChangeNotifierProvider(create: ( BuildContext context ) => UserService() ),
        ChangeNotifierProvider(create: ( BuildContext context ) => SocketService() ),
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position,Future<List<Place>>>( 
          update: (context,position,places){
            return (position !=null) ? placesService.getPlaces(position.latitude, position.longitude) :null;
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: {
          
          'login': ( BuildContext context ) => LoginPage(),
          'loading': ( BuildContext context ) => LoadingPage(),
          'register' : (BuildContext context) => RegisterPage(),
          'profile' : (BuildContext context) => ProfilePage(),
          'chats' : (BuildContext context) => UsersPage(),
          'match' : (BuildContext context) => MatchPage(),
          'chat' : (BuildContext context) => ChatPage(),
          'settings' : (BuildContext context)  => SettingsPage(),
          'payment' : ( BuildContext context ) => PaymentPage(),
          'premium' : ( BuildContext context ) => PremiumPage(),
          'detail' : ( BuildContext context ) => PetDetailPage(),
          'search' : ( BuildContext context ) => Search(),
          'registerPet' : ( BuildContext context ) => RegisterPet()

        },
      ),
    );
  }
}