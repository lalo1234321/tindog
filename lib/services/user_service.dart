import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/owned_pets_response.dart';
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
  // static Future<String> getToken() async{
  //   final _storage = new FlutterSecureStorage();
  //   final token = await _storage.read(key: 'token');
  //   return token;
  // }
}