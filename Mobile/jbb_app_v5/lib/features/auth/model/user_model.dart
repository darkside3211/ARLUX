import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String firebaseUid;
  final String username;
  final List<String> cartItems;

  UserModel({
    required this.firebaseUid,
    required this.username,
    required this.cartItems,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // Method to convert a CartModel instance to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
