// To parse this JSON data, do
//
//     final updateProfileResponseModel = updateProfileResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponseModel updateProfileResponseModelFromJson(String str) =>
    UpdateProfileResponseModel.fromJson(json.decode(str));

String updateProfileResponseModelToJson(UpdateProfileResponseModel data) =>
    json.encode(data.toJson());

class UpdateProfileResponseModel {
  String message;
  Data data;

  UpdateProfileResponseModel({
    required this.message,
    required this.data,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseModel(
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
  String? country;
  String? dob;

  Data({
    required this.name,
    required this.image,
    required this.country,
    required this.dob,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        image: json["image"],
        country: json["country"],
        dob: json["date_of_birth"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "country": country,
        "date_of_birth": dob,
      };
}
