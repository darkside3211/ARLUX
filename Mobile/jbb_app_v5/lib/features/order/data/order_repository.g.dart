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
String _$checkoutOrderHash() => r'8976cfa27291643ad1b9e8016f29b415a964bf5f';

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
class CheckoutOrderFamily extends Family<AsyncValue<void>> {
  /// See also [checkoutOrder].
  const CheckoutOrderFamily();

  /// See also [checkoutOrder].
  CheckoutOrderProvider call({
    required List<CheckoutItem> orders,
  }) {
    return CheckoutOrderProvider(
      orders: orders,
    );
  }

  @override
  CheckoutOrderProvider getProviderOverride(
    covariant CheckoutOrderProvider provider,
  ) {
    return call(
      orders: provider.orders,
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
class CheckoutOrderProvider extends AutoDisposeFutureProvider<void> {
  /// See also [checkoutOrder].
  CheckoutOrderProvider({
    required List<CheckoutItem> orders,
  }) : this._internal(
          (ref) => checkoutOrder(
            ref as CheckoutOrderRef,
            orders: orders,
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
        );

  CheckoutOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orders,
  }) : super.internal();

  final List<CheckoutItem> orders;

  @override
  Override overrideWith(
    FutureOr<void> Function(CheckoutOrderRef provider) create,
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
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CheckoutOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckoutOrderProvider && other.orders == orders;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orders.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CheckoutOrderRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `orders` of this provider.
  List<CheckoutItem> get orders;
}

class _CheckoutOrderProviderElement
    extends AutoDisposeFutureProviderElement<void> with CheckoutOrderRef {
  _CheckoutOrderProviderElement(super.provider);

  @override
  List<CheckoutItem> get orders => (origin as CheckoutOrderProvider).orders;
}

String _$getOrdersHash() => r'1de7a7ef99c9300528d86550a5ec934b3ec8b527';

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
