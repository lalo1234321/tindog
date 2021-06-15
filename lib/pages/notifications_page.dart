import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tindog/models/notification.dart';
import 'package:tindog/services/socket_service.dart';
import 'package:tindog/widgets/notification.dart';



class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // RefreshController _refreshController = RefreshController(initialRefresh: false);
  SocketService socketService;
  List<Widget> notifications = [
    // new Notify(from: 'lalo')
  ];
  //List<Widget> _results = <Widget>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.socketService.socket.on('notify', listenNotifications);
    
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
  void listenNotifications(dynamic payload) {
    print('have a message $payload');
    // Card notification = _myCard(payload['from'], payload['to']);
    print('dentro del notify');
    // notifications.insert(0, notification);
    if(mounted){
    setState(() {
      notifications = [...notifications,new Notify(from: payload['from'])];

      print(notifications);
      
    });
    }
    // if(mounted) {
    //   print('dentro del mounted');
    //   setState(() {
    //   print(notifications);
    //   notifications.insert(0, notification);
    // });
    // }
    

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(usuario.nombre, style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 70),
          child: Text('Notificaciones',
          style: TextStyle(color: Colors.blue),),
        ),
      ),
      // body: _listViewUsuarios()
      body: 
        ListView(
          children: notifications,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // listenNotifications({
            //   'for': 'lalo',
            //   'to': 'tania'
            // });
            //notifications.add(new Notify(from: 'tania'));
            print(notifications);
            setState(() {
              notifications = [...notifications,new Notify(from: 'tania')];
            });
          },
        ),
      
    );
  }

  
  Card _myCard(String from, String to) {
  return Card(
    
    // Con esta propiedad modificamos la forma de nuestro card
    // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    
    // Con esta propiedad agregamos margen a nuestro Card
    // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
    margin: EdgeInsets.all(15),
    
    // Con esta propiedad agregamos elevación a nuestro card
    // La sombra que tiene el Card aumentará
    elevation: 10,

    // La propiedad child anida un widget en su interior
    // Usamos columna para ordenar un ListTile y una fila con botones
    child: Column(
      children: <Widget>[

        // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
          title: Text('Solicitud de emparejamiento'),
          subtitle: Text(
              '$from quiere hablar contigo!!!'),
          leading: Icon(Icons.network_locked),
        ),
        
        // Usamos una fila para ordenar los botones del card
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(onPressed: () => {}, child: Icon(Icons.mark_chat_read)),
            TextButton(onPressed: () => {}, child: Icon(Icons.not_interested, color: Colors.red,))
          ],
        )
      ],
    ),
  );
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
