// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      firebaseUid: json['firebaseUid'] as String,
      username: json['username'] as String,
      cartItems:
          (json['cartItems'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'firebaseUid': instance.firebaseUid,
      'username': instance.username,
      'cartItems': instance.cartItems,
    };
