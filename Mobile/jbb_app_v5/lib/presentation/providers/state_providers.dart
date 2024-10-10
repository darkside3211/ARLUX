import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/search/model/filter_state.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
final selectedProductIdProvider = StateProvider<String>((ref) => '');
final bagItemCountProvider = StateProvider<int>((ref) => 0);
final ordersItemCountProvider = StateProvider<int>((ref) => 0);
final searchQueryProvider = StateProvider<String>((ref) => '');
final subTotalPriceProvider = StateProvider<double>((ref) => 0.0);
final filterStateProvider = StateProvider((ref) => FilterState());
