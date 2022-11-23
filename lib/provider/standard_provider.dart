import 'package:flutter/material.dart';

class StandarProvider extends ChangeNotifier {


int _id=0;
  get id => _id;
  setid(value) {
    _id = value;
    notifyListeners();
  }
}
