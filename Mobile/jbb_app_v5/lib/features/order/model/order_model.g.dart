// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      orderID: json['orderID'] as String,
      checkoutID: json['checkoutID'] as String,
      productItems: (json['productItems'] as List<dynamic>)
          .map((e) => CheckoutItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderStatus: json['orderStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderID': instance.orderID,
      'checkoutID': instance.checkoutID,
      'productItems': instance.productItems,
      'orderStatus': instance.orderStatus,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

CheckoutItem _$CheckoutItemFromJson(Map<String, dynamic> json) => CheckoutItem(
      name: json['name'] as String,
      amount: (json['amount'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      currency: json['currency'] as String? ?? "PHP",
    );

Map<String, dynamic> _$CheckoutItemToJson(CheckoutItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'quantity': instance.quantity,
      'currency': instance.currency,
    };
