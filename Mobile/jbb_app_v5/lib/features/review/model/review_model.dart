import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final String reviewID;
  final String productID;
  final String userID;
  final String description;
  final int rating;
  final String mediaUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewModel({
    required this.reviewID,
    required this.productID,
    required this.userID,
    required this.description,
    required this.rating,
    required this.mediaUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a ProductModel from a JSON map
  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  // Method to convert a ProductModel instance to JSON
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
