// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      checkoutID: json['checkoutID'] as String,
      userID: json['userID'] as String,
      productItems: (json['productItems'] as List<dynamic>)
          .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderStatus: json['orderStatus'] as String,
      referenceNumber: json['referenceNumber'] as String,
      deliveryAmount: (json['deliveryAmount'] as num).toDouble(),
      checkoutUrl: json['checkoutUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'checkoutID': instance.checkoutID,
      'userID': instance.userID,
      'productItems': instance.productItems,
      'orderStatus': instance.orderStatus,
      'referenceNumber': instance.referenceNumber,
      'deliveryAmount': instance.deliveryAmount,
      'checkoutUrl': instance.checkoutUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      productID: json['productID'] as String,
      quantity: (json['quantity'] as num).toInt(),
      size: json['size'] as String,
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'productID': instance.productID,
      'quantity': instance.quantity,
      'size': instance.size,
    };

CheckoutItem _$CheckoutItemFromJson(Map<String, dynamic> json) => CheckoutItem(
      productID: json['productID'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toInt(),
      size: json['size'] as String,
      quantity: (json['quantity'] as num).toInt(),
      currency: json['currency'] as String? ?? "PHP",
    );

Map<String, dynamic> _$CheckoutItemToJson(CheckoutItem instance) =>
    <String, dynamic>{
      'productID': instance.productID,
      'name': instance.name,
      'amount': instance.amount,
      'quantity': instance.quantity,
      'size': instance.size,
      'currency': instance.currency,
    };
