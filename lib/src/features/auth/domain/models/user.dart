class User {
  String? refreshToken;

  String? accessToken;

  User({this.refreshToken, this.accessToken});

  User.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refresh_token'];

    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['refresh_token'] = refreshToken;
    data['access_token'] = accessToken;
    return data;
  }
}
