import 'dart:io';

import 'package:booking_app/models/category_model.dart';
import 'package:booking_app/models/device_model.dart';
import 'package:booking_app/models/employee_model.dart';
import 'package:booking_app/models/reserve_device_model.dart';
import 'package:booking_app/sevices/firebase_storage_image.dart';
import 'package:booking_app/sevices/firestore_reserve_devices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import '../sevices/firestore_device.dart';

class MainProvider with ChangeNotifier {
  List<DeviceModel> allDevicesList = [
    // DeviceModel(
    //     id: '1',
    //     name: 'Samsung Note 10',
    //     model: 'Note 10',
    //     os: 'Android Pie',
    //     type: 'ANDROID',
    //     screenSize: '6 inch',
    //     isBooked: true,
    //     battery: '5000 mA',
    //     imageUrl: [
    //       'https://www.mytrendyphone.eu/images/Samsung-Galaxy-Note10-Duos-256GB-Pre-owned-Good-condition-Aura-Black-14042020-01-p.jpg'
    //     ]),
    // DeviceModel(
    //     id: '2',
    //     name: 'Huawei Mate 10',
    //     model: 'Mate 10',
    //     os: 'Android Marshmelo',
    //     type: 'ANDROID',
    //     screenSize: '6 inch',
    //     isBooked: true,
    //     battery: '3330 mA',
    //     imageUrl: [
    //       'https://images-na.ssl-images-amazon.com/images/I/51uAjhBSzOL._AC_SX522_.jpg'
    //     ]),
    // DeviceModel(
    //     id: '3',
    //     name: 'Samsung A50',
    //     model: 'A50',
    //     os: 'Android Pie',
    //     type: 'ANDROID',
    //     isBooked: false,
    //     screenSize: '6 inch',
    //     imageUrl: [
    //       'https://www.mytrendyphone.eu/images/Original-Samsung-Galaxy-A50-Gradation-Cover-EF-AA505CBEGWW-Black-8801643776848-22042019-01-p.jpg'
    //     ],
    //     battery: '5000 mA'),
    // DeviceModel(
    //     id: '4',
    //     name: 'Iphone X',
    //     model: 'X',
    //     os: 'IOS 10',
    //     type: 'IOS',
    //     isBooked: false,
    //     imageUrl: [
    //       'https://www.mytrendyphone.eu/images/iPhone-X-XS-Fake-Camera-Sticker-Black-05122019-01-p.jpg',
    //       'https://www.tjara.com/wp-content/uploads/2021/04/temp1618662955_1903984948.jpg',
    //       'https://cdn.alloallo.media/catalog/product/apple/iphone/iphone-x/iphone-x-space-gray.jpg'
    //     ],
    //     screenSize: '6 inch',
    //     battery: '5000 mA'),
    // DeviceModel(
    //     id: '5',
    //     name: 'Iphone 9',
    //     model: '9',
    //     os: 'IOS 9',
    //     type: 'IOS',
    //     isBooked: false,
    //     screenSize: '6 inch',
    //     imageUrl: [
    //       'https://fdn.gsmarena.com/imgroot/news/20/01/iphone-9-renders/-727/gsmarena_005.jpg'
    //     ],
    //     battery: '5000 mA'),
    // DeviceModel(
    //     id: '6',
    //     name: 'HP 110',
    //     model: '110',
    //     os: 'Windows 10',
    //     type: 'PC',
    //     isBooked: false,
    //     imageUrl: ['https://www.notebookcheck.net/uploads/tx_nbc2/hp110.jpg'],
    //     screenSize: '15 inch',
    //     battery: '5000 mA'),
    // DeviceModel(
    //     id: '7',
    //     name: 'Lenovo 120',
    //     model: '120',
    //     os: 'Windows 10',
    //     type: 'PC',
    //     isBooked: false,
    //     imageUrl: [
    //       'https://www.notebookcheck.net/uploads/tx_nbc2/1204810_10.jpg'
    //     ],
    //     screenSize: '15 inch',
    //     battery: '5000 mA'),
    // DeviceModel(
    // id: '8',
    // name: 'Huawei 3G/4G LTE',
    // model: 'E589u',
    // os: 'android',
    // type: 'OTHERS',
    // isBooked: false,
    // imageUrl: [
    //   'https://www-konga-com-res.cloudinary.com/w_auto,f_auto,fl_lossy,dpr_auto,q_auto/media/catalog/product/N/a/59917_1516110926.jpg'
    // ],
    // screenSize: '3 inch',
    // battery: '5000 mA'),
  ];

  List<CatergoryModel> categories = [
    CatergoryModel(
        name: 'Android',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fandroid96.png?alt=media&token=04dfd03d-2494-48f9-95fe-1f1af390f2c7'),
    CatergoryModel(
        name: 'IOS',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fios-96.png?alt=media&token=9fdeb72c-e35e-4d29-a78e-305361fb0b3d'),
    CatergoryModel(
        name: 'PC',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fpc-96.png?alt=media&token=30326472-db66-4374-aa8e-153bef4587a7'),
    CatergoryModel(
        name: 'Others',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/booking-app-d737d.appspot.com/o/categoriesIcons%2Fothers-96.png?alt=media&token=b95ea046-d22c-46c5-b782-a17303832320'),
  ];
  List<EmployeeModel> employeeList = [
    EmployeeModel(
        id: '1',
        name: 'Micheal',
        lastName: 'Hana',
        occupationGroup: 'IT department',
        email: 'michealhana@gmail.com',
        imageUrl:
            'https://previews.123rf.com/images/yupiramos/yupiramos1607/yupiramos160710209/60039275-young-male-cartoon-profile-vector-illustration-graphic-design-.jpg',
        phone: '+96181488287'),
    EmployeeModel(
        id: '2',
        name: 'Amal',
        lastName: 'Barka',
        occupationGroup: 'HR department',
        email: 'amalbarka@gmail.com',
        imageUrl: '',
        phone: '+96181488287'),
    EmployeeModel(
        id: '3',
        name: 'georges',
        lastName: 'mousa',
        occupationGroup: 'IT department',
        email: 'georges@gmail.com',
        imageUrl: '',
        phone: '+96181488287'),
    EmployeeModel(
        id: '4',
        name: 'dani',
        lastName: 'dodo',
        occupationGroup: 'IT department',
        email: 'dani@gmail.com',
        imageUrl:
            'https://previews.123rf.com/images/yupiramos/yupiramos1607/yupiramos160710209/60039275-young-male-cartoon-profile-vector-illustration-graphic-design-.jpg',
        phone: '+96181488287'),
  ];
  List<dynamic> searchList = [];
  List<DeviceModel> devicesNotBookedList = [];
  List<DeviceModel> androidDevicesList = [];
  List<DeviceModel> iosDevicesList = [];
  List<DeviceModel> pcDevicesList = [];
  List<DeviceModel> othersDevicesList = [];
  List<ReserveDeviceModel> reservedDevicesList = [];
  List<ReserveDeviceModel> orderResvDevicesList = [];

  List<File> selectedImages = [];

  DateTime? startDateTime;
  DateTime? endDateTime;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isSearch = ValueNotifier(false);
  FirestoreDevice firestoreDevice = FirestoreDevice();
  FirestorReserveDevices firestorReserveDevices = FirestorReserveDevices();

  void changeStartDateTime(DateTime date) {
    startDateTime = date;
    notifyListeners();
  }

  void changeEndDateTime(DateTime date) {
    endDateTime = date;
    notifyListeners();
  }

  Future getDevices() async {
    isLoading.value = true;
    clearAllList();
    var devices = await firestoreDevice.getDevices();
    devices.forEach(
        (device) => allDevicesList.add(DeviceModel.fromMap(device.data())));
    await getAllReservedDevices();
    await getAllorderReservDevices();
    await filterDevices();
    isLoading.value = false;
    notifyListeners();
  }

  Future refresh() async {
    await getDevices();
    print('ref');
    notifyListeners();
  }

  void clearAllList() {
    allDevicesList = [];
    androidDevicesList = [];
    iosDevicesList = [];
    pcDevicesList = [];
    reservedDevicesList = [];
    orderResvDevicesList = [];
    devicesNotBookedList = [];
  }

  Future getAllReservedDevices() async {
    var resDevs = await firestorReserveDevices.getAllreservedDevices();
    resDevs.forEach((device) =>
        reservedDevicesList.add(ReserveDeviceModel.fromMap(device.data())));
  }

  Future getAllorderReservDevices() async {
    var orders = await firestorReserveDevices.getAllOrder();
    orders.forEach((order) =>
        orderResvDevicesList.add(ReserveDeviceModel.fromMap(order.data())));
  }

  Future filterDevices() async {
    isLoading.value = true;
    allDevicesList.forEach((device) {
      //filter devices as booked
      if (device.isBooked == false) {
        var isExest = devicesNotBookedList.indexWhere(
          (element) => element.id == device.id,
        );
        if (isExest == -1) {
          devicesNotBookedList.add(device);
        }
      }

      //filter devices ad type
      if (device.type == 'ANDROID' && device.isBooked == false) {
        var isExest = androidDevicesList.indexWhere(
          (element) => element.id == device.id,
        );
        if (isExest == -1) {
          androidDevicesList.add(device);
        }
      } else if (device.type == 'IOS' && device.isBooked == false) {
        var isExest =
            iosDevicesList.indexWhere((element) => element.id == device.id);
        if (isExest == -1) {
          iosDevicesList.add(device);
        }
      } else if (device.type == 'PC' && device.isBooked == false) {
        var isExest =
            pcDevicesList.indexWhere((element) => element.id == device.id);
        if (isExest == -1) {
          pcDevicesList.add(device);
        }
      } else if (device.type == 'OTHERS' && device.isBooked == false) {
        var isExest =
            othersDevicesList.indexWhere((element) => element.id == device.id);
        if (isExest == -1) {
          othersDevicesList.add(device);
        }
      }
    });
    isLoading.value = false;
    notifyListeners();
  }

  DeviceModel findDeviceById(String id) {
    return allDevicesList.firstWhere((element) => element.id == id);
  }

  // void removeFromSearchList(String id) {
  //   searchList.removeWhere((element) => element.id == id);
  //   notifyListeners();
  // }
  void changeIsSearch() {
    isSearch.value = !isSearch.value;
    notifyListeners();
  }
  void searchFunction(String val, List list) {
    searchList = list
        .where(
            (element) => element.name.toLowerCase().contains(val.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future addDevice(
      {required String deviceName,
      required String modNum,
      required String os,
      required String type,
      required String screenSize,
      required String battery}) async {
    try {
      //get doc id from firestore to set in deviceId
      var devId = await firestoreDevice.getDocId();
      //upload images to firebase storage and get urls
      var imageUrls =
          await FirebaseStorageImage().uploadFiles(selectedImages, devId);
      //set device to database
      await firestoreDevice.addDevice(
          DeviceModel(
            id: devId,
            name: deviceName,
            model: modNum,
            os: os,
            type: type,
            isBooked: false,
            screenSize: screenSize,
            battery: battery,
            imageUrl: imageUrls,
          ),
          devId);
      // clear lists after add to database
      imageUrls.clear();
      selectedImages.clear();
      await getDevices();
      notifyListeners();
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future updateDevice({
    required String deviceId,
    String? deviceName,
    String? modNum,
    String? os,
    String? type,
    String? screenSize,
    String? battery,
  }) async {
    try {
      //upload images to firebase storage and get urls
      var imageUrls =
          await FirebaseStorageImage().uploadFiles(selectedImages, deviceId);
      //get the rest imageUrl from device and add to new imageUrls

      var device =
          allDevicesList.firstWhere((element) => element.id == deviceId);
      if (device.imageUrl.isNotEmpty) {
        device.imageUrl.forEach((url) {
          imageUrls.add(url);
        });
      }
      // update new data
      await firestoreDevice.updateDevice(
          deviceId: deviceId,
          deviceModel: modNum,
          battery: battery,
          deviceName: deviceName,
          imageUrls: imageUrls,
          os: os,
          screenSize: screenSize,
          type: type);
      //refetch all device
      await getDevices();
      // clear lists after add to database
      imageUrls.clear();
      selectedImages.clear();
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future deleteDevice(String deviceId) async {
    try {
      await firestoreDevice.deleteDevice(deviceId);
    } catch (e) {
      throw e;
    }
    await getDevices();
    notifyListeners();
  }

  // Future addCtegory(String name, String imageUrl) async {
  //   print('the category is added');
  //   //add to database

  //   CatergoryModel catergoryModel =
  //       CatergoryModel(name: name, imageUrl: imageUrl);
  //   categories.add(catergoryModel);
  //   categoryTypeList.add(name.toUpperCase());
  //   notifyListeners();
  // }

  Future deleteCategory() async {
    print('the category is deleted');
  }

  Future updateCategory() async {
    print('Category updated');
    //must be update catigories list in database
  }

  //pick image and compressed
  Future pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowCompression: true,
        allowedExtensions: ['jpg', 'jpeg', 'png']);
    if (result != null) {
      var files = result.paths.map((path) => File(path!)).toList();
      files.forEach((file) async {
        print('befor :${file.lengthSync()}');
        File compressedFile = await FlutterNativeImage.compressImage(
          file.path,
          quality: 50,
        );
        selectedImages.add(compressedFile);
        notifyListeners();
        print('after :${compressedFile.lengthSync()}');
      });
    }
  }

  //delete imageUrl localy
  Future deleteImage(int index, String id) async {
    print(index);
    print(id);
    var device = allDevicesList.firstWhere((element) => element.id == id);
    if (device.imageUrl.length > 1) {
      //remove image localy
      device.imageUrl.removeAt(index);
      notifyListeners();
      return 'image has been deleted';
    } else {
      return 'You can not remove all images';
    }
  }
}
