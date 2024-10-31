

import 'package:admin/models/Orderproducts.dart';

import 'Product.dart';

class Order {
  String id;
  String userId;
  int discount;
  double totalPrice;
  String deliveryType;
  double userPayPrice;
  double deliveryPrice;
  String paymentType;
  String paymentStatus;
  String orderStatus;
  String? addressId;
  List<String>Items;
  String Image;
  String? address;
  String? city;
  String? state;

  String? postalcode;
  DateTime createdAt;
  DateTime updatedAt;


  Order({
    this.address,
     this.city,
     this.state,
     this.postalcode,

    required this.id,
    required this.userId,
    required this.discount,
    required this.totalPrice,
    required this.deliveryType,
    required this.userPayPrice,
    required this.deliveryPrice,
    required this.paymentType,
    required this.paymentStatus,
    required this.orderStatus,
    this.addressId,
    required this.Image,

    required this.Items,
    required this.createdAt,
    required this.updatedAt,

  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      discount:json['discountPrice'],
      totalPrice: json['total_price'].toDouble(),
      deliveryType: json['delivery_type'],
      userPayPrice: json['user_pay_price'].toDouble(),
      deliveryPrice: json['delivery_price'].toDouble(),
      paymentType: json['payment_type'],
      paymentStatus: json['payment_status'],
      orderStatus: json['order_status'],
      addressId: json['address_id'],
      Image :json['firstproductImage'],
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      Items:  List<String>.from(json['productnames']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      postalcode: json['postalcode'],





    );
  }


}

