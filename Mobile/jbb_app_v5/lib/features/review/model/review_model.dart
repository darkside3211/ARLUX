import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final String reviewID;
  final String productId;
  final String userId;
  final String username;
  final String description;
  final String rating;
  final List<String> mediaUrls;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewModel({
    required this.reviewID,
    required this.productId,
    required this.userId,
    required this.username,
    required this.description,
    required this.rating,
    required this.mediaUrls,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a ProductModel from a JSON map
  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  // Method to convert a ProductModel instance to JSON
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
