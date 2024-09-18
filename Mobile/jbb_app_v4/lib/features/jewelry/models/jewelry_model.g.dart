// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jewelry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JewelryModelImpl _$$JewelryModelImplFromJson(Map<String, dynamic> json) =>
    _$JewelryModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      averageRating: (json['averageRating'] as num).toDouble(),
      lensID: json['lensID'] as String,
      groupID: json['groupID'] as String,
      category: json['category'] as String,
      modelUrl: json['modelUrl'] as String,
    );

Map<String, dynamic> _$$JewelryModelImplToJson(_$JewelryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'imageUrls': instance.imageUrls,
      'averageRating': instance.averageRating,
      'lensID': instance.lensID,
      'groupID': instance.groupID,
      'category': instance.category,
      'modelUrl': instance.modelUrl,
    };
