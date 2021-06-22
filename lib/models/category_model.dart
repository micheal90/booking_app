
class CatergoryModel {
  String name;
  String imagUrl;
  CatergoryModel({
    required this.name,
    required this.imagUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imagUrl': imagUrl,
    };
  }

  factory CatergoryModel.fromMap(Map<String, dynamic> map) {
    return CatergoryModel(
      name: map['name'],
      imagUrl: map['imagUrl'],
    );
  }
}
