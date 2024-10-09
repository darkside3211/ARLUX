import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/features/search/data/search_history_repository.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_search_field.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        title: const ProductSearchField(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const HistoryList(),
            const Divider(),
            ListTile(
              onTap: () {
                setState(() {
                  ref.read(clearHistoryProvider);
                  // ignore: unused_result
                  ref.refresh(getSearchHistoryProvider);
                });
              },
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Clear Search History ',
                    style: TextStyle(fontSize: 12),
                  ),
                  Icon(
                    Icons.delete,
                    size: 12,
                  ),
                ],
              ),
            ),
            const Divider(),
            
          ],
        ),
      ),
    );
  }
}

class HistoryList extends ConsumerStatefulWidget {
  const HistoryList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryListState();
}

class _HistoryListState extends ConsumerState<HistoryList> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<String>> searchHistory =
        ref.watch(getSearchHistoryProvider);
    return searchHistory.when(
      data: (search) {
        if (search.isNotEmpty) {
          return Column(
            children: List.generate(
              search.length,
              (index) {
                return ListTile(
                  title: Text(
                    search[index],
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          ref.read(
                              clearSingleHistoryProvider(query: search[index]));
                          // ignore: unused_result
                          ref.refresh(getSearchHistoryProvider);
                        });
                      },
                      icon: const Icon(
                        Icons.clear_rounded,
                        size: 12,
                      )),
                );
              },
            ),
          );
        }

        return const Center(
          child: Text('No previous searches...'),
        );
      },
      error: (err, stack) => IconedFailure(
          message: err.toString(), displayIcon: const Icon(Icons.warning)),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.amber,
        ),
      ),
    );
  }
}
