// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      firebaseUid: json['firebaseUid'] as String,
      email: json['email'] as String,
      username: json['username'] as String?,
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      phone: json['phone'] as String?,
      status: json['status'] as String,
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      orders:
          (json['orders'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'firebaseUid': instance.firebaseUid,
      'email': instance.email,
      'username': instance.username,
      'addresses': instance.addresses,
      'phone': instance.phone,
      'status': instance.status,
      'cartItems': instance.cartItems,
      'orders': instance.orders,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      addressLabel: json['addressLabel'] as String,
      line1: json['line1'] as String,
      line2: json['line2'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postal_code: json['postal_code'] as String,
      country: json['country'] as String? ?? "PH",
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'addressLabel': instance.addressLabel,
      'line1': instance.line1,
      'line2': instance.line2,
      'city': instance.city,
      'state': instance.state,
      'postal_code': instance.postal_code,
      'country': instance.country,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      cartID: json['cartID'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      size: SizesModel.fromJson(json['size'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'cartID': instance.cartID,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'size': instance.size,
    };
