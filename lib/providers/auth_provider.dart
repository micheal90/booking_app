import 'dart:convert';

import 'package:booking_app/models/admin_model.dart';
import 'package:booking_app/models/employee_model.dart';
import 'package:booking_app/sevices/firestore_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  ValueNotifier<bool> isShowPassword = ValueNotifier(true);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirestoreUsers firestoreUsers = FirestoreUsers();
  AdminModel? adminModel;
  List<EmployeeModel> employeeList = [];
  List<AdminModel> adminList = [];
  List<dynamic> allUsers = [];

  bool get isAuth {
    return adminModel != null;
  }

  void changeShowPassword() {
    isShowPassword.value = !isShowPassword.value;
    notifyListeners();
  }

  Future getAllUsers() async {
    allUsers.clear();
    await getAdmin();
    await getEmployee();
  }

  Future getAdmin() async {
    adminList.clear();
    var admins = await firestoreUsers.getAdmins();
    admins.forEach((admin) {
      adminList.add(AdminModel.fromMap(admin.data()));
      allUsers.add(AdminModel.fromMap(admin.data()));
    });
    notifyListeners();
  }

  Future getEmployee() async {
    employeeList.clear();
    var employees = await firestoreUsers.getEmployees();
    employees.forEach((emp) {
      employeeList.add(EmployeeModel.fromMap(emp.data()));
      allUsers.add(EmployeeModel.fromMap(emp.data()));
    });
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
        String adminData = json.encode({
          'email': adminModel!.email,
          'adminId': userCredential.user!.uid,
        });
        prefs.setString('adminData', adminData);

        print('set User');
        print('user login');
      });
    } catch (e) {
      throw e;
    }
  }

  Future getUserData(String adminId) async {
    await firestoreUsers.getAdminData(adminId).then((data) {
      adminModel = AdminModel.fromMap(data.data() as Map<String, dynamic>);
    });
    notifyListeners();
  }

  //try auto log in if get user from sharedpreferences
  Future<bool> tryAutoLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('adminData')) return false;

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

  Future resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
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
        await firestoreUsers.addAdminData(adminModel);
        await getAdmin();
        notifyListeners();
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
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((userCredential) async {
        EmployeeModel employeeModel = EmployeeModel(
            id: userCredential.user!.uid,
            name: name!,
            lastName: lastName!,
            occupationGroup: occupationGroup!,
            email: email,
            imageUrl: '',
            phone: phone!);
        await firestoreUsers.addEployeeData(employeeModel);
        await getEmployee();
        notifyListeners();
      });
    } catch (e) {
      throw e;
    }
  }

  Future updateAdmin() async {
    isLoading.value = true;
    try {
      await firestoreUsers.updateAdmin(adminModel!);
      await getUserData(adminModel!.id);
    } catch (e) {
      throw e;
    }
    isLoading.value = false;
    notifyListeners();
  }

  Future deleteEmployee(String employeeId) async {
    try {
          await firestoreUsers.deleteEmployee(employeeId);
      await getEmployee();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  

  Future deleteAdmin(String adminId) async {
    try {
      await firestoreUsers.deleteAdmin(adminId);
      await getAdmin();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  EmployeeModel findEmployeeById(String id) {
    return employeeList.firstWhere((element) => element.id == id);
  }

  AdminModel findAdminById(String id) {
    return adminList.firstWhere((element) => element.id == id);
  }
}
