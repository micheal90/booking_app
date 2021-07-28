class AdminModel {
  String id;
  String name;
  String lastName;
  String email;

  AdminModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      email: map['email'],
    );
  }
}
