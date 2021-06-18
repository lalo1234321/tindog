


import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tindog/helpers/env.dart';
import 'package:tindog/services/auth_service.dart';
enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{
  
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;



  void connect() async{
    final token = await AuthService.getToken(); 
    final petId = await AuthService.getPetId();
    final petUserName = await AuthService.getPetUserName();
    this._socket = IO.io('http://${Env.ip}:${Env.port}', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'token': token,
        'petusername': petUserName
      }
    });
    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

  }
  void disconnect() {
    this._socket.disconnect();
  }
  


}