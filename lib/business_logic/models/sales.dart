class Sales {
  String month;
  int value;

  Sales(
    this.month,
    this.value,
  );
  factory Sales.fromJson(Map<String, dynamic> json) {
    return Sales(
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
