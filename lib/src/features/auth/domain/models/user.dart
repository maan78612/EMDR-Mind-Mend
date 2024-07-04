class UserData {
  String refreshToken;
  String accessToken;
  String email;
  String username;
  String? image;
  int userId;

  UserData({
    required this.refreshToken,
    required this.accessToken,
    required this.email,
    required this.username,
    required this.image,
    required this.userId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        refreshToken: json["refresh_token"],
        accessToken: json["access_token"],
        email: json["email"],
        username: json["username"],
        image: json["image"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "refresh_token": refreshToken,
        "access_token": accessToken,
        "email": email,
        "username": username,
        "image": image,
        "user_id": userId,
      };
}
