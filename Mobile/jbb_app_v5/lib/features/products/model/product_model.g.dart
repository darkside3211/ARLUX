// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
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
      soldCount: (json['soldCount'] as num).toInt(),
      stockCount: (json['stockCount'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
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
      'soldCount': instance.soldCount,
      'stockCount': instance.stockCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
