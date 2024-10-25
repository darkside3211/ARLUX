import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String firebaseUid;
  final String email;
  final String? username;
  final List<AddressModel> addresses;
  final String? phone;
  final List<CartItem> cartItems;
  final List<String> orders;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.firebaseUid,
    required this.email,
    this.username,
    required this.addresses,
    this.phone,
    required this.cartItems,
    required this.orders,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class AddressModel {
  final String addressLabel;
  final String line1;
  final String line2;
  final String city;
  final String state;
  // ignore: non_constant_identifier_names
  final String postal_code;
  final String country;

  AddressModel({
    required this.addressLabel,
    required this.line1,
    required this.line2,
    required this.city,
    required this.state,
    // ignore: non_constant_identifier_names
    required this.postal_code,
    this.country = "PH",
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  // Method to convert a CartModel instance to JSON
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  // Custom toJson specifically for PayMongo, excluding addressLabel
  Map<String, dynamic> toPayMongoJson() {
    final json = _$AddressModelToJson(this);
    json.remove('addressLabel'); // Exclude 'addressLabel' for PayMongo
    return json;
  }
}

@JsonSerializable()
class CartItem {
  final String cartID;
  final String productId;
  final int quantity;
  final String size;

  CartItem({
    required this.cartID,
    required this.productId,
    required this.quantity,
    required this.size,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
