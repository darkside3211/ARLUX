// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      reviewID: json['reviewID'] as String,
      productID: json['productID'] as String,
      userID: json['userID'] as String,
      description: json['description'] as String,
      rating: (json['rating'] as num).toInt(),
      mediaUrl: json['mediaUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'reviewID': instance.reviewID,
      'productID': instance.productID,
      'userID': instance.userID,
      'description': instance.description,
      'rating': instance.rating,
      'mediaUrl': instance.mediaUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
