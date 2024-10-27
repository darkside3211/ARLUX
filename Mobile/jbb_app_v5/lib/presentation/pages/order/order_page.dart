import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/features/order/data/order_repository.dart';
import 'package:jbb_app_v5/features/order/model/order_model.dart';
import 'package:jbb_app_v5/presentation/pages/order/order_list.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

class OrderPage extends ConsumerStatefulWidget {
  final int tabIndex;
  const OrderPage({
    super.key,
    this.tabIndex = 0,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<OrderModel> orderList = [];

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _tabController.index = widget.tabIndex;
    super.initState();
  }

  List<OrderModel> _getFilteredOrders(String status) {
    return orderList.where((order) => order.orderStatus == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(getOrdersProvider);

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: AppColors.yellow),
        title: Text(
          'My Purchases',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.yellow, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff292929),
        bottom: TabBar(
          isScrollable: true,
          dividerColor: AppColors.yellow,
          indicatorColor: AppColors.yellow,
          labelColor: AppColors.yellow,
          unselectedLabelColor: AppColors.white,
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'All',
            ),
            Tab(
              text: 'To Pay',
            ),
            Tab(
              text: 'To Ship',
            ),
            Tab(
              text: 'To Receive',
            ),
            Tab(
              text: 'Completed',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: orders.when(
          data: (item) {
            setState(() {
              orderList = item;
              orderList.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
            });
            return TabBarView(
              controller: _tabController,
              children: [
                OrderList(orders: orderList),
                OrderList(orders: _getFilteredOrders('toPay')),
                OrderList(orders: _getFilteredOrders('toShip')),
                OrderList(orders: _getFilteredOrders('toReceive')),
                OrderList(orders: _getFilteredOrders('delivered')),
              ],
            );
          },
          error: (err, stack) => IconedFailure(
            message: err.toString(),
            displayIcon: const Icon(Icons.remove_shopping_cart),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
