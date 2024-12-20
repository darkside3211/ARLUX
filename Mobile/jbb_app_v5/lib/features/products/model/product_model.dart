import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
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
  final List<SizesModel> sizes;
  final int soldCount;
  final int stockCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.lensID,
    required this.groupID,
    required this.category,
    required this.sizes,
    required this.averageRating,
    required this.imageUrls,
    required this.modelUrl,
    required this.soldCount,
    required this.stockCount,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a ProductModel from a JSON map
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  // Method to convert a ProductModel instance to JSON
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class SizesModel {
  final String size;
  final double additionalAmount;
  final int quantity;

  SizesModel({
      required this.size,
      required this.additionalAmount,
      required this.quantity,
  });

  // Factory constructor to create a SizesModel from a JSON map
  factory SizesModel.fromJson(Map<String, dynamic> json) =>
      _$SizesModelFromJson(json);

  // Method to convert a SizesModel instance to JSON
  Map<String, dynamic> toJson() => _$SizesModelToJson(this);
}
