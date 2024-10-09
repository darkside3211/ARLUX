import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/features/search/data/search_history_repository.dart';
import 'package:jbb_app_v5/presentation/pages/home/product_listing.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/search/search_page.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';

class SearchPlaceHolder extends ConsumerWidget {
  final bool isDefault;
  const SearchPlaceHolder({super.key, required this.isDefault});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String initialText = ref.watch(searchQueryProvider);

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const SearchPage()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.amber[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              initialText.isEmpty || isDefault
                  ? 'Search Jewelry...'
                  : initialText,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductSearchField extends ConsumerStatefulWidget {
  final String initialText;

  const ProductSearchField({super.key, this.initialText = ""});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductSearchFieldState();
}

class _ProductSearchFieldState extends ConsumerState<ProductSearchField> {
  final TextEditingController _controller = TextEditingController();

  bool _isError = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool _validateInput(String text) {
    if (text.isEmpty) {
      SnackBarFailure(context, message: 'Search query cannot be empty.');
      return true;
    } else if (text.length < 3) {
      SnackBarFailure(context, message: 'Query too short.');
      return true;
    }

    return false;
  }

  void _handleSubmit(String value) {
    setState(() {
      _isError = _validateInput(value);
    });

    if (!_isError) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ProductListing(
            productGrid:
                ProductSearchImpl(q: _controller.text, isScrollable: true),
            queryText: _controller.text,
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialText.isNotEmpty) {
      _controller.text = widget.initialText;
    }
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          autofocus: true,
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.amber.shade50,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.black),
            ),
            labelStyle: const TextStyle(color: AppColors.yellow),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            hintText: 'Search jewelry...',
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(
                        () async {
                          ref.read(searchQueryProvider.notifier).state =
                              value.text;

                          final List<String> currentHistory =
                              await SearchHistoryRepository()
                                  .getSearchHistory();
                          await SearchHistoryRepository()
                              .cacheSearchHistory(currentHistory, value.text);

                          _handleSubmit(value.text);
                        },
                      );
                    },
                    icon: const Icon(Icons.search),
                  )
                : null,
          ),
          onSubmitted: (value) async {
            ref.read(searchQueryProvider.notifier).state = value;

            final List<String> currentHistory =
                await SearchHistoryRepository().getSearchHistory();

            await SearchHistoryRepository()
                .cacheSearchHistory(currentHistory, value);

            _handleSubmit(value);
          },
        );
      },
    );
  }
}
