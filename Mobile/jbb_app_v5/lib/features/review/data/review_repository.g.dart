// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewRepositoryHash() => r'7fd924fac12f53f0c8e56e7492a6158592e5ffcf';

/// See also [reviewRepository].
@ProviderFor(reviewRepository)
final reviewRepositoryProvider = AutoDisposeProvider<ReviewRepository>.internal(
  reviewRepository,
  name: r'reviewRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReviewRepositoryRef = AutoDisposeProviderRef<ReviewRepository>;
String _$addReviewHash() => r'6e78a1834baba5e13210f2d5976121d431b1cdfa';

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

/// See also [addReview].
@ProviderFor(addReview)
const addReviewProvider = AddReviewFamily();

/// See also [addReview].
class AddReviewFamily extends Family<AsyncValue<bool>> {
  /// See also [addReview].
  const AddReviewFamily();

  /// See also [addReview].
  AddReviewProvider call({
    required String productID,
    required String description,
    required int rating,
    required String mediaUrl,
  }) {
    return AddReviewProvider(
      productID: productID,
      description: description,
      rating: rating,
      mediaUrl: mediaUrl,
    );
  }

  @override
  AddReviewProvider getProviderOverride(
    covariant AddReviewProvider provider,
  ) {
    return call(
      productID: provider.productID,
      description: provider.description,
      rating: provider.rating,
      mediaUrl: provider.mediaUrl,
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
  String? get name => r'addReviewProvider';
}

/// See also [addReview].
class AddReviewProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addReview].
  AddReviewProvider({
    required String productID,
    required String description,
    required int rating,
    required String mediaUrl,
  }) : this._internal(
          (ref) => addReview(
            ref as AddReviewRef,
            productID: productID,
            description: description,
            rating: rating,
            mediaUrl: mediaUrl,
          ),
          from: addReviewProvider,
          name: r'addReviewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addReviewHash,
          dependencies: AddReviewFamily._dependencies,
          allTransitiveDependencies: AddReviewFamily._allTransitiveDependencies,
          productID: productID,
          description: description,
          rating: rating,
          mediaUrl: mediaUrl,
        );

  AddReviewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productID,
    required this.description,
    required this.rating,
    required this.mediaUrl,
  }) : super.internal();

  final String productID;
  final String description;
  final int rating;
  final String mediaUrl;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddReviewRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddReviewProvider._internal(
        (ref) => create(ref as AddReviewRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productID: productID,
        description: description,
        rating: rating,
        mediaUrl: mediaUrl,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddReviewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddReviewProvider &&
        other.productID == productID &&
        other.description == description &&
        other.rating == rating &&
        other.mediaUrl == mediaUrl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productID.hashCode);
    hash = _SystemHash.combine(hash, description.hashCode);
    hash = _SystemHash.combine(hash, rating.hashCode);
    hash = _SystemHash.combine(hash, mediaUrl.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddReviewRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `productID` of this provider.
  String get productID;

  /// The parameter `description` of this provider.
  String get description;

  /// The parameter `rating` of this provider.
  int get rating;

  /// The parameter `mediaUrl` of this provider.
  String get mediaUrl;
}

class _AddReviewProviderElement extends AutoDisposeFutureProviderElement<bool>
    with AddReviewRef {
  _AddReviewProviderElement(super.provider);

  @override
  String get productID => (origin as AddReviewProvider).productID;
  @override
  String get description => (origin as AddReviewProvider).description;
  @override
  int get rating => (origin as AddReviewProvider).rating;
  @override
  String get mediaUrl => (origin as AddReviewProvider).mediaUrl;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
