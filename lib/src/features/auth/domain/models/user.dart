import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  String refreshToken;
  String accessToken;
  String email;
  String name;
  int userId;
  String? image;
  Subscription? subscription;
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
            ? Subscription.fromJson(json["subscription"])
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

  UserModel copyWith({
    String? refreshToken,
    String? accessToken,
    String? email,
    String? name,
    int? userId,
    String? image,
    Subscription? subscription,
    bool? isTrialValid,
  }) {
    return UserModel(
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
      email: email ?? this.email,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      image: image ?? this.image,
      subscription: subscription ?? this.subscription,
      isTrialValid: isTrialValid ?? this.isTrialValid,
    );
  }

  static UserModel empty() {
    return UserModel(
      refreshToken: '',
      accessToken: '',
      email: '',
      name: '',
      userId: 0,
      image: null,
      subscription: null,
      isTrialValid: false,
    );
  }
}

class Subscription {
  int? id;
  String subscription;
  bool isActive;
  DateTime paymentDate;
  DateTime expiryDate;
  String amount;
  int subscriptionMapId;

  Subscription({
    required this.id,
    required this.subscription,
    required this.isActive,
    required this.paymentDate,
    required this.expiryDate,
    required this.amount,
    required this.subscriptionMapId,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        subscription: json["subscription"],
        isActive: json["is_active"],
        paymentDate: DateTime.parse(json["payment_date"]),
        expiryDate: DateTime.parse(json["expiry_date"]),
        amount: json["amount"],
        subscriptionMapId: json["subscription_map_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subscription": subscription,
        "is_active": isActive,
        "payment_date":
            "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "expiry_date":
            "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "subscription_map_id": subscriptionMapId,
      };
}

class UserModelProvider extends StateNotifier<UserModel> {
  UserModelProvider() : super(UserModel.empty());

  void setUser(UserModel newUser) {
    authenticationToken = newUser.accessToken;
    state = newUser;
    debugPrint('Authentication token set: $authenticationToken');
  }

  void updateProfileImage(String? imageUrl) {
    state = state.copyWith(image: imageUrl);
    debugPrint('updateProfileImage: ${state.image}');
  }

  void updateSubscription(Subscription newSubscription) {
    state = state.copyWith(subscription: newSubscription);
  }

  void clearUser() {
    state = UserModel.empty();
    authenticationToken = "";
  }

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }

  void updateIsTrialValid(bool isValid) {
    state = state.copyWith(isTrialValid: isValid);
  }

  void updateEmail(String newEmail) {
    state = state.copyWith(email: newEmail);
  }
}
