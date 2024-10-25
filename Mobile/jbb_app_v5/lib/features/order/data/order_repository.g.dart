// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRepositoryHash() => r'9253d73f04ce8fb2e624da9bd81ad25a644540cd';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = AutoDisposeProvider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderRepositoryRef = AutoDisposeProviderRef<OrderRepository>;
String _$checkoutOrderHash() => r'eaed606e0d7c8b62d9c285bda7fc4496bf7f7f0d';

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

/// See also [checkoutOrder].
@ProviderFor(checkoutOrder)
const checkoutOrderProvider = CheckoutOrderFamily();

/// See also [checkoutOrder].
class CheckoutOrderFamily extends Family<AsyncValue<String?>> {
  /// See also [checkoutOrder].
  const CheckoutOrderFamily();

  /// See also [checkoutOrder].
  CheckoutOrderProvider call({
    required List<CheckoutItem> orders,
    required AddressModel address,
  }) {
    return CheckoutOrderProvider(
      orders: orders,
      address: address,
    );
  }

  @override
  CheckoutOrderProvider getProviderOverride(
    covariant CheckoutOrderProvider provider,
  ) {
    return call(
      orders: provider.orders,
      address: provider.address,
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
  String? get name => r'checkoutOrderProvider';
}

/// See also [checkoutOrder].
class CheckoutOrderProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [checkoutOrder].
  CheckoutOrderProvider({
    required List<CheckoutItem> orders,
    required AddressModel address,
  }) : this._internal(
          (ref) => checkoutOrder(
            ref as CheckoutOrderRef,
            orders: orders,
            address: address,
          ),
          from: checkoutOrderProvider,
          name: r'checkoutOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkoutOrderHash,
          dependencies: CheckoutOrderFamily._dependencies,
          allTransitiveDependencies:
              CheckoutOrderFamily._allTransitiveDependencies,
          orders: orders,
          address: address,
        );

  CheckoutOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orders,
    required this.address,
  }) : super.internal();

  final List<CheckoutItem> orders;
  final AddressModel address;

  @override
  Override overrideWith(
    FutureOr<String?> Function(CheckoutOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckoutOrderProvider._internal(
        (ref) => create(ref as CheckoutOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orders: orders,
        address: address,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _CheckoutOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckoutOrderProvider &&
        other.orders == orders &&
        other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orders.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CheckoutOrderRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `orders` of this provider.
  List<CheckoutItem> get orders;

  /// The parameter `address` of this provider.
  AddressModel get address;
}

class _CheckoutOrderProviderElement
    extends AutoDisposeFutureProviderElement<String?> with CheckoutOrderRef {
  _CheckoutOrderProviderElement(super.provider);

  @override
  List<CheckoutItem> get orders => (origin as CheckoutOrderProvider).orders;
  @override
  AddressModel get address => (origin as CheckoutOrderProvider).address;
}

String _$getOrdersHash() => r'5e30ee2a366c8eba1b4276e6a30421ab46cd9691';

/// See also [getOrders].
@ProviderFor(getOrders)
final getOrdersProvider = AutoDisposeFutureProvider<List<OrderModel>>.internal(
  getOrders,
  name: r'getOrdersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetOrdersRef = AutoDisposeFutureProviderRef<List<OrderModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
