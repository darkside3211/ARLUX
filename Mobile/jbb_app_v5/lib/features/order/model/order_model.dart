import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String orderID;
  final String checkoutID;
  final List<CheckoutItem> productItems;
  final String orderStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderModel({
    required this.orderID,
    required this.checkoutID,
    required this.productItems,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class CheckoutItem {
  final String name;
  final int amount;
  final int quantity;
  final String currency;

  const CheckoutItem({
    required this.name,
    required this.amount,
    required this.quantity,
    this.currency = "PHP",
  });

  factory CheckoutItem.fromJson(Map<String, dynamic> json) =>
      _$CheckoutItemFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutItemToJson(this);
}
