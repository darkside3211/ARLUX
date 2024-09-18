import 'package:flutter/material.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/app_bars/jewelry_list_app_bar.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_list/jewelry_grid.dart';

class JewelryListResult extends StatelessWidget {
  final JewelryGrid gridItems;
  const JewelryListResult({super.key, required this.gridItems});

  @override
  Widget build(BuildContext context) {
    String searchQuery = '';
    if (gridItems is JewelrySearchResultsImpl) {
      searchQuery = (gridItems as JewelrySearchResultsImpl).q;
    }

    return Scaffold(
      appBar: JewelryListTopBar(
        searchedText: searchQuery,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: gridItems,
      ),
    );
  }
}
