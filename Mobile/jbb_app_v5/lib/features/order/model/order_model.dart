import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String checkoutID;
  final String userID;
  final List<ProductItem> productItems;
  final String orderStatus;
  final String referenceNumber;
  final double deliveryAmount;
  final String? checkoutUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.checkoutID,
    required this.userID,
    required this.productItems,
    required this.orderStatus,
    required this.referenceNumber,
    required this.deliveryAmount,
    this.checkoutUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // A factory constructor to create OrderModel from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  // A method to convert OrderModel to JSON
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class ProductItem {
  final String productID;
  final String name;
  final int quantity;
  final List<String>? images;
  final String size;
  final double amount;

  ProductItem({
    required this.productID,
    required this.name,
    this.images,
    required this.quantity,
    required this.size,
    required this.amount,
  });

  // A factory constructor to create ProductItem from JSON
  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  // A method to convert ProductItem to JSON
  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}

@JsonSerializable()
class CheckoutItem {
  final String productID;
  final String name;
  final int amount;
  final int quantity;
  final String size;
  final String currency;
  final List<String>? images;

  const CheckoutItem({
    required this.productID,
    required this.name,
    required this.amount,
    required this.size,
    required this.quantity,
    this.currency = "PHP",
    this.images,
  });

  factory CheckoutItem.fromJson(Map<String, dynamic> json) =>
      _$CheckoutItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutItemToJson(this);
}
