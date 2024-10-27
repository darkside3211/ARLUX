// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      reviewID: json['reviewID'] as String,
      productId: json['productId'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      description: json['description'] as String,
      rating: json['rating'] as String,
      mediaUrls:
          (json['mediaUrls'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'reviewID': instance.reviewID,
      'productId': instance.productId,
      'userId': instance.userId,
      'username': instance.username,
      'description': instance.description,
      'rating': instance.rating,
      'mediaUrls': instance.mediaUrls,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
