// To parse this JSON data, do
//
//     final updateProfileResponseModel = updateProfileResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponseModel updateProfileResponseModelFromJson(String str) => UpdateProfileResponseModel.fromJson(json.decode(str));

String updateProfileResponseModelToJson(UpdateProfileResponseModel data) => json.encode(data.toJson());

class UpdateProfileResponseModel {
  String message;
  Data data;
  Tokens tokens;

  UpdateProfileResponseModel({
    required this.message,
    required this.data,
    required this.tokens,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) => UpdateProfileResponseModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    tokens: Tokens.fromJson(json["tokens"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "tokens": tokens.toJson(),
  };
}

class Data {
  String username;
  String? image;

  Data({
    required this.username,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    username: json["username"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "image": image,
  };
}

class Tokens {
  String accessToken;

  Tokens({
    required this.accessToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
  };
}
