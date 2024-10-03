class FilterState {
  final String searchQuery;
  final double minPrice;
  final double maxPrice;
  final String category;

  FilterState({
    this.searchQuery = '',
    this.minPrice = 0.0,
    this.maxPrice = double.infinity,
    this.category = 'All',
  });

  // Create a copy of the current state with new values
  FilterState copyWith({
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    String? category,
  }) {
    return FilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      category: category ?? this.category,
    );
  }
}
