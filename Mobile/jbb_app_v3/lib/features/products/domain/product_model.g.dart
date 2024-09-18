// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      averageRating: (json['averageRating'] as num).toDouble(),
      lensID: json['lensID'] as String?,
      groupID: json['groupID'] as String?,
      category: json['category'] as String,
      modelUrl: json['modelUrl'] as String?,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'averageRating': instance.averageRating,
      'lensID': instance.lensID,
      'groupID': instance.groupID,
      'category': instance.category,
      'modelUrl': instance.modelUrl,
    };
