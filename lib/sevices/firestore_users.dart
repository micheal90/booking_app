import 'package:booking_app/models/admin_model.dart';
import 'package:booking_app/models/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUsers {
  CollectionReference adminCollectionRef =
      FirebaseFirestore.instance.collection('admins');
  CollectionReference employeeCollectionRef =
      FirebaseFirestore.instance.collection('employee');

  Future addAdminData(AdminModel adminModel) async {
    await adminCollectionRef.doc(adminModel.id).set(adminModel.toMap());
  }

  Future addEployeeData(EmployeeModel employeeModel) async {
    await employeeCollectionRef
        .doc(employeeModel.id)
        .set(employeeModel.toMap());
  }

  Future getadminData(String adminId) async {
    var value = await adminCollectionRef.doc(adminId).get();
    return value;
  }

  Future deleteAdmin(String adminId) async {
    await adminCollectionRef.doc(adminId).delete();
  }

  Future deleteEmployee(String employeeId) async {
    await employeeCollectionRef.doc(employeeId).delete();
  }

  Future updateAdmin(AdminModel adminModel) async {
    await adminCollectionRef.doc(adminModel.id).update(adminModel.toMap());
  }

  Future updateEmployee(EmployeeModel employeeModel) async {
    await employeeCollectionRef
        .doc(employeeModel.id)
        .update(employeeModel.toMap());
  }
}
