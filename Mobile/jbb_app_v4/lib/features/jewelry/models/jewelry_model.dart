import 'package:freezed_annotation/freezed_annotation.dart';

part 'jewelry_model.freezed.dart';
part 'jewelry_model.g.dart';

@freezed
class JewelryModel with _$JewelryModel {
  factory JewelryModel({
    required String id,
    required String name,
    required double price,
    required String description,
    required List<String> imageUrls,
    required double averageRating,
    required String lensID,
    required String groupID,
    required String category,
    required String modelUrl,
  }) = _JewelryModel;

  factory JewelryModel.fromJson(Map<String, dynamic> json) =>
      _$JewelryModelFromJson(json);
}
