// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceHash() => r'e771c719cfb4bd87b7f15fc6722ef9f56a9844e4';

/// See also [authService].
@ProviderFor(authService)
final authServiceProvider = AutoDisposeProvider<AuthService>.internal(
  authService,
  name: r'authServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthServiceRef = AutoDisposeProviderRef<AuthService>;
String _$authStateHash() => r'd8eb17123e8971f9b8086bb415a4b2bde52779e2';

/// See also [authState].
@ProviderFor(authState)
final authStateProvider = AutoDisposeStreamProvider<User?>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateRef = AutoDisposeStreamProviderRef<User?>;
String _$addProductToBagHash() => r'755a151d9fd7521fa040aa5200cc150a6fa2a495';

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

/// See also [addProductToBag].
@ProviderFor(addProductToBag)
const addProductToBagProvider = AddProductToBagFamily();

/// See also [addProductToBag].
class AddProductToBagFamily extends Family<AsyncValue<bool>> {
  /// See also [addProductToBag].
  const AddProductToBagFamily();

  /// See also [addProductToBag].
  AddProductToBagProvider call({
    required String productId,
    required int quantity,
    required String size,
  }) {
    return AddProductToBagProvider(
      productId: productId,
      quantity: quantity,
      size: size,
    );
  }

  @override
  AddProductToBagProvider getProviderOverride(
    covariant AddProductToBagProvider provider,
  ) {
    return call(
      productId: provider.productId,
      quantity: provider.quantity,
      size: provider.size,
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
  String? get name => r'addProductToBagProvider';
}

/// See also [addProductToBag].
class AddProductToBagProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addProductToBag].
  AddProductToBagProvider({
    required String productId,
    required int quantity,
    required String size,
  }) : this._internal(
          (ref) => addProductToBag(
            ref as AddProductToBagRef,
            productId: productId,
            quantity: quantity,
            size: size,
          ),
          from: addProductToBagProvider,
          name: r'addProductToBagProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addProductToBagHash,
          dependencies: AddProductToBagFamily._dependencies,
          allTransitiveDependencies:
              AddProductToBagFamily._allTransitiveDependencies,
          productId: productId,
          quantity: quantity,
          size: size,
        );

  AddProductToBagProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.quantity,
    required this.size,
  }) : super.internal();

  final String productId;
  final int quantity;
  final String size;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddProductToBagRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddProductToBagProvider._internal(
        (ref) => create(ref as AddProductToBagRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        quantity: quantity,
        size: size,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddProductToBagProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddProductToBagProvider &&
        other.productId == productId &&
        other.quantity == quantity &&
        other.size == size;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, size.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddProductToBagRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `productId` of this provider.
  String get productId;

  /// The parameter `quantity` of this provider.
  int get quantity;

  /// The parameter `size` of this provider.
  String get size;
}

class _AddProductToBagProviderElement
    extends AutoDisposeFutureProviderElement<bool> with AddProductToBagRef {
  _AddProductToBagProviderElement(super.provider);

  @override
  String get productId => (origin as AddProductToBagProvider).productId;
  @override
  int get quantity => (origin as AddProductToBagProvider).quantity;
  @override
  String get size => (origin as AddProductToBagProvider).size;
}

String _$getBagItemsHash() => r'56c729c43353934d1de5f3de90dea8ab5a065ee2';

/// See also [getBagItems].
@ProviderFor(getBagItems)
final getBagItemsProvider =
    AutoDisposeFutureProvider<List<ProductModel>>.internal(
  getBagItems,
  name: r'getBagItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getBagItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetBagItemsRef = AutoDisposeFutureProviderRef<List<ProductModel>>;
String _$removeBagItemHash() => r'207bf61f00fb4ea8e5427ee4867c6ab00019bdb0';

/// See also [removeBagItem].
@ProviderFor(removeBagItem)
const removeBagItemProvider = RemoveBagItemFamily();

/// See also [removeBagItem].
class RemoveBagItemFamily extends Family<AsyncValue<bool>> {
  /// See also [removeBagItem].
  const RemoveBagItemFamily();

  /// See also [removeBagItem].
  RemoveBagItemProvider call({
    required String productId,
  }) {
    return RemoveBagItemProvider(
      productId: productId,
    );
  }

  @override
  RemoveBagItemProvider getProviderOverride(
    covariant RemoveBagItemProvider provider,
  ) {
    return call(
      productId: provider.productId,
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
  String? get name => r'removeBagItemProvider';
}

/// See also [removeBagItem].
class RemoveBagItemProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [removeBagItem].
  RemoveBagItemProvider({
    required String productId,
  }) : this._internal(
          (ref) => removeBagItem(
            ref as RemoveBagItemRef,
            productId: productId,
          ),
          from: removeBagItemProvider,
          name: r'removeBagItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeBagItemHash,
          dependencies: RemoveBagItemFamily._dependencies,
          allTransitiveDependencies:
              RemoveBagItemFamily._allTransitiveDependencies,
          productId: productId,
        );

  RemoveBagItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(RemoveBagItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveBagItemProvider._internal(
        (ref) => create(ref as RemoveBagItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _RemoveBagItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveBagItemProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RemoveBagItemRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _RemoveBagItemProviderElement
    extends AutoDisposeFutureProviderElement<bool> with RemoveBagItemRef {
  _RemoveBagItemProviderElement(super.provider);

  @override
  String get productId => (origin as RemoveBagItemProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
