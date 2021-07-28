import 'package:booking_app/models/device_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDevice {
  CollectionReference _deviceCollectionRef =
      FirebaseFirestore.instance.collection('devices');

  Future getDevices() async {
    var value = await _deviceCollectionRef.get();
    return value.docs;
  }

  Future<String> getDocId() async {
    return _deviceCollectionRef.doc().id;
  }

  Future addDevice(DeviceModel deviceModel, deviceId) async {
    await _deviceCollectionRef.doc(deviceId).set(deviceModel.toMap());
  }

  Future updateDevice(DeviceModel deviceModel) async {
    await _deviceCollectionRef.doc(deviceModel.id).update(deviceModel.toMap());
  }

  Future deleteDevice(String deviceId) async {
    await _deviceCollectionRef.doc(deviceId).delete();
  }
}
