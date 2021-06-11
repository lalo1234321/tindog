
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tindog/models/login_response.dart';

class AuthService with ChangeNotifier {
  final _storage = new FlutterSecureStorage();
  bool _autenticando = false;
  String petName; 

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

    final response = await http.post('http://192.168.100.6:8080/login',
    body: jsonEncode(data),
    headers: {
        'Content-Type': 'application/json'
      }
    );
    print(response.body);
    this.autenticando = false;
    if( response.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(response.body);
      this._saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(response.body);
      return respBody['message'];
    }

  }
  Future _saveToken( String token ) async{
    return await _storage.write(key: 'token', value: token);
  }
  Future logout() async{
    await _storage.delete(key: 'token');
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
}