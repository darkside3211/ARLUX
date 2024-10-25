import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history_repository.g.dart';

class SearchHistoryRepository {
  Future<void> cacheSearchHistory(List<String> history, String newQuery) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    if (history.isNotEmpty) {
      history.add(newQuery);
      await sharedPrefs.setStringList('cache_search', history);
    } else {
      await sharedPrefs.setStringList('cache_search', [newQuery]);
    }
  }

  Future<List<String>> getSearchHistory() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    List<String>? history = sharedPrefs.getStringList('cache_search');

    if (history != null) {
      return history;
    } else {
      return List.empty();
    }
  }

  Future<void> clearHistory() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.remove('cache_search');
  }

  Future<void> clearSingleHistory(String query) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    List<String>? history = sharedPrefs.getStringList('cache_search');

    if (history != null) {
      history.removeWhere((item) => item == query);
      await sharedPrefs.setStringList('cache_search', history);
    }
  }
}

@riverpod
Future<List<String>> getSearchHistory(GetSearchHistoryRef ref) async {
  return SearchHistoryRepository().getSearchHistory();
}

@riverpod
Future<void> clearHistory(ClearHistoryRef ref) {
  return SearchHistoryRepository().clearHistory();
}

@riverpod
Future<void> clearSingleHistory(ClearSingleHistoryRef ref,
    {required String query}) async {
  await SearchHistoryRepository().clearSingleHistory(query);
}
