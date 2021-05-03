import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tindog/helpers/home_view.dart';


class CustomInput extends StatelessWidget {

  final String hintText;
  final IconData prefixIconData;
  final IconData sufixIconData;
  final bool obscureText;
  final Function onChanged;
  final TextEditingController textController;

  const CustomInput({
    Key key, 
    this.hintText, 
    this.prefixIconData, 
    this.sufixIconData, 
    this.obscureText, 
    this.onChanged, 
    this.textController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeView>(context);
    return TextField(
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14
      ),
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size:18,
          color: Colors.blue
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue)
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            model.isVisible = !model.isVisible;
          },
          child: Icon(
            sufixIconData,
            size: 18,
            color: Colors.blue,
          ),
        ),
        labelStyle: TextStyle(color: Colors.blue)
        ),
        
        obscureText: obscureText,
        controller: this.textController,
      ) ;  
    
  }
}