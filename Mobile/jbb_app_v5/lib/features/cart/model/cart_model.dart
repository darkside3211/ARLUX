import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String lensID;
  final String groupID;
  final String category;
  final double averageRating;
  final List<String> imageUrls;
  final String modelUrl;
  final String cartID;
  final String size;
  final int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.lensID,
    required this.groupID,
    required this.category,
    required this.averageRating,
    required this.imageUrls,
    required this.modelUrl,
    required this.cartID,
    required this.size,
    required this.quantity,
  });

  // Factory constructor to create a CartModel from a JSON map
  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  // Method to convert a CartModel instance to JSON
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
