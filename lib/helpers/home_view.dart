import 'package:flutter/material.dart';


class HomeView with ChangeNotifier {
  
  bool _isVisible = false;

  get isVisible => _isVisible;

  set isVisible( value ) {
    _isVisible = value;
    notifyListeners();
  }

} 