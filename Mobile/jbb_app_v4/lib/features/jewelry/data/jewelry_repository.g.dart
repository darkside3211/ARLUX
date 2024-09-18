// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jewelry_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jewelryRepositoryHash() => r'318cabf5343e85962fb996334ce095d72f216460';

/// See also [jewelryRepository].
@ProviderFor(jewelryRepository)
final jewelryRepositoryProvider =
    AutoDisposeProvider<JewelryRepository>.internal(
  jewelryRepository,
  name: r'jewelryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$jewelryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JewelryRepositoryRef = AutoDisposeProviderRef<JewelryRepository>;
String _$fetchJewelryListHash() => r'67139c863ce7a3990c43454f6403f36d9a1396e3';

/// See also [fetchJewelryList].
@ProviderFor(fetchJewelryList)
final fetchJewelryListProvider =
    AutoDisposeFutureProvider<List<JewelryModel>>.internal(
  fetchJewelryList,
  name: r'fetchJewelryListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchJewelryListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchJewelryListRef = AutoDisposeFutureProviderRef<List<JewelryModel>>;
String _$searchJewelryListHash() => r'7908a75dec564afdd1b630731e96add2ef5365ef';

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

/// See also [searchJewelryList].
@ProviderFor(searchJewelryList)
const searchJewelryListProvider = SearchJewelryListFamily();

/// See also [searchJewelryList].
class SearchJewelryListFamily extends Family<AsyncValue<SearchJewelryModel>> {
  /// See also [searchJewelryList].
  const SearchJewelryListFamily();

  /// See also [searchJewelryList].
  SearchJewelryListProvider call({
    required String q,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) {
    return SearchJewelryListProvider(
      q: q,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }

  @override
  SearchJewelryListProvider getProviderOverride(
    covariant SearchJewelryListProvider provider,
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
  String? get name => r'searchJewelryListProvider';
}

/// See also [searchJewelryList].
class SearchJewelryListProvider
    extends AutoDisposeFutureProvider<SearchJewelryModel> {
  /// See also [searchJewelryList].
  SearchJewelryListProvider({
    required String q,
    String? category,
    double? minPrice,
    double? maxPrice,
  }) : this._internal(
          (ref) => searchJewelryList(
            ref as SearchJewelryListRef,
            q: q,
            category: category,
            minPrice: minPrice,
            maxPrice: maxPrice,
          ),
          from: searchJewelryListProvider,
          name: r'searchJewelryListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchJewelryListHash,
          dependencies: SearchJewelryListFamily._dependencies,
          allTransitiveDependencies:
              SearchJewelryListFamily._allTransitiveDependencies,
          q: q,
          category: category,
          minPrice: minPrice,
          maxPrice: maxPrice,
        );

  SearchJewelryListProvider._internal(
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
    FutureOr<SearchJewelryModel> Function(SearchJewelryListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchJewelryListProvider._internal(
        (ref) => create(ref as SearchJewelryListRef),
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
  AutoDisposeFutureProviderElement<SearchJewelryModel> createElement() {
    return _SearchJewelryListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchJewelryListProvider &&
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

mixin SearchJewelryListRef on AutoDisposeFutureProviderRef<SearchJewelryModel> {
  /// The parameter `q` of this provider.
  String get q;

  /// The parameter `category` of this provider.
  String? get category;

  /// The parameter `minPrice` of this provider.
  double? get minPrice;

  /// The parameter `maxPrice` of this provider.
  double? get maxPrice;
}

class _SearchJewelryListProviderElement
    extends AutoDisposeFutureProviderElement<SearchJewelryModel>
    with SearchJewelryListRef {
  _SearchJewelryListProviderElement(super.provider);

  @override
  String get q => (origin as SearchJewelryListProvider).q;
  @override
  String? get category => (origin as SearchJewelryListProvider).category;
  @override
  double? get minPrice => (origin as SearchJewelryListProvider).minPrice;
  @override
  double? get maxPrice => (origin as SearchJewelryListProvider).maxPrice;
}

String _$categorizeJewelryListHash() =>
    r'e259ffc01c2ebb56a63a1fd814ce84dfd18744e2';

/// See also [categorizeJewelryList].
@ProviderFor(categorizeJewelryList)
const categorizeJewelryListProvider = CategorizeJewelryListFamily();

/// See also [categorizeJewelryList].
class CategorizeJewelryListFamily
    extends Family<AsyncValue<List<JewelryModel>>> {
  /// See also [categorizeJewelryList].
  const CategorizeJewelryListFamily();

  /// See also [categorizeJewelryList].
  CategorizeJewelryListProvider call({
    required String category,
  }) {
    return CategorizeJewelryListProvider(
      category: category,
    );
  }

  @override
  CategorizeJewelryListProvider getProviderOverride(
    covariant CategorizeJewelryListProvider provider,
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
  String? get name => r'categorizeJewelryListProvider';
}

/// See also [categorizeJewelryList].
class CategorizeJewelryListProvider
    extends AutoDisposeFutureProvider<List<JewelryModel>> {
  /// See also [categorizeJewelryList].
  CategorizeJewelryListProvider({
    required String category,
  }) : this._internal(
          (ref) => categorizeJewelryList(
            ref as CategorizeJewelryListRef,
            category: category,
          ),
          from: categorizeJewelryListProvider,
          name: r'categorizeJewelryListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categorizeJewelryListHash,
          dependencies: CategorizeJewelryListFamily._dependencies,
          allTransitiveDependencies:
              CategorizeJewelryListFamily._allTransitiveDependencies,
          category: category,
        );

  CategorizeJewelryListProvider._internal(
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
    FutureOr<List<JewelryModel>> Function(CategorizeJewelryListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategorizeJewelryListProvider._internal(
        (ref) => create(ref as CategorizeJewelryListRef),
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
  AutoDisposeFutureProviderElement<List<JewelryModel>> createElement() {
    return _CategorizeJewelryListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategorizeJewelryListProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategorizeJewelryListRef
    on AutoDisposeFutureProviderRef<List<JewelryModel>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _CategorizeJewelryListProviderElement
    extends AutoDisposeFutureProviderElement<List<JewelryModel>>
    with CategorizeJewelryListRef {
  _CategorizeJewelryListProviderElement(super.provider);

  @override
  String get category => (origin as CategorizeJewelryListProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
