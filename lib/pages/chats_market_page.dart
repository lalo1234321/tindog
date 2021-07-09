import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tindog/helpers/env.dart';
import 'package:tindog/models/get_all_my_chats_for_sale_response.dart';
import 'package:tindog/models/owned_pets_response.dart';
import 'package:tindog/models/usuario.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/services/user_service.dart';

class ChatsMarketPage extends StatefulWidget {
  @override
  _ChatsMarketPageState createState() => _ChatsMarketPageState();
}

class _ChatsMarketPageState extends State<ChatsMarketPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  UserService userService;
  List<Chat> myChats = [];
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
      // appBar: AppBar(
      //   // title: Text(usuario.nombre, style: TextStyle(color: Colors.black87),),
      //   elevation: 1,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Icon(Icons.exit_to_app, color: Colors.black87),
      //     onPressed: () {
      //       //TODO desconectar de nuestro socket server
      //       // como yo no quiero instanciar todo el authservice podemos entrar a los métodos estáticos
      //       // por eso es imporetante trabajar con métodos estáticos según nos convenga
      //       // socketService.disconnect();
      //       Navigator.pushReplacementNamed(context, 'login');
      //       // AuthService.deleteToken();
      //       //  en este punto ya se borró el token y cuand0 reiniciemos la app la loading page nos
      //       // redirigirá al login page
      //     },
      //   ),
      //   actions: <Widget>[
      //     Container(
      //       margin: EdgeInsets.only( right: 10 ),
      //       // child: Icon(Icons.bolt, color: Colors.red,),
      //       // child: Icon(Icons.check_circle, color: Colors.blue,),
      //       child: ( socketService.serverStatus == ServerStatus.Online) 
      //                     ? 
      //               Icon(Icons.check_circle, color: Colors.blue,)
      //                       :
      //               Icon(Icons.bolt, color: Colors.red,),
      //     )
      //   ],
      // ),
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
        return _usuarioListTile(myChats[i]);
      },
      separatorBuilder: (BuildContext context,i) {
        return Divider();
      },
      itemCount: myChats.length,
      
    );
  }
  //TODO poner un tipo de objeto mis chats
  ListTile _usuarioListTile( Chat usuario) {
    // String result = usuario..replaceAll("localhost", Env.ip);
    return ListTile(
          title: Text((AuthService.user.id == usuario.idVendedor.id) ? usuario.idComprador.userName :usuario.idVendedor.userName),
          subtitle: Text((AuthService.user.id == usuario.idVendedor.id) ? usuario.idComprador.town :usuario.idVendedor.town),
          leading: CircleAvatar(
            child: Icon(Icons.monetization_on),
            // backgroundImage: NetworkImage(''),
            // backgroundImage: NetworkImage('http://'+result),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: ((AuthService.user.id == usuario.idVendedor.id) ? usuario.idComprador.isOnline :usuario.idVendedor.isOnline) ? Colors.green : Colors.grey,
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
            // this.userService.petUserNameTo = usuario.username;
            // print('Seleccionando el chat de ${(AuthService.user.id == usuario.idVendedor.id) :usuario.idVendedor.id}');
            AuthService.idTo = (AuthService.user.id == usuario.idVendedor.id) ? usuario.idComprador.id :usuario.idVendedor.id;
            Navigator.pushNamed(context, 'salesChat',arguments: {
              'idTo': (AuthService.user.id == usuario.idVendedor.id) ? usuario.idComprador.id :usuario.idVendedor.id
            });
            // Navigator.pushNamed(context, 'chat', arguments: {
            //   'petUserName': usuario.username,
            //   'profileImage': 'http://'+result
            // });

            // Navigator.pushNamed(context, 'chat');
          },
        );
  }
   _loadChats() async{
    this.myChats = await userService.getAllMyChatsForSales();
    // this._usuarios = await userService.retrieveChat();
    setState(() {
      
    });
    // await Future.delayed(Duration( milliseconds: 1000 ));
    _refreshController.refreshCompleted();
  }
}