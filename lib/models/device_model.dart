
class DeviceModel {
  String name;
  String model;
  String os;
  String type;
  bool isBooked;
  String screenSize;
  String battery;
  List<String> imageUrl;
  DeviceModel({
    required this.name,
    required this.model,
    required this.os,
    required this.type,
    required this.isBooked,
    required this.screenSize,
    required this.battery,
    required this.imageUrl,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'model': model,
      'os': os,
      'type': type,
      'isBokked': isBooked,
      'screenSize': screenSize,
      'battery': battery,
      'imageUrl': imageUrl,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      name: map['name'],
      model: map['model'],
      os: map['os'],
      type: map['type'],
      isBooked: map['isBokked'],
      screenSize: map['screenSize'],
      battery: map['battery'],
      imageUrl: List<String>.from(map['imageUrl']),
    );
  }

}
