import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v2/features/product_list/presentation/widgets/icon_widgets.dart';
import 'package:jbb_app_v2/features/product_list/provider/product_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<dynamic>> categoryList =
        ref.watch(getCategoryListProvider);
    return Scaffold(
      appBar: titleAppBar(context),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: <Widget>[
            const SizedBox(
              height: 256,
              child: Placeholder(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: categoryList.when(
                data: (data) {
                  if (data.isNotEmpty) {
                    return ListView.separated(
                        padding: const EdgeInsets.all(12),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            avatarIcon(context, title: data[index]),
                        separatorBuilder: (context, index) =>
                            const VerticalDivider(
                              width: 16,
                            ),
                        itemCount: data.length);
                  } else {
                    return showIconError(
                        symbol: const Icon(Icons.refresh), message: '...');
                  }
                },
                error: (error, stackTrace) {
                  return showIconError(
                      symbol: const Icon(Icons.error),
                      message: error.toString());
                },
                loading: () {
                  return showIconError(
                      symbol: const CircularProgressIndicator(),
                      message: 'Loading...');
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Featured',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }
}
