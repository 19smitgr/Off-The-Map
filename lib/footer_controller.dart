import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FooterController with ChangeNotifier {
  bool _footerExtended = false;

  Widget _footerContent;

  void replaceFooterContent(Widget content) {
    _footerContent = content;
    notifyListeners();
  }

  get footerContent => _footerContent;

  set extended(extended) {
    _footerExtended = extended;
    notifyListeners();
  }

  get extended => _footerExtended;
}