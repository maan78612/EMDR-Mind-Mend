import 'package:emdr_mindmend/src/features/home/domain/models/subscription.dart';

class UserModel {
  String refreshToken;
  String accessToken;
  String email;
  String name;
  int userId;
  String? image;
  SubscriptionModel? subscription;
  bool? isTrialValid;

  UserModel({
    required this.refreshToken,
    required this.accessToken,
    required this.email,
    required this.name,
    required this.userId,
    required this.image,
    required this.subscription,
    required this.isTrialValid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        refreshToken: json["refresh_token"],
        accessToken: json["access_token"],
        email: json["email"],
        name: json["name"],
        userId: json["user_id"],
        image: json["image"],
        subscription: json["subscription"] != null
            ? SubscriptionModel.fromJson(json["subscription"])
            : null,
        isTrialValid: json["isTrialValid"],
      );

  Map<String, dynamic> toJson() => {
        "refresh_token": refreshToken,
        "access_token": accessToken,
        "email": email,
        "name": name,
        "user_id": userId,
        "image": image,
        "subscription": subscription?.toJson(),
        "isTrialValid": isTrialValid,
      };
}


