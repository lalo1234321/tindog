import 'package:flutter/material.dart';


class Btn extends StatelessWidget {

  final String title;
  final bool hasBorder;
  final Function onChanged;

  const Btn({
    Key key, 
    this.title, 
    this.hasBorder, 
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: hasBorder ? 
          Border.all(
            color: Colors.blue,
            width: 1.0
          ) : Border.fromBorderSide(BorderSide.none),
          color: hasBorder ? Colors.blue : Colors.white,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          child: GestureDetector(
            onTap: onChanged,
            child: Container(
              height: 60,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: hasBorder ? Colors.white : Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}