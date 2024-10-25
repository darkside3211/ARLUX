// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gmodel_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gmodelRepositoryHash() => r'57e06798635218648638498e4613c711be579064';

/// See also [gmodelRepository].
@ProviderFor(gmodelRepository)
final gmodelRepositoryProvider = AutoDisposeProvider<GmodelRepository>.internal(
  gmodelRepository,
  name: r'gmodelRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gmodelRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GmodelRepositoryRef = AutoDisposeProviderRef<GmodelRepository>;
String _$downloadModelHash() => r'da5a6a2d2575aac283295402bf7acb790d7b409e';

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

/// See also [downloadModel].
@ProviderFor(downloadModel)
const downloadModelProvider = DownloadModelFamily();

/// See also [downloadModel].
class DownloadModelFamily extends Family<AsyncValue<String?>> {
  /// See also [downloadModel].
  const DownloadModelFamily();

  /// See also [downloadModel].
  DownloadModelProvider call({
    required String url,
  }) {
    return DownloadModelProvider(
      url: url,
    );
  }

  @override
  DownloadModelProvider getProviderOverride(
    covariant DownloadModelProvider provider,
  ) {
    return call(
      url: provider.url,
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
  String? get name => r'downloadModelProvider';
}

/// See also [downloadModel].
class DownloadModelProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [downloadModel].
  DownloadModelProvider({
    required String url,
  }) : this._internal(
          (ref) => downloadModel(
            ref as DownloadModelRef,
            url: url,
          ),
          from: downloadModelProvider,
          name: r'downloadModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$downloadModelHash,
          dependencies: DownloadModelFamily._dependencies,
          allTransitiveDependencies:
              DownloadModelFamily._allTransitiveDependencies,
          url: url,
        );

  DownloadModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  Override overrideWith(
    FutureOr<String?> Function(DownloadModelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DownloadModelProvider._internal(
        (ref) => create(ref as DownloadModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _DownloadModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DownloadModelProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DownloadModelRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `url` of this provider.
  String get url;
}

class _DownloadModelProviderElement
    extends AutoDisposeFutureProviderElement<String?> with DownloadModelRef {
  _DownloadModelProviderElement(super.provider);

  @override
  String get url => (origin as DownloadModelProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
