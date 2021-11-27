
import 'dart:async';
import 'package:flutter/widgets.dart';

class KeysState extends ChangeNotifier {
  final int gridSize;
  final int playSpeed;
  List<bool>_selectedButtons =[];


  KeysState({this.gridSize = 6, this.playSpeed = 125});


  void addKey(int pos) {
      _selectedButtons[pos] = true;
      notifyListeners();
    }

  void removeKey(int pos) {
    _selectedButtons[pos] = false;
    notifyListeners();
  }
}