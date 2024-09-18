import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v4/common/widgets/failure_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jbb_app_v4/features/jewelry/data/jewelry_repository.dart';
import 'package:jbb_app_v4/features/jewelry/models/jewelry_model.dart';
import 'package:jbb_app_v4/features/jewelry/models/search_jewelry_model.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_list/jewelry_card.dart';

abstract class JewelryGrid extends Widget {
  final bool isScrollable;
  const JewelryGrid({super.key, required this.isScrollable});
}

class JewelryListsImpl extends ConsumerWidget implements JewelryGrid {
  @override
  final bool isScrollable;

  const JewelryListsImpl({super.key, required this.isScrollable});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<JewelryModel>> allJewelries =
        ref.watch(fetchJewelryListProvider);

    return allJewelries.when(
      data: (data) {
        if (data.isNotEmpty) {
          return MasonryGridView.builder(
            shrinkWrap: !isScrollable,
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return JewelryCard(jewelryModel: data[index]);
            },
          );
        } else {
          return FailureWidget().iconedFailure(context, "No Jewelries Found.");
        }
      },
      error: (error, stackTrace) {
        return FailureWidget().iconedFailure(context, stackTrace.toString());
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class JewelrySearchResultsImpl extends ConsumerWidget implements JewelryGrid {
  @override
  final bool isScrollable;
  final bool isRecommendation;
  final String q;
  final String? category;
  final double? minPrice;
  final double? maxPrice;

  const JewelrySearchResultsImpl({
    super.key,
    required this.isScrollable,
    this.isRecommendation = false,
    required this.q,
    this.category,
    this.minPrice,
    this.maxPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SearchJewelryModel> jewelryResults = ref.watch(
      searchJewelryListProvider(
        q: q,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    );
    return jewelryResults.when(
      data: (data) {
        final List<JewelryModel> jewelries = data.results;

        if (jewelries.isNotEmpty) {
          return MasonryGridView.builder(
            shrinkWrap: !isScrollable,
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: isRecommendation ? jewelries.length - 1 : jewelries.length,
            itemBuilder: (context, index) {
              if (isRecommendation) {
                return JewelryCard(jewelryModel: jewelries[index + 1]);
              } else {
                return JewelryCard(jewelryModel: jewelries[index]);
              }
            },
          );
        } else {
          return FailureWidget().iconedFailure(context, "No Jewelries Found.");
        }
      },
      error: (error, stackTrace) {
        return FailureWidget().iconedFailure(context, error.toString());
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class CategorizeJewelryListImpl extends ConsumerWidget implements JewelryGrid {
  final String category;

  @override
  final bool isScrollable;

  const CategorizeJewelryListImpl({
    super.key,
    required this.category,
    required this.isScrollable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<JewelryModel>> allJewelries =
        ref.watch(categorizeJewelryListProvider(category: category));
    return allJewelries.when(
      data: (data) {
        if (data.isNotEmpty) {
          return MasonryGridView.builder(
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            shrinkWrap: !isScrollable,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return JewelryCard(jewelryModel: data[index]);
            },
          );
        } else {
          return FailureWidget().iconedFailure(context, "No Jewelries Found.");
        }
      },
      error: (error, stackTrace) {
        return FailureWidget().iconedFailure(context, stackTrace.toString());
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
