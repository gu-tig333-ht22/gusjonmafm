import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'themes.dart';

Widget errorMessage(context) {
  return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
          Provider.of<MyErrorNotifier>(context, listen: false).getErrorMessage,
          style: const TextStyle(color: errorColor)));
}

bool validateInput(String input, context) {
  if (input == '') {
    Provider.of<MyErrorNotifier>(context, listen: false).setErrorMessage(true);
    return false;
  } else {
    return true;
  }
}

class MyErrorNotifier extends ChangeNotifier {
  String _errorMessage = "";

  get getErrorMessage => _errorMessage;

  void setErrorMessage(bool bool) {
    if (bool == true) {
      _errorMessage = 'Must contain at least one character';
    } else {
      _errorMessage = '';
    }
    notifyListeners();
  }
}
