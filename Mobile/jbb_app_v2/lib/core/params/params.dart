class ProductParams {
  final String id;

  const ProductParams({required this.id});
}


String priceBuild(double price) {
  return "₱${price.toStringAsFixed(2)}";
}