import 'package:booking_app/models/device_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDevice {
  CollectionReference _deviceCollectionRef =
      FirebaseFirestore.instance.collection('devices');

  Future getDevices() async {
    var value = await _deviceCollectionRef.get();
    return value.docs;
  }
  //used when add new device
  Future<String> getDocId() async {
    return _deviceCollectionRef.doc().id;
  }

  Future addDevice(DeviceModel deviceModel, deviceId) async {
    await _deviceCollectionRef.doc(deviceId).set(deviceModel.toMap());
  }

  Future updateDevice(
      {String? deviceId,
      String? deviceName,
      String? deviceModel,
      String? type,
      String? os,
      String? screenSize,
      String? battery,
      List<String>? imageUrls}) async {
    await _deviceCollectionRef.doc(deviceId).update({
      'id': deviceId,
      'name': deviceName,
      'model': deviceModel,
      'os': os,
      'type': type,
      'screenSize': screenSize,
      'battery': battery,
      'imageUrl': imageUrls,
    });
  }

  Future deleteDevice(String deviceId) async {
    await _deviceCollectionRef.doc(deviceId).delete();
  }
}
