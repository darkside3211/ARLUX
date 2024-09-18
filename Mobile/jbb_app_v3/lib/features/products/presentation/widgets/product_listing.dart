import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v3/features/products/domain/product_model.dart';

class ProductListing extends ConsumerWidget {
  final dynamic providerImpl;

  const ProductListing({super.key, required this.providerImpl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ProductModel>> productList = ref.watch(providerImpl);

    return Container();
  }
}
