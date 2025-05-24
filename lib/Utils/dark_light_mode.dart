import 'package:flutter/material.dart';

import 'Colors.dart';

class ColorNotifier with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  
  set setIsDark(value) {
    _isDark = value;
    notifyListeners();
  }

  get background => _isDark ? BlackColor : WhiteColor;
  get textColor => _isDark ? WhiteColor : BlackColor;
  get textLightColor => _isDark ? WhiteColor : Colors.grey;
  get containerColor => _isDark ? boxcolor : GreyColor;
  get borderColor => _isDark ? borderGray : GreyColor;
}
