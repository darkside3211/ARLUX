// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartRepositoryHash() => r'b28615442f9cdf5a3ee149f4a1c2552ef9b49319';

/// See also [cartRepository].
@ProviderFor(cartRepository)
final cartRepositoryProvider = AutoDisposeProvider<CartRepository>.internal(
  cartRepository,
  name: r'cartRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartRepositoryRef = AutoDisposeProviderRef<CartRepository>;
String _$addToBagHash() => r'dc22f343a982fe39cdd072e63d146f0065ac3c5d';

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

/// See also [addToBag].
@ProviderFor(addToBag)
const addToBagProvider = AddToBagFamily();

/// See also [addToBag].
class AddToBagFamily extends Family<AsyncValue<bool>> {
  /// See also [addToBag].
  const AddToBagFamily();

  /// See also [addToBag].
  AddToBagProvider call({
    required String productID,
    required String size,
    required int quantity,
  }) {
    return AddToBagProvider(
      productID: productID,
      size: size,
      quantity: quantity,
    );
  }

  @override
  AddToBagProvider getProviderOverride(
    covariant AddToBagProvider provider,
  ) {
    return call(
      productID: provider.productID,
      size: provider.size,
      quantity: provider.quantity,
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
  String? get name => r'addToBagProvider';
}

/// See also [addToBag].
class AddToBagProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addToBag].
  AddToBagProvider({
    required String productID,
    required String size,
    required int quantity,
  }) : this._internal(
          (ref) => addToBag(
            ref as AddToBagRef,
            productID: productID,
            size: size,
            quantity: quantity,
          ),
          from: addToBagProvider,
          name: r'addToBagProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addToBagHash,
          dependencies: AddToBagFamily._dependencies,
          allTransitiveDependencies: AddToBagFamily._allTransitiveDependencies,
          productID: productID,
          size: size,
          quantity: quantity,
        );

  AddToBagProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productID,
    required this.size,
    required this.quantity,
  }) : super.internal();

  final String productID;
  final String size;
  final int quantity;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddToBagRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddToBagProvider._internal(
        (ref) => create(ref as AddToBagRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productID: productID,
        size: size,
        quantity: quantity,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddToBagProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddToBagProvider &&
        other.productID == productID &&
        other.size == size &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productID.hashCode);
    hash = _SystemHash.combine(hash, size.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddToBagRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `productID` of this provider.
  String get productID;

  /// The parameter `size` of this provider.
  String get size;

  /// The parameter `quantity` of this provider.
  int get quantity;
}

class _AddToBagProviderElement extends AutoDisposeFutureProviderElement<bool>
    with AddToBagRef {
  _AddToBagProviderElement(super.provider);

  @override
  String get productID => (origin as AddToBagProvider).productID;
  @override
  String get size => (origin as AddToBagProvider).size;
  @override
  int get quantity => (origin as AddToBagProvider).quantity;
}

String _$getBagItemsHash() => r'3ac770c9ef729c610511ab421a2adc73506a9a22';

/// See also [getBagItems].
@ProviderFor(getBagItems)
final getBagItemsProvider = AutoDisposeFutureProvider<List<CartModel>>.internal(
  getBagItems,
  name: r'getBagItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getBagItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetBagItemsRef = AutoDisposeFutureProviderRef<List<CartModel>>;
String _$removeBagItemsHash() => r'9404abe36aa55650943fc93c1e5bb7c89a5758cd';

/// See also [removeBagItems].
@ProviderFor(removeBagItems)
const removeBagItemsProvider = RemoveBagItemsFamily();

/// See also [removeBagItems].
class RemoveBagItemsFamily extends Family<AsyncValue<bool>> {
  /// See also [removeBagItems].
  const RemoveBagItemsFamily();

  /// See also [removeBagItems].
  RemoveBagItemsProvider call({
    required List<String> cartIDs,
  }) {
    return RemoveBagItemsProvider(
      cartIDs: cartIDs,
    );
  }

  @override
  RemoveBagItemsProvider getProviderOverride(
    covariant RemoveBagItemsProvider provider,
  ) {
    return call(
      cartIDs: provider.cartIDs,
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
  String? get name => r'removeBagItemsProvider';
}

/// See also [removeBagItems].
class RemoveBagItemsProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [removeBagItems].
  RemoveBagItemsProvider({
    required List<String> cartIDs,
  }) : this._internal(
          (ref) => removeBagItems(
            ref as RemoveBagItemsRef,
            cartIDs: cartIDs,
          ),
          from: removeBagItemsProvider,
          name: r'removeBagItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeBagItemsHash,
          dependencies: RemoveBagItemsFamily._dependencies,
          allTransitiveDependencies:
              RemoveBagItemsFamily._allTransitiveDependencies,
          cartIDs: cartIDs,
        );

  RemoveBagItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cartIDs,
  }) : super.internal();

  final List<String> cartIDs;

  @override
  Override overrideWith(
    FutureOr<bool> Function(RemoveBagItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveBagItemsProvider._internal(
        (ref) => create(ref as RemoveBagItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cartIDs: cartIDs,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _RemoveBagItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveBagItemsProvider && other.cartIDs == cartIDs;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cartIDs.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RemoveBagItemsRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `cartIDs` of this provider.
  List<String> get cartIDs;
}

class _RemoveBagItemsProviderElement
    extends AutoDisposeFutureProviderElement<bool> with RemoveBagItemsRef {
  _RemoveBagItemsProviderElement(super.provider);

  @override
  List<String> get cartIDs => (origin as RemoveBagItemsProvider).cartIDs;
}

String _$editBagItemHash() => r'b8fbf0d76c2a442fe5abde4fed8f342cebe27bf2';

/// See also [editBagItem].
@ProviderFor(editBagItem)
const editBagItemProvider = EditBagItemFamily();

/// See also [editBagItem].
class EditBagItemFamily extends Family<AsyncValue<bool>> {
  /// See also [editBagItem].
  const EditBagItemFamily();

  /// See also [editBagItem].
  EditBagItemProvider call({
    required String cartID,
    required String newSize,
    required int newQuantity,
  }) {
    return EditBagItemProvider(
      cartID: cartID,
      newSize: newSize,
      newQuantity: newQuantity,
    );
  }

  @override
  EditBagItemProvider getProviderOverride(
    covariant EditBagItemProvider provider,
  ) {
    return call(
      cartID: provider.cartID,
      newSize: provider.newSize,
      newQuantity: provider.newQuantity,
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
  String? get name => r'editBagItemProvider';
}

/// See also [editBagItem].
class EditBagItemProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [editBagItem].
  EditBagItemProvider({
    required String cartID,
    required String newSize,
    required int newQuantity,
  }) : this._internal(
          (ref) => editBagItem(
            ref as EditBagItemRef,
            cartID: cartID,
            newSize: newSize,
            newQuantity: newQuantity,
          ),
          from: editBagItemProvider,
          name: r'editBagItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editBagItemHash,
          dependencies: EditBagItemFamily._dependencies,
          allTransitiveDependencies:
              EditBagItemFamily._allTransitiveDependencies,
          cartID: cartID,
          newSize: newSize,
          newQuantity: newQuantity,
        );

  EditBagItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cartID,
    required this.newSize,
    required this.newQuantity,
  }) : super.internal();

  final String cartID;
  final String newSize;
  final int newQuantity;

  @override
  Override overrideWith(
    FutureOr<bool> Function(EditBagItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditBagItemProvider._internal(
        (ref) => create(ref as EditBagItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cartID: cartID,
        newSize: newSize,
        newQuantity: newQuantity,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _EditBagItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditBagItemProvider &&
        other.cartID == cartID &&
        other.newSize == newSize &&
        other.newQuantity == newQuantity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cartID.hashCode);
    hash = _SystemHash.combine(hash, newSize.hashCode);
    hash = _SystemHash.combine(hash, newQuantity.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditBagItemRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `cartID` of this provider.
  String get cartID;

  /// The parameter `newSize` of this provider.
  String get newSize;

  /// The parameter `newQuantity` of this provider.
  int get newQuantity;
}

class _EditBagItemProviderElement extends AutoDisposeFutureProviderElement<bool>
    with EditBagItemRef {
  _EditBagItemProviderElement(super.provider);

  @override
  String get cartID => (origin as EditBagItemProvider).cartID;
  @override
  String get newSize => (origin as EditBagItemProvider).newSize;
  @override
  int get newQuantity => (origin as EditBagItemProvider).newQuantity;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
