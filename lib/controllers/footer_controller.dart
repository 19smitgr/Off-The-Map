import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// controls data for an infoFooter
class FooterController with ChangeNotifier {
  /// keeps track if an info footer should be extended
  bool _footerExtended = false;

  /// keeps track of the widget that should be used to populate an info footer
  Widget _footerContent;

  /// can be used to make a footer into a widget that can change pages (its content)
  /// will notify listeners of change
  void replaceFooterContent(Widget content) {
    _footerContent = content;
    notifyListeners();
  }

  get footerContent => _footerContent;

  /// sets whether footer is extended or not
  /// will notify listeners of change
  set extended(extended) {
    _footerExtended = extended;
    notifyListeners();
  }

  get extended => _footerExtended;
}