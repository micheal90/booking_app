import 'package:cloud_firestore/cloud_firestore.dart';

class FirestorReserveDevices {
  CollectionReference _reservedCollectionRef =
      FirebaseFirestore.instance.collection('reservedDevices');
  CollectionReference _ordersCollectionRef =
      FirebaseFirestore.instance.collection('orderReservedDevices');

  Future getAllreservedDevices() async {
    var reserved = await _reservedCollectionRef.get();
    return reserved.docs;
  }

  Future getAllOrder() async {
    var orders = await _ordersCollectionRef.get();
    return orders.docs;
  }
  
}
