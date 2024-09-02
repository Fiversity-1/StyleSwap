import 'dart:convert';

class User {
  final String id;
  final String name;
  final String profileDescription;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.profileDescription,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profileDescription: json['profileDescription'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileDescription': profileDescription,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, profileDescription: $profileDescription, address: $address}';
  }
}
