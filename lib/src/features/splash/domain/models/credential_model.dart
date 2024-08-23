import 'package:emdr_mindmend/src/core/enums/login_type.dart';

class CredentialsModel {
  final String? email;
  final String? password;
  final String? id;
  final String? name;
  final LoginType loginType;

  CredentialsModel({
    this.email,
    this.password,
    this.id,
    this.name,
    required this.loginType,
  });

  // Factory method to create a CredentialsModel from JSON
  factory CredentialsModel.fromJson(Map<String, dynamic> json) {
    return CredentialsModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      loginType: LoginType.values.byName(json['loginType']),
    );
  }

  // Method to convert the CredentialsModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'id': id,
      'name': name,
      'loginType': loginType.name,
    };
  }
}
