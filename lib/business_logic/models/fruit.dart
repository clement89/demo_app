import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';

class Fruit {
  int id;
  String name;
  List<Vitamins> vitamins;
  List<Sales> sales;

  Fruit(
    this.id,
    this.name,
    this.vitamins,
    this.sales,
  );
  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      json['id'],
      json['name'],
      json['vitamins'],
      json['sales'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'vitamins': vitamins,
      'sales': sales,
    };
  }
}
