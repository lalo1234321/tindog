import 'package:flutter/material.dart';
import 'package:tindog/models/movie_response.dart';
import 'package:tindog/pages/chat_page.dart';
import 'package:tindog/pages/notifications_page.dart';
import 'package:tindog/pages/settings_page.dart';
import 'package:tindog/pages/users_page.dart';
import 'package:tindog/widgets/home_body.dart';


class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  int page;
  String petName;
  Map<int,String> pages = {
    1: 'match',
    2: 'chats'
  };
  // Result result = new Result(
  //   title: 'El perro mugroso', 
  //   id: 1, 
  //   posterPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYghpfZc9Ulf-zM7PSY2do3vVm9XGi3Bbjqg&usqp=CAU'
  // );
  
  List<Result> results = [
    Result(
    title: 'mugroso', 
    id: 0, 
    posterPath: ''
    ),
    Result(
    title: 'tonto', 
    id: 1, 
    posterPath: ''
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = 0;
    // petName = await AuthService.getPetName(); 
  }
  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    
    // Future(() async{
    //   String petName = await AuthService.getPetName();
    //   return 
    // })
    return Scaffold(
      // appBar: AppBar(title: Text('Usando a: ')),
        
      
      body: _selectPage(),
      bottomNavigationBar: _bottomNavigationBar(context),
      
    );
  }

  
  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        //CAmbiar el color de el navigationBar
        canvasColor: Color.fromRGBO(0, 160, 255, 1.0),
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme
                  .copyWith(caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0))) 
      ),
      child: BottomNavigationBar(
        currentIndex: page,
        onTap: (int index) {
          setState(() {
            this.page = index;
          });
          // Navigator.pushNamed(context, 'chats');
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets_outlined,size: 30.0,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,size: 30.0,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important,size: 30.0,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,size: 30.0,),
            label: '',
          ),
        ],
      ),
    );
  }
  Widget _selectPage() {
    switch(page) {
      case 0: {
        return HomeBody();
      }
      break;
      case 1: {
        return UsersPage();
      }
      break;
      case 2: {
        return NotificationsPage();
      }
      break;
      case 3: {
        return SettingsPage();
      }
      break;
    }
  }
}