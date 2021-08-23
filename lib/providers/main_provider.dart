import 'dart:io';

import 'package:booking_app/models/category_model.dart';
import 'package:booking_app/models/device_model.dart';
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

  List<DeviceModel> devicesNotBookedList = [];
  List<DeviceModel> androidDevicesList = [];
  List<DeviceModel> iosDevicesList = [];
  List<DeviceModel> pcDevicesList = [];
  List<DeviceModel> othersDevicesList = [];
  List<ReserveDeviceModel> reservedDevicesList = [];
  List<ReserveDeviceModel> orderResvDevicesList = [];

  List<File> selectedImages = [];
  List<String> selectedImageUrlDeleted = [];

  DateTime? startDateTime;
  DateTime? endDateTime;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isSearch = ValueNotifier(false);
  FirestoreDevice firestoreDevice = FirestoreDevice();
  FirestorReserveDevices firestorReserveDevices = FirestorReserveDevices();

  Future fetchDataAndCheckDate() async {
    print('fetchDataAndCheckDate');
    isLoading.value = true;
    await getAllDevices();
    await checkStartReserveDate();
    await checkEndReserveDate();
    await fetchDataAfterCheck();
    isLoading.value = false;
    notifyListeners();
  }

  Future fetchDataAfterCheck() async {
    print('fetchDataAfterCheck');
    isLoading.value = true;
    await getAllDevices();
    await getAllReservedDevices();
    await getAllorderReservDevices();
    await filterDevices();
    isLoading.value = false;
    notifyListeners();
  }

  Future getAllDevices() async {
    print('get allDevices');
    clearAllList();
    var devices = await firestoreDevice.getDevices();
    devices.forEach(
        (device) => allDevicesList.add(DeviceModel.fromMap(device.data())));
    print('alldevice: ${allDevicesList.length}');
    notifyListeners();
  }

  Future refresh() async {
    await fetchDataAndCheckDate();
    print('refresh');
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
    print('getAllReservedDevices');
    reservedDevicesList.clear();
    var resDevs = await firestorReserveDevices.getAllreservedDevices();
    print(resDevs);
    resDevs.forEach((element) {
      var resDevice = ReserveDeviceModel.fromMap(element.data());
      var isExest = reservedDevicesList
          .indexWhere((element) => element.id == resDevice.id);
      if (isExest == -1) {
        reservedDevicesList.add(resDevice);
      }
    });
    notifyListeners();
  }

  Future getAllorderReservDevices() async {
    print('getAllorderReservDevices');
    orderResvDevicesList.clear();
    var orders = await firestorReserveDevices.getAllOrder();
    orders.forEach((element) {
      var orderResv = ReserveDeviceModel.fromMap(element.data());
      print(element);
      var isExest = orderResvDevicesList
          .indexWhere((element) => element.id == orderResv.id);
      if (isExest == -1) {
        orderResvDevicesList.add(orderResv);
      }
    });
    notifyListeners();
  }

  Future checkStartReserveDate() async {
    //get all orders from database
    var allOrdersReserved = await firestorReserveDevices.getAllOrder();
    var checkList = [];
    print('order length: ${allOrdersReserved.length}');
    // check if allOrdersReserved is empty
    if (allOrdersReserved.isEmpty) return;
    //loop in allOrdersReserved and save in checkList
    allOrdersReserved.forEach((element) {
      checkList.add(ReserveDeviceModel.fromMap(element.data()));
    });
    print('checkList length:${checkList.length}');

    //check orders in checkList if date now is after start time
    checkList.forEach((order) async {
      //get start an end time for check
      var start = DateTime.parse(order.startDate);
      var end = DateTime.parse(order.endDate);

      if (DateTime.now().isAfter(start) && DateTime.now().isBefore(end)) {
        print(DateTime.now().isAfter(start) && DateTime.now().isBefore(end));
        // add reserve device to database
        await firestorReserveDevices.addReserveDevice(order);

        //change key isBooked to true in device and update device
        DeviceModel deviceModel = findDeviceById(order.id);

        await firestoreDevice.updateDevice(
          deviceId: deviceModel.id,
          isBooked: true,
          battery: deviceModel.battery,
          model: deviceModel.model,
          deviceName: deviceModel.name,
          imageUrls: deviceModel.imageUrl,
          os: deviceModel.os,
          screenSize: deviceModel.screenSize,
          type: deviceModel.type,
        );

        // delete the order reservation from database
        allOrdersReserved.forEach((orderdel) async {
          if (ReserveDeviceModel.fromMap(orderdel.data()).id ==
              deviceModel.id) {
            await firestorReserveDevices.deleteOrderReserved(orderdel.id);
          }
        });
        //get all devices after change
        await fetchDataAfterCheck();
      }
      //check if order is expire
      if (DateTime.now().isAfter(start) && DateTime.now().isAfter(end)) {
        // delete the order reservation from database
        allOrdersReserved.forEach((orderdel) async {
          DeviceModel deviceModel = findDeviceById(order.id);
          if (ReserveDeviceModel.fromMap(orderdel.data()).id ==
              deviceModel.id) {
            await firestorReserveDevices.deleteOrderReserved(orderdel.id);
          }
        });
      }
    });
  }

  Future checkEndReserveDate() async {
    //get all orders from database
    var allReservedDevices =
        await firestorReserveDevices.getAllreservedDevices();

    List<ReserveDeviceModel> list = [];
    allReservedDevices.forEach((element) {
      list.add(ReserveDeviceModel.fromMap(element.data()));
    });

    //check if found orders
    if (list.isEmpty) return;
    list.forEach((resvDev) async {
      //check if date now is afer the end date in resvDev reserved
      if (DateTime.now().isAfter(DateTime.parse(resvDev.endDate))) {
        await unBookedDevice(resvDev);
        //get all devices after change
        await fetchDataAfterCheck();
      }
    });
  }

  Future unBookedDevice(ReserveDeviceModel reserveDeviceModel) async {
    //get deviceModel from reservation id
    var deviceModel = allDevicesList
        .firstWhere((element) => element.id == reserveDeviceModel.id);

    //remove reseved divice from database
    var allReservedDevices =
        await firestorReserveDevices.getAllreservedDevices();
    allReservedDevices.forEach((resvDev) async {
      if (ReserveDeviceModel.fromMap(resvDev.data()).id == deviceModel.id) {
        await firestorReserveDevices.deleteReservedDevice(resvDev.id);
      }
    });
    //return isBooked in device to false
    await firestoreDevice.updateDevice(
      deviceId: deviceModel.id,
      isBooked: false,
      battery: deviceModel.battery,
      model: deviceModel.model,
      deviceName: deviceModel.name,
      imageUrls: deviceModel.imageUrl,
      os: deviceModel.os,
      screenSize: deviceModel.screenSize,
      type: deviceModel.type,
    );
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
    print('all in find: ${allDevicesList.length}');
    return allDevicesList.firstWhere((element) => element.id == id);
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
      await fetchDataAndCheckDate();
      notifyListeners();
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future updateDevice({
    required String deviceId,
    required String deviceName,
    required String modNum,
    required String os,
    required String type,
    required bool isBooked,
    required List<String> imageUrl,
    required String screenSize,
    required String battery,
  }) async {
    try {
      //upload images to firebase storage and get urls
      var newImageUrls =
          await FirebaseStorageImage().uploadFiles(selectedImages, deviceId);
      //get the rest imageUrl from device and add to new imageUrls
      if (imageUrl.isNotEmpty) {
        imageUrl.forEach((url) {
          newImageUrls.add(url);
        });
      }
      // update new data
      await firestoreDevice.updateDevice(
        deviceId: deviceId,
        model: modNum,
        battery: battery,
        deviceName: deviceName,
        imageUrls: newImageUrls,
        os: os,
        isBooked: isBooked,
        screenSize: screenSize,
        type: type,
      );
      //delete selectedImageUrlDeleted from firestorage
      selectedImageUrlDeleted.forEach((element) async {
        await FirebaseStorageImage().deleteImageByUrl(element);
      });

      //refetch all device
      await fetchDataAndCheckDate();
      // clear lists after add to database
      newImageUrls.clear();
      selectedImages.clear();
      selectedImageUrlDeleted.clear();
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
    await fetchDataAndCheckDate();
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
  // Future deleteImage(int index, String id) async {
  //   print(index);
  //   print(id);
  //   var device = allDevicesList.firstWhere((element) => element.id == id);
  //   if (device.imageUrl.length > 1) {
  //     //remove image localy
  //     device.imageUrl.removeAt(index);
  //     notifyListeners();
  //     return 'image has been deleted';
  //   } else {
  //     return 'You can not remove all images';
  //   }
  // }

  void changeStartDateTime(DateTime date) {
    startDateTime = date;
    notifyListeners();
  }

  void changeEndDateTime(DateTime date) {
    endDateTime = date;
    notifyListeners();
  }
}
