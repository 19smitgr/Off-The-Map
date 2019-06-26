import 'package:flutter/foundation.dart';

class FooterController with ChangeNotifier {
  bool _footerExtended = false;

  set extended(extended) {
    _footerExtended = extended;
    notifyListeners();
  }

  get extended => _footerExtended;
}