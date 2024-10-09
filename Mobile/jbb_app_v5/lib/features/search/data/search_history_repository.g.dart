// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSearchHistoryHash() => r'65399af3b0989c99ab30edd28efe86907e92603e';

/// See also [getSearchHistory].
@ProviderFor(getSearchHistory)
final getSearchHistoryProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
  getSearchHistory,
  name: r'getSearchHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSearchHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetSearchHistoryRef = AutoDisposeFutureProviderRef<List<String>>;
String _$clearHistoryHash() => r'51e5c64e907b742f86fe4919573a0b0f619ddd28';

/// See also [clearHistory].
@ProviderFor(clearHistory)
final clearHistoryProvider = AutoDisposeFutureProvider<void>.internal(
  clearHistory,
  name: r'clearHistoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$clearHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ClearHistoryRef = AutoDisposeFutureProviderRef<void>;
String _$clearSingleHistoryHash() =>
    r'78cb037d4fbf9c8b825cc62a675b2741d92c9795';

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

/// See also [clearSingleHistory].
@ProviderFor(clearSingleHistory)
const clearSingleHistoryProvider = ClearSingleHistoryFamily();

/// See also [clearSingleHistory].
class ClearSingleHistoryFamily extends Family<AsyncValue<void>> {
  /// See also [clearSingleHistory].
  const ClearSingleHistoryFamily();

  /// See also [clearSingleHistory].
  ClearSingleHistoryProvider call({
    required String query,
  }) {
    return ClearSingleHistoryProvider(
      query: query,
    );
  }

  @override
  ClearSingleHistoryProvider getProviderOverride(
    covariant ClearSingleHistoryProvider provider,
  ) {
    return call(
      query: provider.query,
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
  String? get name => r'clearSingleHistoryProvider';
}

/// See also [clearSingleHistory].
class ClearSingleHistoryProvider extends AutoDisposeFutureProvider<void> {
  /// See also [clearSingleHistory].
  ClearSingleHistoryProvider({
    required String query,
  }) : this._internal(
          (ref) => clearSingleHistory(
            ref as ClearSingleHistoryRef,
            query: query,
          ),
          from: clearSingleHistoryProvider,
          name: r'clearSingleHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clearSingleHistoryHash,
          dependencies: ClearSingleHistoryFamily._dependencies,
          allTransitiveDependencies:
              ClearSingleHistoryFamily._allTransitiveDependencies,
          query: query,
        );

  ClearSingleHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<void> Function(ClearSingleHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClearSingleHistoryProvider._internal(
        (ref) => create(ref as ClearSingleHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _ClearSingleHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClearSingleHistoryProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ClearSingleHistoryRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `query` of this provider.
  String get query;
}

class _ClearSingleHistoryProviderElement
    extends AutoDisposeFutureProviderElement<void> with ClearSingleHistoryRef {
  _ClearSingleHistoryProviderElement(super.provider);

  @override
  String get query => (origin as ClearSingleHistoryProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
