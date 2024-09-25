import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

final selectedProductIdProvider = StateProvider<String>((ref) => '');

final bagItemCountProvider = StateProvider<int>((ref) => 0);