import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/notifications_response.dart';
import 'package:tindog/models/owned_pets_response.dart';
import 'package:tindog/models/prematch_response.dart';
import 'package:tindog/models/upgrade_response.dart';
import 'package:tindog/services/auth_service.dart';


class UserService with ChangeNotifier{

  
  Future<List<OwnedPet>> ownedPets() async{
    try{
      final token = await AuthService.getToken();
    final response = await http.get('http://${Env.ip}:${Env.port}/user',
      headers: {
        'Content-Type': 'application/json',
        'token': token
      }
    );
    final respBody = jsonDecode(response.body);

    //print( respBody );
    final ownedPetsResponse = ownedPetsResponseFromJson(response.body);
    return ownedPetsResponse[0].ownedPets;
    }catch(e) {
      return [];
    }
    
  }

  Future<String> upgradeAccount( int plan ) async{
    try{
      final token = await AuthService.getToken();
      final response = await http.put('http://${Env.ip}:${Env.port}/upgrade',
      headers: {
        'Content-Type': 'application/json',
        'token': token
      },
      body:jsonEncode({
        'typePlan': plan
      }));
      final respBody = jsonDecode(response.body);
      print(respBody);
      final upgradeResponse = upgradeResponseFromJson(response.body);
      AuthService.user.premium = upgradeResponse.user.premium;
      return upgradeResponse.message;
    } catch(e){
      return "Ha ocurrido un error";
    }
  }


  Future<List<Match>> preMatch() async{
    
    try{
      final token = await AuthService.getToken();
      final id = await AuthService.getPetId();
      final response = await http.get('http://${Env.ip}:${Env.port}/pet/match/$id',

      headers: {
        'Content-Type': 'application/json',
        'token': token
      });

      final respBody = jsonDecode(response.body);
      //print(respBody);
      final preMatchResponse = preMatchResponseFromJson(response.body);
      return preMatchResponse.match;
    }catch(e) {
      return [];
    }
  }


  Future<List> retrieveNotifications() async{
    try{
      String petUserName = await AuthService.getPetUserName();
      String token = await AuthService.getToken();
      final response = await http.get('http://${Env.ip}:${Env.port}/pet/notifications/$petUserName',
      headers: {
        'token': token
      });
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      final notificationsResponse = notificationsResponseFromJson(response.body);
      return notificationsResponse.results;

    } catch(e) {
      return [];
    }
    
    
  }
  Future deleteNotification(String id) async{
    print('dentro del delete method');
      String token = await AuthService.getToken();
      final response = await http.delete('http://${Env.ip}:${Env.port}/pet/notifications/$id',
      headers: {
        'token': token
      });
      final responseBody = jsonDecode(response.body);
      print(responseBody);

    }
  // static Future<String> getToken() async{
  //   final _storage = new FlutterSecureStorage();
  //   final token = await _storage.read(key: 'token');
  //   return token;
  // }
}