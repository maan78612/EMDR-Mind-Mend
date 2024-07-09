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
}

class Subscription {
  int id;
  String subscription;
  bool isActive;
  DateTime paymentDate;
  DateTime expiryDate;

  Subscription({
    required this.id,
    required this.subscription,
    required this.isActive,
    required this.paymentDate,
    required this.expiryDate,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        subscription: json["subscription"],
        isActive: json["is_active"],
        paymentDate: DateTime.parse(json["payment_date"]),
        expiryDate: DateTime.parse(json["expiry_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subscription": subscription,
        "is_active": isActive,
        "payment_date":
            "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "expiry_date":
            "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
      };
}
