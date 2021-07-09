import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/get_all_my_chats_for_sale_response.dart';
import 'package:tindog/models/retrieve_chat_response.dart';
import 'package:tindog/models/usuario.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/services/user_service.dart';


class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  UserService userService;
  List _usuarios = [
    // Usuario(uid: '1',nombre: 'Lalo', email: 'test1@test', online: true),
    // Usuario(uid: '2',nombre: 'Edgar', email: 'test2@test', online: true),
    // Usuario(uid: '3',nombre: 'Luis', email: 'test3@test', online: true),
    // Usuario(uid: '4',nombre: 'Alberto', email: 'test4@test', online: false),
    // Usuario(uid: '1',nombre: 'Lalo', email: 'test1@test', online: true),
    // Usuario(uid: '2',nombre: 'Edgar', email: 'test2@test', online: true),
    // Usuario(uid: '3',nombre: 'Luis', email: 'test3@test', online: true),
    // Usuario(uid: '4',nombre: 'Alberto', email: 'test4@test', online: false),
    // Usuario(uid: '1',nombre: 'Lalo', email: 'test1@test', online: true),
    // Usuario(uid: '2',nombre: 'Edgar', email: 'test2@test', online: true),
    // Usuario(uid: '3',nombre: 'Luis', email: 'test3@test', online: true),
    // Usuario(uid: '4',nombre: 'Alberto', email: 'test4@test', online: false)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userService = Provider.of<UserService>(context, listen: false);
    _loadChats();
  }
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        // title: Text(usuario.nombre, style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () {
            //TODO desconectar de nuestro socket server
            // como yo no quiero instanciar todo el authservice podemos entrar a los métodos estáticos
            // por eso es imporetante trabajar con métodos estáticos según nos convenga
            // socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            // AuthService.deleteToken();
            //  en este punto ya se borró el token y cuand0 reiniciemos la app la loading page nos
            // redirigirá al login page
          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only( right: 10 ),
            // child: Icon(Icons.bolt, color: Colors.red,),
            // child: Icon(Icons.check_circle, color: Colors.blue,),
            child: ( socketService.serverStatus == ServerStatus.Online) 
                          ? 
                    Icon(Icons.check_circle, color: Colors.blue,)
                            :
                    Icon(Icons.bolt, color: Colors.red,),
          )
        ],
      ),
      // body: _listViewUsuarios()
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400],
        ),
        onRefresh: () async{
          print('actualizando chats');
          _loadChats();
          // _cargarUsuarios();
        },
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context,i) {
        return _usuarioListTile(_usuarios[i]);
      },
      separatorBuilder: (BuildContext context,i) {
        return Divider();
      },
      itemCount: _usuarios.length,
      
    );
  }

  ListTile _usuarioListTile(AcceptedPet usuario) {
    String result = usuario.profileImageUri.replaceAll("localhost", Env.ip);
    return ListTile(
          title: Text(usuario.username),
          subtitle: Text(usuario.id),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('http://'+result),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: (usuario.owner.isOnline) ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
          // agregar onTap para saber a qué usuario apuntar
          onTap: () {
            // listen en false porque no quiero que este escuchando los cambios
            // Debo de invesigar cuando ponerle true y cuando false
            // final chatService = Provider.of<ChatService>(context, listen: false);
            // chatService.usuarioPara = usuario;
            // print(usuario.nombre);
            this.userService.petUserNameTo = usuario.username;
            Navigator.pushNamed(context, 'chat', arguments: {
              'petUserName': usuario.username,
              'profileImage': 'http://'+result
            });

            // Navigator.pushNamed(context, 'chat');
          },
        );
  }
   _loadChats() async{
    
    this._usuarios = await userService.retrieveChat();
    setState(() {
      
    });
    // await Future.delayed(Duration( milliseconds: 1000 ));
    _refreshController.refreshCompleted();
  }


  
}