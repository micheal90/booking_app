import 'dart:convert';

import 'package:booking_app/models/admin_model.dart';
import 'package:booking_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  ValueNotifier<bool> isShowPassword = ValueNotifier(true);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AdminModel? adminModel;

  bool get isAuth {
    return adminModel != null;
  }

  void changeShowPassword() {
    isShowPassword.value = !isShowPassword.value;
    notifyListeners();
  }

  Future logInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCredential) async {
        //get userData from database after login
        await getUserData(userCredential.user!.uid);
        //set user in sharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userData = json.encode({
          'email': adminModel!.email,
          'adminId': userCredential.user!.uid,
        });
        prefs.setString('adminData', userData);

        print('set User');
        print('user login');
      });
    } catch (e) {
      throw e;
    }
  }

  Future getUserData(String userId) async {
    CollectionReference userCollectionRef =
        FirebaseFirestore.instance.collection('admins');
    await userCollectionRef.doc(userId).get().then((userData) {
      adminModel = AdminModel.fromMap(userData.data() as Map<String, dynamic>);
    });
    notifyListeners();
  }

  //try auto log in if get user from sharedpreferences
  Future<bool> tryAutoLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('adminData')) {
      return false;
    }
    Map<String, dynamic> extractUserData =
        json.decode(prefs.getString('adminData')!);
    //get all userData from database
    getUserData(extractUserData['adminId']);

    print('get user data');
    notifyListeners();
    return true;
  }

  //set user in sharedPreferences
  Future setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userData = json.encode({
      'email': adminModel!.email,
      'adminId': adminModel!.id,
    });
    prefs.setString('adminData', userData);
    print('set User');
  }

  Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    prefs.clear();
  }

  Future addAdmin({
    String? name,
    String? lastName,
    String? email,
    String? password,
  }) async {
    CollectionReference adminCollectionRef =
        FirebaseFirestore.instance.collection('admins');
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((userCredential) async {
        AdminModel adminModel = AdminModel(
          id: userCredential.user!.uid,
          name: name!,
          lastName: lastName!,
          email: email,
        );
        await adminCollectionRef.doc(adminModel.id).set(adminModel.toMap());
      });
    } catch (e) {
      throw e;
    }
  }

  Future addEmplyee(
      {String? name,
      String? lastName,
      String? occupationGroup,
      String? email,
      String? password,
      String? phone}) async {
    CollectionReference userCollectionRef =
        FirebaseFirestore.instance.collection('users');
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((userCredential) async {
        UserModel userModel = UserModel(
            id: userCredential.user!.uid,
            name: name!,
            lastName: lastName!,
            occupationGroup: occupationGroup!,
            email: email,
            imageUrl: '',
            phone: phone!);
        await userCollectionRef.doc(userModel.id).set(userModel.toMap());
      });
    } catch (e) {
      throw e;
    }
  }
}
