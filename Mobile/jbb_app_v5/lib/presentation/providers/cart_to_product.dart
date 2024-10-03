import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';

class CartToProduct {
  final CartModel cartModel;

  CartToProduct({required this.cartModel});

  ProductModel getConvertedProduct() {
    return ProductModel(
      id: cartModel.id,
      name: cartModel.name,
      price: cartModel.price,
      description: cartModel.description,
      lensID: cartModel.lensID,
      groupID: cartModel.groupID,
      category: cartModel.category,
      averageRating: cartModel.averageRating,
      imageUrls: cartModel.imageUrls,
      modelUrl: cartModel.modelUrl,
    );
  }
}
