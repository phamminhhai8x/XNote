import 'package:flutter/material.dart';

class DemoLocalizations {
  DemoLocalizations();

  static String locale = "en";

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Hello World',
    },
    'es': {
      'title': 'Hola Mundo',
    },
  };

  static String get title {
    return _localizedValues[locale]['title'];
  }
}
