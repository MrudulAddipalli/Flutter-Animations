import 'package:flutter/cupertino.dart';

class MyBlocTest with ChangeNotifier {
  bool state = true;
  start() {
    state = false;
    notifyListeners();
  }
}
