
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/login_response.dart';
import 'package:tindog/models/owned_pets_response.dart';
import 'package:tindog/models/register_response.dart';

class AuthService with ChangeNotifier {
  final _storage = new FlutterSecureStorage();
  bool _autenticando = false;
  String petName; 
  String myPetUserName;
  // static OwnedPet pet;
  static User user;
   
  bool get autenticando => this._autenticando;
  set autenticando( bool valor ) {
    this._autenticando = valor;
    notifyListeners();
  }

  static Future<String> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }
  // para borrar un token
  static Future<String> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }


  Future login( String email, String password ) async{
    this.autenticando = true;
    final data = {
      'email': email,
      'password': password
    };

    final response = await http.post('http://${Env.ip}:${Env.port}/login',
    body: jsonEncode(data),
    headers: {
        'Content-Type': 'application/json'
      }
    );
    print(response.body);
    this.autenticando = false;
    if( response.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(response.body);
      AuthService.user = loginResponse.user;

      this._saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(response.body);
      return respBody['message'];
    }

  }


  Future<dynamic> register( String firstName, String lastName, String userName , String email, String password, String age, String state, String town ) async{
    print(age);
    //(age == null) ? age = '0' : age = age;
    //int newAge = int.parse(age);
    this.autenticando = true;
    final data = {
    "firstName": firstName,
    "lastName": lastName,
    "userName": userName,
    "email": email,
    "password": password,
    "age": age,
    "state": state,
    "town": town
    
    };

    final response = await http.post('http://${Env.ip}:${Env.port}/register',
    body: jsonEncode(data),
    headers: {
        'Content-Type': 'application/json'
      }
    );
    print(response.body);
    this.autenticando = false;
    final registerResponse = registerResponseFromJson(response.body);
    if( response.statusCode == 200 ) {
      
      

      
      return true;
    } else {
      
      return registerResponse.message;
    }

  }

  Future<bool> isLoogedIn() async{
    final token = await this._storage.read(key: 'token');
    print(token); 
    final resp = await http.post('http://${Env.ip}:${Env.port}/login/renew', 
      headers: {
        'Content-Type': 'application/json',
        'token': token
      }
    );
    print(resp.body);
    if(resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      //  le damos más tiempo de vida al token
      AuthService.user = loginResponse.user;
      this._saveToken(loginResponse.token);
      // TODO guardar token 
      

      return true;
    } else {
      this.logout();
      return false;
      
    }


  }


  Future _saveToken( String token ) async{
    return await _storage.write(key: 'token', value: token);
  }
  Future logout() async{
    await _storage.delete(key: 'token');
    await _storage.delete(key:'petName');
    await _storage.delete(key:'petId');
  }
  static Future<String> getPetName() async{
    final _storage = new FlutterSecureStorage();
    final petName = await _storage.read(key: 'petName');
    return petName;
  }

  Future savePetName(String name) async{
    await _storage.write(key: 'petName', value: name);
    this.petName = name;
  }

  Future savePetId(String petId) async{
    await _storage.write(key: 'petId', value: petId);
    //this.idPet = idPet;
  }
  static Future<String> getPetId() async{
    final _storage = new FlutterSecureStorage();
    final petId = await _storage.read(key: 'petId');
    return petId;
  }
  Future savePetUserName(String petUserName) async{
    await _storage.write(key: 'petUserName', value: petUserName);
    this.myPetUserName = petUserName;
    //this.idPet = idPet;
  }
  static Future<String> getPetUserName() async{
    final _storage = new FlutterSecureStorage();
    final petUserName = await _storage.read(key: 'petUserName');
    return petUserName;
  }
}