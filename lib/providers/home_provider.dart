import 'package:booking_app/constants.dart';
import 'package:booking_app/models/device_model.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class HomeProvider with ChangeNotifier {
  List<DeviceModel> allDevicesList = [
    DeviceModel(
        name: 'Samsung Note 10',
        model: 'Note 10',
        os: 'Android Pie',
        type: 'Android',
        screenSize: '6 inch',
        battery: '5000 mA',
        imageUrl: [
          'https://www.mytrendyphone.eu/images/Samsung-Galaxy-Note10-Duos-256GB-Pre-owned-Good-condition-Aura-Black-14042020-01-p.jpg'
        ]),
    DeviceModel(
        name: 'Samsung A50',
        model: 'A50',
        os: 'Android Pie',
        type: 'Android',
        screenSize: '6 inch',
        imageUrl: [
          'https://www.mytrendyphone.eu/images/Original-Samsung-Galaxy-A50-Gradation-Cover-EF-AA505CBEGWW-Black-8801643776848-22042019-01-p.jpg'
        ],
        battery: '5000 mA'),
    DeviceModel(
        name: 'Iphone X',
        model: 'X',
        os: 'IOS 10',
        type: 'IOS',
        imageUrl: [
          'https://www.mytrendyphone.eu/images/iPhone-X-XS-Fake-Camera-Sticker-Black-05122019-01-p.jpg',
          'https://www.tjara.com/wp-content/uploads/2021/04/temp1618662955_1903984948.jpg',
          'https://cdn.alloallo.media/catalog/product/apple/iphone/iphone-x/iphone-x-space-gray.jpg'
        ],
        screenSize: '6 inch',
        battery: '5000 mA'),
    DeviceModel(
        name: 'Iphone 9',
        model: '9',
        os: 'IOS 9',
        type: 'IOS',
        screenSize: '6 inch',
        imageUrl: [
          'https://fdn.gsmarena.com/imgroot/news/20/01/iphone-9-renders/-727/gsmarena_005.jpg'
        ],
        battery: '5000 mA'),
    DeviceModel(
        name: 'HP 110',
        model: '110',
        os: 'Windows 10',
        type: 'PC',
        imageUrl: ['https://www.notebookcheck.net/uploads/tx_nbc2/hp110.jpg'],
        screenSize: '15 inch',
        battery: '5000 mA'),
    DeviceModel(
        name: 'Lenovo 120',
        model: '120',
        os: 'Windows 10',
        type: 'PC',
        imageUrl: [
          'https://www.notebookcheck.net/uploads/tx_nbc2/1204810_10.jpg'
        ],
        screenSize: '15 inch',
        battery: '5000 mA'),
  ];
  List<DeviceModel> androidDevicesList = [];
  List<DeviceModel> iosDevicesList = [];
  List<DeviceModel> pcDevicesList = [];
  List<DeviceModel> reservedDevicesList = [
    DeviceModel(
        name: 'Samsung Note 10',
        model: 'Note 10',
        os: 'Android Pie',
        type: 'Android',
        screenSize: '6 inch',
        battery: '5000 mA',
        imageUrl: [
          'https://www.mytrendyphone.eu/images/Samsung-Galaxy-Note10-Duos-256GB-Pre-owned-Good-condition-Aura-Black-14042020-01-p.jpg'
        ]),
    DeviceModel(
        name: 'Iphone 9',
        model: '9',
        os: 'IOS 9',
        type: 'IOS',
        screenSize: '6 inch',
        imageUrl: [
          'https://fdn.gsmarena.com/imgroot/news/20/01/iphone-9-renders/-727/gsmarena_005.jpg'
        ],
        battery: '5000 mA'),
    DeviceModel(
        name: 'Iphone 9',
        model: '9',
        os: 'IOS 9',
        type: 'IOS',
        screenSize: '6 inch',
        imageUrl: [
          'https://fdn.gsmarena.com/imgroot/news/20/01/iphone-9-renders/-727/gsmarena_005.jpg'
        ],
        battery: '5000 mA'),
    DeviceModel(
        name: 'HP 110',
        model: '110',
        os: 'Windows 10',
        type: 'PC',
        imageUrl: ['https://www.notebookcheck.net/uploads/tx_nbc2/hp110.jpg'],
        screenSize: '15 inch',
        battery: '5000 mA'),
  ];
  List<Asset> selectedImages = <Asset>[];
  String error = 'No Error Detected';
  CategoryType categoryType = CategoryType.Android;

  void changeType(CategoryType type) {
    categoryType = type;
    //save the content in db
    notifyListeners();
  }

  filterDevices() {
    //you must change compare to id
    allDevicesList.forEach((device) {
      if (device.type == 'Android') {
        var isExest = androidDevicesList.indexWhere(
          (element) => element.name == device.name,
        );
        if (isExest == -1) {
          androidDevicesList.add(device);
        }
      } else if (device.type == 'IOS') {
        var isExest =
            iosDevicesList.indexWhere((element) => element.name == device.name);
        if (isExest == -1) {
          iosDevicesList.add(device);
        }
      } else {
        var isExest =
            pcDevicesList.indexWhere((element) => element.name == device.name);
        if (isExest == -1) {
          pcDevicesList.add(device);
        }
      }
    });
    //notifyListeners();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String _error = 'No Error Detected';
    print('first');
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: selectedImages,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Booked App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      throw (e);
    }
    //you must saved the list in database
    selectedImages = resultList;
    error = _error;
    notifyListeners();
  }
}
