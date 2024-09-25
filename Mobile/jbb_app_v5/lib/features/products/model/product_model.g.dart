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
      lensID: json['lensID'] as String,
      groupID: json['groupID'] as String,
      category: json['category'] as String,
      averageRating: (json['averageRating'] as num).toDouble(),
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      modelUrl: json['modelUrl'] as String,
      quantity: (json['quantity'] as num?)?.toInt(),
      size: json['size'] as String?,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'lensID': instance.lensID,
      'groupID': instance.groupID,
      'category': instance.category,
      'averageRating': instance.averageRating,
      'imageUrls': instance.imageUrls,
      'modelUrl': instance.modelUrl,
      'quantity': instance.quantity,
      'size': instance.size,
    };
