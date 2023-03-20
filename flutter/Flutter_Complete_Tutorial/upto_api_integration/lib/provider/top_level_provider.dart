import 'package:flutter/material.dart';

class TopLevelProvider extends ChangeNotifier {
  int _number = -1;

  setData(int incomingData) {
    _number = incomingData;
    notifyListeners();
  }

  int get storedNumber => _number;

  int get storedNumOne => _number + 1;
  int get storedNumTwo => _number + 2;
  int get storedNumThree => _number + 3;
  int get storedNumFour => _number + 4;
  int get storedNumFive => _number + 5;
  int get storedNumSix => _number + 6;
  int get storedNumSeven => _number + 7;
  int get storedNumEight => _number + 8;
}
