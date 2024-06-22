class User {
  int? id;

  DateTime? createdAt;

  User({this.id, this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['created_at'] = createdAt;
    return data;
  }
}
