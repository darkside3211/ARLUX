import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v3/features/products/data/remote_product_data_source.dart';
import 'package:jbb_app_v3/features/products/domain/product_model.dart';
import 'package:jbb_app_v3/features/products/presentation/widgets/app_bars.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jbb_app_v3/features/products/presentation/widgets/product_card.dart';
class ProductListPage extends ConsumerStatefulWidget {
  const ProductListPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductListPageState();
}

class _ProductListPageState extends ConsumerState<ProductListPage> {
  AppBars appBars = AppBars();

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ProductModel>> productList =
        ref.watch(remoteProductDataSourceProvider);

    return Scaffold(
      appBar: appBars.appBarWithSearchBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          dynamic result =
              await ref.refresh(remoteProductDataSourceProvider.future);
          return result;
        },
        child: productList.when(
          data: (data) {
            if (data.isNotEmpty) {
              return MasonryGridView.builder(
                padding: const EdgeInsets.all(8),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return productCard(productModel: data[index], context);
                },
              );
            } else {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.warning, size: 36),
                  Text(
                    "Empty Results...",
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              );
            }
          },
          error: (error, stackTrace) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        return ref.refresh(remoteProductDataSourceProvider);
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 36,
                      )),
                  Text(error.toString()),
                ],
              ),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
