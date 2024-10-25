import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final categoryQueryProvider = StateProvider<String>((ref) => 'All');
final minPriceQueryProvider = StateProvider<double>((ref) => 0.0);
final maxPriceQueryProvider = StateProvider<double>((ref) => double.infinity);
