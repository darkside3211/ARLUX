// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getProductListHash() => r'a9f6eb7f26a972f00beefeef4066806b8a82082e';

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

/// See also [getProductList].
@ProviderFor(getProductList)
const getProductListProvider = GetProductListFamily();

/// See also [getProductList].
class GetProductListFamily extends Family<AsyncValue<List<ProductModel>>> {
  /// See also [getProductList].
  const GetProductListFamily();

  /// See also [getProductList].
  GetProductListProvider call({
    String? sorted,
    int? limited,
    String? category,
  }) {
    return GetProductListProvider(
      sorted: sorted,
      limited: limited,
      category: category,
    );
  }

  @override
  GetProductListProvider getProviderOverride(
    covariant GetProductListProvider provider,
  ) {
    return call(
      sorted: provider.sorted,
      limited: provider.limited,
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
  String? get name => r'getProductListProvider';
}

/// See also [getProductList].
class GetProductListProvider
    extends AutoDisposeFutureProvider<List<ProductModel>> {
  /// See also [getProductList].
  GetProductListProvider({
    String? sorted,
    int? limited,
    String? category,
  }) : this._internal(
          (ref) => getProductList(
            ref as GetProductListRef,
            sorted: sorted,
            limited: limited,
            category: category,
          ),
          from: getProductListProvider,
          name: r'getProductListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProductListHash,
          dependencies: GetProductListFamily._dependencies,
          allTransitiveDependencies:
              GetProductListFamily._allTransitiveDependencies,
          sorted: sorted,
          limited: limited,
          category: category,
        );

  GetProductListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sorted,
    required this.limited,
    required this.category,
  }) : super.internal();

  final String? sorted;
  final int? limited;
  final String? category;

  @override
  Override overrideWith(
    FutureOr<List<ProductModel>> Function(GetProductListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProductListProvider._internal(
        (ref) => create(ref as GetProductListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sorted: sorted,
        limited: limited,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductModel>> createElement() {
    return _GetProductListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProductListProvider &&
        other.sorted == sorted &&
        other.limited == limited &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sorted.hashCode);
    hash = _SystemHash.combine(hash, limited.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetProductListRef on AutoDisposeFutureProviderRef<List<ProductModel>> {
  /// The parameter `sorted` of this provider.
  String? get sorted;

  /// The parameter `limited` of this provider.
  int? get limited;

  /// The parameter `category` of this provider.
  String? get category;
}

class _GetProductListProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductModel>>
    with GetProductListRef {
  _GetProductListProviderElement(super.provider);

  @override
  String? get sorted => (origin as GetProductListProvider).sorted;
  @override
  int? get limited => (origin as GetProductListProvider).limited;
  @override
  String? get category => (origin as GetProductListProvider).category;
}

String _$getCategoryListHash() => r'8d56949ed62e1d9772445f3c82f288ca2c97b09b';

/// See also [getCategoryList].
@ProviderFor(getCategoryList)
final getCategoryListProvider =
    AutoDisposeFutureProvider<List<dynamic>>.internal(
  getCategoryList,
  name: r'getCategoryListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCategoryListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCategoryListRef = AutoDisposeFutureProviderRef<List<dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
