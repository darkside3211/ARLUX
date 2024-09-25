// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      firebaseUid: json['firebaseUid'] as String,
      username: json['username'] as String,
      cartItems:
          (json['cartItems'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'firebaseUid': instance.firebaseUid,
      'username': instance.username,
      'cartItems': instance.cartItems,
    };
