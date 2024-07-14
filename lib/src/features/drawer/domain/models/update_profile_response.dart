// To parse this JSON data, do
//
//     final updateProfileResponseModel = updateProfileResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponseModel updateProfileResponseModelFromJson(String str) => UpdateProfileResponseModel.fromJson(json.decode(str));

String updateProfileResponseModelToJson(UpdateProfileResponseModel data) => json.encode(data.toJson());

class UpdateProfileResponseModel {
  String message;
  Data data;


  UpdateProfileResponseModel({
    required this.message,
    required this.data,

  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) => UpdateProfileResponseModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),

  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),

  };
}

class Data {
  String name;
  String? image;

  Data({
    required this.name,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };
}


