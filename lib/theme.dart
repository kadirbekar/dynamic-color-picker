import 'package:flutter/material.dart';

//It listens all actions when something change
class ColorNotifier with ChangeNotifier {
  Color _colorData;

  ColorNotifier(this._colorData);

  getColor() => _colorData;

  setColor(Color colorData) {
    _colorData = colorData;
    notifyListeners();
  }
}
