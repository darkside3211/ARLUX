// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productRemoteRepositoryHash() =>
    r'9a63fdc22c289b85b64d9f7add1088f39f89cda2';

/// See also [productRemoteRepository].
@ProviderFor(productRemoteRepository)
final productRemoteRepositoryProvider =
    AutoDisposeProvider<ProductRemoteRepository>.internal(
  productRemoteRepository,
  name: r'productRemoteRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productRemoteRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductRemoteRepositoryRef
    = AutoDisposeProviderRef<ProductRemoteRepository>;
String _$fetchProductListHash() => r'6b6e099490c21f8762a2d43add275ce1371a3735';

/// See also [fetchProductList].
@ProviderFor(fetchProductList)
final fetchProductListProvider =
    AutoDisposeFutureProvider<List<ProductModel>>.internal(
  fetchProductList,
  name: r'fetchProductListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchProductListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchProductListRef = AutoDisposeFutureProviderRef<List<ProductModel>>;
String _$searchProductListHash() => r'ac32af21649350914fa907dd551a9eeded2c3048';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchProductList].
@ProviderFor(searchProductList)
const searchProductListProvider = SearchProductListFamily();

/// See also [searchProductList].
class SearchProductListFamily extends Family<AsyncValue<SearchProductModel>> {
  /// See also [searchProductList].
  const SearchProductListFamily();

  /// See also [searchProductList].
  SearchProductListProvider call({
    required String q,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) {
    return SearchProductListProvider(
      q: q,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }

  @override
  SearchProductListProvider getProviderOverride(
    covariant SearchProductListProvider provider,
  ) {
    return call(
      q: provider.q,
      category: provider.category,
      minPrice: provider.minPrice,
      maxPrice: provider.maxPrice,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchProductListProvider';
}

/// See also [searchProductList].
class SearchProductListProvider
    extends AutoDisposeFutureProvider<SearchProductModel> {
  /// See also [searchProductList].
  SearchProductListProvider({
    required String q,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) : this._internal(
          (ref) => searchProductList(
            ref as SearchProductListRef,
            q: q,
            category: category,
            minPrice: minPrice,
            maxPrice: maxPrice,
          ),
          from: searchProductListProvider,
          name: r'searchProductListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchProductListHash,
          dependencies: SearchProductListFamily._dependencies,
          allTransitiveDependencies:
              SearchProductListFamily._allTransitiveDependencies,
          q: q,
          category: category,
          minPrice: minPrice,
          maxPrice: maxPrice,
        );

  SearchProductListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.q,
    required this.category,
    required this.minPrice,
    required this.maxPrice,
  }) : super.internal();

  final String q;
  final String? category;
  final double? minPrice;
  final double? maxPrice;

  @override
  Override overrideWith(
    FutureOr<SearchProductModel> Function(SearchProductListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchProductListProvider._internal(
        (ref) => create(ref as SearchProductListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        q: q,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SearchProductModel> createElement() {
    return _SearchProductListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchProductListProvider &&
        other.q == q &&
        other.category == category &&
        other.minPrice == minPrice &&
        other.maxPrice == maxPrice;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, q.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, minPrice.hashCode);
    hash = _SystemHash.combine(hash, maxPrice.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchProductListRef on AutoDisposeFutureProviderRef<SearchProductModel> {
  /// The parameter `q` of this provider.
  String get q;

  /// The parameter `category` of this provider.
  String? get category;

  /// The parameter `minPrice` of this provider.
  double? get minPrice;

  /// The parameter `maxPrice` of this provider.
  double? get maxPrice;
}

class _SearchProductListProviderElement
    extends AutoDisposeFutureProviderElement<SearchProductModel>
    with SearchProductListRef {
  _SearchProductListProviderElement(super.provider);

  @override
  String get q => (origin as SearchProductListProvider).q;
  @override
  String? get category => (origin as SearchProductListProvider).category;
  @override
  double? get minPrice => (origin as SearchProductListProvider).minPrice;
  @override
  double? get maxPrice => (origin as SearchProductListProvider).maxPrice;
}

String _$categorizeProductListHash() =>
    r'3c818adf38ccd7e5b24c8c4f77cac277eb4b7a82';

/// See also [categorizeProductList].
@ProviderFor(categorizeProductList)
const categorizeProductListProvider = CategorizeProductListFamily();

/// See also [categorizeProductList].
class CategorizeProductListFamily
    extends Family<AsyncValue<List<ProductModel>>> {
  /// See also [categorizeProductList].
  const CategorizeProductListFamily();

  /// See also [categorizeProductList].
  CategorizeProductListProvider call({
    required String category,
  }) {
    return CategorizeProductListProvider(
      category: category,
    );
  }

  @override
  CategorizeProductListProvider getProviderOverride(
    covariant CategorizeProductListProvider provider,
  ) {
    return call(
      category: provider.category,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'categorizeProductListProvider';
}

/// See also [categorizeProductList].
class CategorizeProductListProvider
    extends AutoDisposeFutureProvider<List<ProductModel>> {
  /// See also [categorizeProductList].
  CategorizeProductListProvider({
    required String category,
  }) : this._internal(
          (ref) => categorizeProductList(
            ref as CategorizeProductListRef,
            category: category,
          ),
          from: categorizeProductListProvider,
          name: r'categorizeProductListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categorizeProductListHash,
          dependencies: CategorizeProductListFamily._dependencies,
          allTransitiveDependencies:
              CategorizeProductListFamily._allTransitiveDependencies,
          category: category,
        );

  CategorizeProductListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  Override overrideWith(
    FutureOr<List<ProductModel>> Function(CategorizeProductListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategorizeProductListProvider._internal(
        (ref) => create(ref as CategorizeProductListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductModel>> createElement() {
    return _CategorizeProductListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategorizeProductListProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategorizeProductListRef
    on AutoDisposeFutureProviderRef<List<ProductModel>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _CategorizeProductListProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductModel>>
    with CategorizeProductListRef {
  _CategorizeProductListProviderElement(super.provider);

  @override
  String get category => (origin as CategorizeProductListProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
