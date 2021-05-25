class Data {
  String month;
  int value;

  Data(
    this.month,
    this.value,
  );
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      json['month'],
      json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'value': value,
    };
  }
}
