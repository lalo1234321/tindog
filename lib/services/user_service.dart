import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/get_all_my_chats_for_sale_response.dart';
import 'package:tindog/models/get_all_sales_response.dart';
import 'package:tindog/models/get_all_species.dart';
import 'package:tindog/models/notifications_response.dart';
import 'package:tindog/models/owned_pets_response.dart';
import 'package:tindog/models/prematch_response.dart';
import 'package:tindog/models/retrieve_chat_response.dart';
import 'package:tindog/models/retrieve_message_response.dart';
import 'package:tindog/models/upgrade_response.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:http_parser/http_parser.dart';

class UserService with ChangeNotifier{
  String petUserNameTo;
  
  bool _autenticando = false;
  
  
  
  bool get autenticando => this._autenticando;
  set autenticando( bool valor ) {
    this._autenticando = valor;
    notifyListeners();
  }

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
    Future<List> retrieveChat() async{
      try{
        final petId = await AuthService.getPetId();
        final response = await http.get('http://${Env.ip}:${Env.port}/pet/accept/$petId');
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        final retrieveChatResponse = retrieveChatResponseFromJson(response.body);
        return retrieveChatResponse.accepted.acceptedPets;
      } catch (e) {
        return [];
      }
      
    }
    Future acceptChat(String petUserName) async{
      try{
        final petId = await AuthService.getPetId();
        final response = await http.put('http://${Env.ip}:${Env.port}/pet/accept/$petId/$petUserName');
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        
      } catch (e) {
        print(e);
      }
      
    }
    Future<List> retrieveMessageSale ( String idTo ) async{
      try{
        // final petUserName =  await AuthService.getPetUserName();
        String myId = AuthService.user.id;
        final response = await http.get('http://${Env.ip}:${Env.port}/pet/messages/$myId/$idTo');

        final responseBody = jsonDecode(response.body);
        print(responseBody);
        final retrieveMessageResponse = retrieveMessageResponseFromJson( response.body );
        return retrieveMessageResponse.last30;
      } catch( e ) {
        return [];
      }
    }
    Future<List> retrieveMessage ( String otherPetUserName ) async{
      try{
        final petUserName =  await AuthService.getPetUserName();
        final response = await http.get('http://${Env.ip}:${Env.port}/pet/messages/$petUserName/$otherPetUserName');

        final responseBody = jsonDecode(response.body);
        print(responseBody);
        final retrieveMessageResponse = retrieveMessageResponseFromJson( response.body );
        return retrieveMessageResponse.last30;
      } catch( e ) {
        return [];
      }
    }


    Future registerPet(String userName, String name, String age, String specie, String breed, File profileImage, File certificateImage, String gender,List vaccine) async{
    List<String> _vaccines = vaccine;
    final token = await AuthService.getToken();
    this.autenticando = true;
    Map<String, String> headers = { 
      "token": token
    
    };

    var url = 'http://${Env.ip}:${Env.port}/pet';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['username'] = userName;
    request.fields['name'] = name;
    request.fields['age'] = age;
    request.fields['specie'] = specie;
    request.fields['breed'] = breed;
    request.fields['gender'] = gender;
    for( int i = 0; i < _vaccines.length; i++ ) {
      request.fields['vaccines[$i]'] = '${_vaccines[i]}';
    }
    
    var profile = await http.MultipartFile.fromPath("profileImage", profileImage.path,contentType: MediaType('image','jpg'));
    var certificate = await http.MultipartFile.fromPath("medicalCertificateImage", certificateImage.path,contentType: MediaType('image','jpg'));
    //var profile = new http.MultipartFile.fromBytes("profileImage", await profileImage.readAsBytes(), contentType: MediaType('image','jpg));
    //var profile = await http.MultipartFile.fromPath("profileImage", profileImage.path);
    request.files.add(profile);
    request.files.add(certificate);

    var res = await request.send();
    var responseData = await res.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    var d = jsonDecode(responseString);
    
    print(d['message']);
    print( res.statusCode );
    this.autenticando = false;
    //print(res);
    if(res.statusCode == 200 ) {
      return d['message'];
    } else {
      // debemos de mapear el error
//      final respBody = jsonDecode(resp.body);
      //return respBody['msg'];
      return false;
    }


  }


  Future updatePassword( String newPassword ) async{
    print(newPassword);
    try {
      String token = await AuthService.getToken();
      print(token);
      Map<String, String> headers = { 
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      };
      final response = await http.put('http://${Env.ip}:${Env.port}/updatePassword',
        headers: headers,
        body: jsonEncode({
          'password': newPassword
        })
      );
      print('Despues de la petición');
      final responseBody = jsonDecode(response.body);
      print(responseBody);


    } catch(e) {
      print(e);
    }
    
  }
  Future updateTown( String newTown ) async{
    // print(newPassword);
    try {
      String token = await AuthService.getToken();
      print(token);
      Map<String, String> headers = { 
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      };
      final response = await http.put('http://${Env.ip}:${Env.port}/updateTown',
        headers: headers,
        body: jsonEncode({
          'town': newTown
        })
      );
      print('Despues de la petición');
      final responseBody = jsonDecode(response.body);
      print(responseBody);


    } catch(e) {
      print(e);
    }
    
  }

  Future updateState( String newState ) async{
    try {
      String token = await AuthService.getToken();
      print(token);
      Map<String, String> headers = { 
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      };
      final response = await http.put('http://${Env.ip}:${Env.port}/updateState',
        headers: headers,
        body: jsonEncode({
          'state': newState 
        })
      );
      print('Despues de la petición');
      final responseBody = jsonDecode(response.body);
      print(responseBody);


    } catch(e) {
      print(e);
    }
  }
  // static Future<String> getToken() async{
  //   final _storage = new FlutterSecureStorage();
  //   final token = await _storage.read(key: 'token');
  //   return token;
  // }

  Future updatePetName( String newName ) async{
    try {
      String token = await AuthService.getToken();
      String petId = await AuthService.getPetId();
      print(token);
      Map<String, String> headers = { 
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      };
      final response = await http.put('http://${Env.ip}:${Env.port}/updateName/$petId',
        headers: headers,
        body: jsonEncode({
          'name': newName
        })
      );
      print('Despues de la petición');
      final responseBody = jsonDecode(response.body);
      print(responseBody);


    } catch(e) {
      print(e);
    }

    
  }
  Future updatePetAge( int newAge ) async{
    print(newAge);
      try {
      String token = await AuthService.getToken();
      String petId = await AuthService.getPetId();
      print(token);
      Map<String, String> headers = { 
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      };
      final response = await http.put('http://${Env.ip}:${Env.port}/updateAge/$petId',
        headers: headers,
        body: jsonEncode({
          'age': newAge.toString()
        })
      );
      print('Despues de la petición');
      final responseBody = jsonDecode(response.body);
      print(responseBody);


    } catch(e) {
      print(e);
    }

  }
  Future deleteUser() async{
    try {
      String token = await AuthService.getToken();
      Map<String, String> headers = { 
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      };
      final response = await http.put('http://${Env.ip}:${Env.port}/deleteUser',
        headers: headers
      );

    } catch(e) {
      print(e);
    }
    

  }

  Future deletePet() async{
    try {
      String token = await AuthService.getToken();
      String petId = await AuthService.getPetId();
      Map<String, String> headers = { 
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      };
      final response = await http.put('http://${Env.ip}:${Env.port}/deletePet/$petId',
        headers: headers
      );
    }catch(e) {
      print(e);
    }
  }

  Future updateProfileImage( File profileImage) async{
    final token = await AuthService.getToken();
    final petId = await AuthService.getPetId();
    this.autenticando = true;
    Map<String, String> headers = { 
      "token": token
    
    };

    var url = 'http://${Env.ip}:${Env.port}/pet/update/profilePicture/$petId';
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers.addAll(headers);
    var profile = await http.MultipartFile.fromPath("profilePic", profileImage.path,contentType: MediaType('image','jpg'));
    // var certificate = await http.MultipartFile.fromPath("medicalCertificateImage", certificateImage.path,contentType: MediaType('image','jpg'));
    request.files.add(profile);
    // request.files.add(certificate);

    var res = await request.send();
    var responseData = await res.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    var d = jsonDecode(responseString);
    
    print(d['message']);
    print( res.statusCode );
    this.autenticando = false;
    //print(res);
    if(res.statusCode == 200 ) {
      return d['message'];
    } else {
      // debemos de mapear el error
//      final respBody = jsonDecode(resp.body);
      //return respBody['msg'];
      return false;
    }


  }

  Future updateMedicalCertificateImage( File medicalCertificateImage) async{
    final token = await AuthService.getToken();
    final petId = await AuthService.getPetId();
    this.autenticando = true;
    Map<String, String> headers = { 
      "token": token
    
    };

    var url = 'http://${Env.ip}:${Env.port}/pet/update/medicalCertificate/$petId';
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers.addAll(headers);
    var medical = await http.MultipartFile.fromPath("certificate", medicalCertificateImage.path,contentType: MediaType('image','jpg'));
    // var certificate = await http.MultipartFile.fromPath("medicalCertificateImage", certificateImage.path,contentType: MediaType('image','jpg'));
    request.files.add(medical);
    // request.files.add(certificate);

    var res = await request.send();
    var responseData = await res.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    var d = jsonDecode(responseString);
    
    print(d['message']);
    print( res.statusCode );
    this.autenticando = false;
    //print(res);
    if(res.statusCode == 200 ) {
      return d['message'];
    } else {
      // debemos de mapear el error
//      final respBody = jsonDecode(resp.body);
      //return respBody['msg'];
      return false;
    }


  }
  

  Future<String> petValoration( double valoration, String petUserName ) async{
    try {
      String token = await AuthService.getToken();
      String petId = await AuthService.getPetId();
      Map<String, String> headers = { 
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      };
      final response = await http.post('http://${Env.ip}:${Env.port}/pet/valoration',
        headers: headers,
        body: jsonEncode({
          'petId': petId,
          'username': petUserName,
          'stars': valoration
        })
      );
      final respBody = jsonDecode(response.body);
      print(respBody["message"]);
    if(response.statusCode == 200 ) {
      
       
      

      return respBody["message"];
    } else {
      
      return respBody["message"];
      
    }
    }catch(e) {
      return 'Error en el servidor';
    }
  }


  Future<String> sellAPet( String sellUserName,String price ) async{
    // double priceParsed = double.parse(price);
    // if(double.parse(price).runtimeType == double) {
    //   print('Soy un double');
    // }
    // else {
    //   print('No soy un double');
    // }
    try {
      // String petUserName = await AuthService.getPetUserName();
      String token = await AuthService.getToken();
      // String petId = await AuthService.getPetId();
      Map<String, String> headers = { 
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      };
      final response = await http.post('http://${Env.ip}:${Env.port}/sales/register',
        headers: headers,
        body: jsonEncode({
          'price': price,
          'username': sellUserName
        })
      );
      final respBody = jsonDecode(response.body);
      print(respBody["message"]);
    if(response.statusCode == 200 ) {
      
       
      

      return respBody["message"];
    } else {
      
      return respBody["message"];
      
    }
    }catch(e) {
      return 'Error en el servidor';
    }
  }

  Future<List<Sale>> getAllSales() async{
    try{
      final token = await AuthService.getToken();
      final response = await http.get('http://${Env.ip}:${Env.port}/getAllSales',
        headers: {
          'Content-Type': 'application/json',
          'token': token
        }
      );
    final respBody = jsonDecode(response.body);

    //print( respBody );
    final getAllSales = getAllSalesResponseFromJson(response.body);
    return getAllSales.sales;
    }catch(e) {
      return [];
    }
    
  }


  Future<String> createChatForSale( String idSeller ) async{
    String token = await AuthService.getToken();
    try{
      final response = await http.post('http://${Env.ip}:${Env.port}/chat/topic/register',
          headers: {
            'Content-Type': 'application/json',
            'token': token
          },
          body: jsonEncode({
            'idVendedor': idSeller
          })
      );
      final respBody = jsonDecode(response.body);
      return respBody["message"];


    } catch(e) {
      print(e);
      return 'Error en el servidor';
    }


  }
  Future<List<Chat>> getAllMyChatsForSales() async{
    String token = await AuthService.getToken();
    try {
      final response = await http.get('http://${Env.ip}:${Env.port}/chat/topic/getAll',
          headers: {
            'Content-Type': 'application/json',
            'token': token
          }
      );
      final getAllMyChats = getAllMyChatsForSaleResponseFromJson(response.body);
      return getAllMyChats.chats;

    } catch(e) {
      print(e);
      return [];
    }
  }

  Future <List<String>> getAllSpecies() async{
    String token = await AuthService.getToken();
    try {
      final response = await http.get('http://${Env.ip}:${Env.port}/getAllSpeciesPet',
      headers: {
        'Content-Type': 'application/json',
        'token': token
      });
      final getAllSpeciesResponse = getAllSpeciesResponseFromJson(response.body);
      return getAllSpeciesResponse;
    } catch(e) {
      print(e);
      return [];
    }
  }

  Future<List<String>> getAllBreedsBySpeciePet( String specie ) async{
    String token = await AuthService.getToken();
    try{
      
      final response = await http.post('http://${Env.ip}:${Env.port}/getAllBreedsBySpeciePet',
          headers: {
            'Content-Type': 'application/json',
            'token': token
          },
          body: jsonEncode({
            'specie': specie
          })
      );
      print(response.body);
      final getAllBreedsResponse = getAllSpeciesResponseFromJson(response.body);
      return getAllBreedsResponse;

    }catch(e) {
      return [];
    }
  }

}