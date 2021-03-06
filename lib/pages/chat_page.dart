import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/models/retrieve_message_response.dart';
import 'package:tindog/services/auth_service.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/services/user_service.dart';
import 'package:tindog/widgets/chat_message.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  SocketService socketService;
  AuthService authService;
  UserService userService;
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [];
  String petUserNameTo;
  @override
  void initState() { 
    super.initState();
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    this.userService = Provider.of<UserService>(context, listen: false);
    this.socketService.socket.on('personal-message', _listenMessage);
    print( userService.petUserNameTo );
    _loadMessages( userService.petUserNameTo );
  }

  void _loadMessages( String petUserNameTo ) async{
    List<Last30> chat = await this.userService.retrieveMessage( petUserNameTo );
    final history = chat.map((e) => new ChatMessage(
      texto: e.msg,
      uid: e.from,
      animationController: new AnimationController(vsync: this, duration: Duration(milliseconds: 0))..forward(),
    
    ));
    if(mounted) {
      setState(() {
      _messages.insertAll(0, history);
    });
    }
    
  }

  void _listenMessage( dynamic payload ) {
    ChatMessage message = new ChatMessage(
      texto: payload['msg'], 
      uid: payload['from'], 
      animationController: AnimationController(vsync: this, duration: new Duration(milliseconds: 300))
    );
    if(mounted){
      setState(() {
      _messages.insert(0, message);
      });

    // necesitamos arrancar la animaci??n
      message.animationController.forward();
    }
    
  }
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    this.petUserNameTo = arguments['petUserName'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                // child: Text('SM', style: TextStyle(fontSize: 12)),
                backgroundImage: NetworkImage(arguments['profileImage']),
                maxRadius: 15,
              ),
              Text(arguments['petUserName'],style: TextStyle(color: Colors.black, fontSize: 12),)
            ],
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),  //para hacer el cuerpo usaremos flexible para que se expanda seg??n lo que tengamos
      body: Column(
        children: <Widget>[
          Flexible(
            // hay que recordar que el listView.builder se va generando con base en la demanda
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, i) {
                return _messages[i];
              },
              reverse: true,
              physics: BouncingScrollPhysics(),
              )
          ),
          Divider( height: 1,),
          //TODO  caja de texto
          Container(
            color: Colors.white,
            child: _inputChat(),
          )

        ],
      )
    );
  


  }

  Widget _inputChat() {
    // el cuadro de texto siempre debe de trabajarse dentro de un safe area
   return SafeArea(
     child: Container(
       margin: EdgeInsets.symmetric( horizontal: 8.0 ),
       child: Row(
         children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (String texto) {
                //TODO cuando hay un valor para poder postear
                // en este punto sabemos que el usuario est?? escribiendo, debemos de cambiar el bool con el setState
                setState(() {
                  if(texto.trim().length > 0) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
                
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar mensaje'
              ),
              focusNode: _focusNode,
            ) 
          ),

          Container(
            margin: EdgeInsets.symmetric( horizontal: 4.0 ),
            child: IconTheme(
              data: IconThemeData( color: Colors.blue[400] ),
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon( Icons.send ),
                onPressed: (_estaEscribiendo) 
                          ?
                          () => _handleSubmit( _textController.text.trim() )
                          :
                          null
              ),
            )
          )
         ],
       ),
     ) 
    );  
  }
  // aqui haremos instancias de los mensajes, cada vez que se presione el submit
  // Para insertar 
  _handleSubmit( String texto ) async{
    String petUserName = await AuthService.getPetUserName();
    if(texto.length == 0) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();
    if(mounted) {
      final newMessage = new ChatMessage(
      uid: petUserName, 
      texto: texto,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 500)),//el this est?? disponibler gracias a la mezcla  
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
    }
    


    // en este punto ya pudimos enviar mensajes al socket service, pero hace falta hacer que el 
    // servidor est?? a la escucha de ??stos 
    this.socketService.emit('personal-message',{
      'from'   : petUserName,
      'to' : this.petUserNameTo,
      'msg'  : texto 
    });
  }

  // cuando terminemos de usar esta p??gina debemos de eliminarla, debido a que hacemos muchas instancias 
  // del animatorController, y en un futuro usaremos sockets, eso har?? que se degrade el rendimiento de
  // la app

  @override
  void dispose() {
    // TODO off del socket
    // TODO: implement dispose
    for( ChatMessage message in _messages ) {
      message.animationController.dispose();
    }
    // para evitar escuchar los mensajes de otras personas matar el canal de conexi??n hasta que 
    // se vuelva a conectar
    // this.socketService.socket.off(event)
    super.dispose();
  }

}

   