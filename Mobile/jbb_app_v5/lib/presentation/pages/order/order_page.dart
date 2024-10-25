import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/order/data/order_repository.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/app_bars.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_card.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(getOrdersProvider);
    final authState = ref.watch(authStateProvider);

    Widget buildAuthState() {
      return authState.when(
        data: (user) {
          if (user != null) {
            return orders.when(
              data: (item) {
                if (item.isNotEmpty) {
                  return Column(
                    children: [
                      Column(
                        children: List.generate(
                          item.length,
                          (index) {
                            return OrderTile(
                              orderModel: item[index],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: Text('Order is empty'));
              },
              error: (err, stack) {
                return IconedFailure(
                    message: err.toString(),
                    displayIcon: const Icon(Icons.error));
              },
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            );
          } else {
            return Center(
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                onPressed: () {
                  ref.read(bottomNavIndexProvider.notifier).state = 2;
                },
                child: Text(
                  'Login now',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          }
        },
        error: (err, stack) => IconedFailure(
            message: err.toString(), displayIcon: const Icon(Icons.error)),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const HomeTopBar(isDefault: false),
      body: RefreshIndicator(
        color: Colors.amber,
        onRefresh: () {
          return ref.refresh(getOrdersProvider.future);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Orders",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildAuthState(),
              const SizedBox(height: 8),
              const Divider(height: 32),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
