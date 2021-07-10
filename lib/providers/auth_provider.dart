import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  Future addEmplyee(
      {name, lastName, occupationGroup, email, password, phone}) async {
    print('add employee');
  }
}
