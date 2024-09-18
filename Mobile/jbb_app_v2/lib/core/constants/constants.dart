import 'package:flutter/material.dart';
import 'package:jbb_app_v2/features/product_list/model/product_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

const String storeBaseUrl = 'https://fakestoreapi.com/';

ProductModel mockProduct = ProductModel(
  id: 1,
  title: BoneMock.title,
  price: 123123.00,
  description: BoneMock.address,
  category: BoneMock.city,
  image: '',
  rating: {},
);

const List<int> filterLimits = [1, 2, 3, 4, 5];
List<DropdownMenuEntry<int>> filterLimitItems = filterLimits.map((int limit) {
  return DropdownMenuEntry<int>(
    value: limit,
    label: limit.toString(),
  );
}).toList();

const List<String> filterSorts = ['asc', 'desc'];
List<DropdownMenuEntry<String>> filterSortItems =
    filterSorts.map((String sort) {
  return DropdownMenuEntry<String>(
    value: sort,
    label: '${sort}ending',
  );
}).toList();

double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

bool isDark(context) => Theme.of(context).brightness == Brightness.dark;