class Vitamins {
  String name;
  int value;

  Vitamins(
    this.name,
    this.value,
  );
  factory Vitamins.fromJson(Map<String, dynamic> json) {
    return Vitamins(
      json['name'],
      json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}
