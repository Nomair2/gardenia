class StoreModel {
  final String name;
  final String location;
  final String email;
  final String phone;
  final String password;
  final String id;
  final String image;

  const StoreModel({
    required this.name,
    required this.location,
    required this.phone,
    required this.image,
    required this.email,
    required this.password,
    required this.id,
  });

  static StoreModel fromMap(Map<String, dynamic> map) {
    return StoreModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      image: map['image'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'location': location,
      'email': email,
      'phone': phone,
      'password': password,
      'id': id,
    };
  }
}

class UserModle {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String id;
  final String image;

  const UserModle({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
    required this.email,
    required this.password,
    required this.id,
  });

  static UserModle fromMap(Map<String, dynamic> map) {
    return UserModle(
      firstName: map['firstName'] ?? '',
      phone: map['phone'] ?? '',
      lastName: map['lastName'] ?? '',
      image: map['image'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'id': id,
    };
  }
}
