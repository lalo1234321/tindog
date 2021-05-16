
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  final _storage = new FlutterSecureStorage();
  String petName; 
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