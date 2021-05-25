import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';

class Fruit {
  int id;
  String name;
  List<Vitamins> vitamins;
  List<Data> sales;
  List<Data> availabilities;

  Fruit(
    this.id,
    this.name,
    this.vitamins,
    this.sales,
    this.availabilities,
  );
  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      json['id'],
      json['name'],
      json['vitamins'],
      json['sales'],
      json['availabilities'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'vitamins': vitamins,
      'sales': sales,
      'availabilities': availabilities,
    };
  }
}
