class SubscriptionModel {
  String name;
  String description;
  double amount;
  String duration;

  SubscriptionModel({
    required this.name,
    required this.description,
    required this.amount,
    required this.duration,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        name: json["name"],
        description: json["description"],
        amount: json["amount"]?.toDouble(),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "amount": amount,
        "duration": duration,
      };
}
