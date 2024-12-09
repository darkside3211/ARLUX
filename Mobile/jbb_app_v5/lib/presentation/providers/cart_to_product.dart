import 'package:jbb_app_v5/features/cart/model/cart_model.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/features/products/model/product_model.dart';

class ProductToCart {
  final String cartId;
  final SizesModel size;
  final int quantity;
  final ProductModel productModel;

  ProductToCart(
      {required this.productModel,
      required this.cartId,
      required this.size,
      this.quantity = 0});

  CartModel getConvertedCart() {
    return CartModel(
      id: productModel.id,
      name: productModel.name,
      price: productModel.price,
      description: productModel.description,
      lensID: productModel.lensID,
      groupID: productModel.groupID,
      category: productModel.category,
      averageRating: productModel.averageRating,
      imageUrls: productModel.imageUrls,
      modelUrl: productModel.modelUrl,
      soldCount: productModel.soldCount,
      sizes: productModel.sizes,
      stockCount: productModel.stockCount,
      createdAt: productModel.createdAt,
      updatedAt: productModel.updatedAt,
      cartID: cartId,
      size: size,
      quantity: quantity,
    );
  }
}

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
      sizes: [],
      averageRating: cartModel.averageRating,
      imageUrls: cartModel.imageUrls,
      modelUrl: cartModel.modelUrl,
      soldCount: cartModel.soldCount,
      stockCount: cartModel.stockCount,
      createdAt: cartModel.createdAt,
      updatedAt: cartModel.updatedAt,
    );
  }
}

class CartToCheckout {
  final CartModel cartModel;

  CartToCheckout({required this.cartModel});
  
  CheckoutItem getConvertedItem() {
    double finalPrice = cartModel.price + cartModel.size.additionalAmount;
    double totalPrice = finalPrice + (finalPrice * 0.025);
    
    return CheckoutItem(
      productID: cartModel.id,
      name: cartModel.name,
      amount: totalPrice.round(),
      size: cartModel.size.size,
      images: cartModel.imageUrls,
      quantity: cartModel.quantity,
    );
  }
}
