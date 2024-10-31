



import 'package:admin/models/nutitionmodel.dart';

class Product {
   String ?id;
  String? name;
  String?desc;
  double?qty;
  String? unitName;
  String? unitValue;
  List<String>? image;
   String?nutritionweight;
  String? Cat;
  double? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<NutritionModel>?nutrition;
  Product({
    this.id,
    this.name,
    this.unitName,
    this.unitValue,
    this.image,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.desc,
     this.Cat,
    this.qty,
    this.nutritionweight,
    this.nutrition,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      unitName: json['unit_name'],
      unitValue: json['unit_value'],
      image: List<String>.from(json['Image']),
      price: json['price'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      desc: json['details'],
      updatedAt: DateTime.parse(json['updatedAt']),
      Cat:json['category'],
        qty:json['qty'],
        nutritionweight:json['nutritionweight'],
       nutrition: (json['nutriion'] as List<dynamic>).cast<Map<String,dynamic>>().map((e)=>NutritionModel.fromJson(e)).toList(),


    );
  }
}
