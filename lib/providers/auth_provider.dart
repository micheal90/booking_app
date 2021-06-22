import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  ValueNotifier<bool> isShowPassword = ValueNotifier(true);
  void changeShowPassword() {
    isShowPassword.value = !isShowPassword.value;
    notifyListeners();
  }
}
