import 'package:flutter/material.dart';

/// controller for ActionStatus widget
class ActionStatusController with ChangeNotifier {
  Icon currentIcon;
  String currentMessage;
  Color backgroundColor;

  bool visible = false;

  ActionStatusController({
    this.currentIcon = const Icon(Icons.check, color: Colors.white),
    this.currentMessage = 'Everything is working!',
    this.backgroundColor = Colors.white,
  });

  void error({@required String message}) {
    currentIcon = Icon(Icons.warning, color: Colors.white);
    this.currentMessage = message;
    backgroundColor = Colors.red;
    visible = true;

    notifyListeners();
  }

  void success({@required String message}) {
    currentIcon = Icon(Icons.check, color: Colors.white);
    this.currentMessage = message;
    backgroundColor = Colors.green;
    visible = true;

    notifyListeners();
  }
}
