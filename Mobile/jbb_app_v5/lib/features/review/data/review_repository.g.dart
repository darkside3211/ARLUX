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
String _$addReviewHash() => r'fdf44db2da91274036aca85aafe0c73e58ceaada';

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
    required List<XFile> images,
  }) {
    return AddReviewProvider(
      productID: productID,
      description: description,
      rating: rating,
      images: images,
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
      images: provider.images,
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
    required List<XFile> images,
  }) : this._internal(
          (ref) => addReview(
            ref as AddReviewRef,
            productID: productID,
            description: description,
            rating: rating,
            images: images,
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
          images: images,
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
    required this.images,
  }) : super.internal();

  final String productID;
  final String description;
  final int rating;
  final List<XFile> images;

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
        images: images,
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
        other.images == images;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productID.hashCode);
    hash = _SystemHash.combine(hash, description.hashCode);
    hash = _SystemHash.combine(hash, rating.hashCode);
    hash = _SystemHash.combine(hash, images.hashCode);

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

  /// The parameter `images` of this provider.
  List<XFile> get images;
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
  List<XFile> get images => (origin as AddReviewProvider).images;
}

String _$getReviewsHash() => r'87d6bb0d119d735dc1448fa6d08ddf100f1afc51';

/// See also [getReviews].
@ProviderFor(getReviews)
const getReviewsProvider = GetReviewsFamily();

/// See also [getReviews].
class GetReviewsFamily extends Family<AsyncValue<List<ReviewModel>>> {
  /// See also [getReviews].
  const GetReviewsFamily();

  /// See also [getReviews].
  GetReviewsProvider call({
    required String productId,
  }) {
    return GetReviewsProvider(
      productId: productId,
    );
  }

  @override
  GetReviewsProvider getProviderOverride(
    covariant GetReviewsProvider provider,
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
  String? get name => r'getReviewsProvider';
}

/// See also [getReviews].
class GetReviewsProvider extends AutoDisposeFutureProvider<List<ReviewModel>> {
  /// See also [getReviews].
  GetReviewsProvider({
    required String productId,
  }) : this._internal(
          (ref) => getReviews(
            ref as GetReviewsRef,
            productId: productId,
          ),
          from: getReviewsProvider,
          name: r'getReviewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getReviewsHash,
          dependencies: GetReviewsFamily._dependencies,
          allTransitiveDependencies:
              GetReviewsFamily._allTransitiveDependencies,
          productId: productId,
        );

  GetReviewsProvider._internal(
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
    FutureOr<List<ReviewModel>> Function(GetReviewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetReviewsProvider._internal(
        (ref) => create(ref as GetReviewsRef),
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
  AutoDisposeFutureProviderElement<List<ReviewModel>> createElement() {
    return _GetReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetReviewsProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetReviewsRef on AutoDisposeFutureProviderRef<List<ReviewModel>> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _GetReviewsProviderElement
    extends AutoDisposeFutureProviderElement<List<ReviewModel>>
    with GetReviewsRef {
  _GetReviewsProviderElement(super.provider);

  @override
  String get productId => (origin as GetReviewsProvider).productId;
}

String _$removeReviewHash() => r'ed6ca9f2e4b7e8b7b8c44763565e20547ef08ec2';

/// See also [removeReview].
@ProviderFor(removeReview)
const removeReviewProvider = RemoveReviewFamily();

/// See also [removeReview].
class RemoveReviewFamily extends Family<AsyncValue<bool>> {
  /// See also [removeReview].
  const RemoveReviewFamily();

  /// See also [removeReview].
  RemoveReviewProvider call({
    required String reviewID,
  }) {
    return RemoveReviewProvider(
      reviewID: reviewID,
    );
  }

  @override
  RemoveReviewProvider getProviderOverride(
    covariant RemoveReviewProvider provider,
  ) {
    return call(
      reviewID: provider.reviewID,
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
  String? get name => r'removeReviewProvider';
}

/// See also [removeReview].
class RemoveReviewProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [removeReview].
  RemoveReviewProvider({
    required String reviewID,
  }) : this._internal(
          (ref) => removeReview(
            ref as RemoveReviewRef,
            reviewID: reviewID,
          ),
          from: removeReviewProvider,
          name: r'removeReviewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeReviewHash,
          dependencies: RemoveReviewFamily._dependencies,
          allTransitiveDependencies:
              RemoveReviewFamily._allTransitiveDependencies,
          reviewID: reviewID,
        );

  RemoveReviewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reviewID,
  }) : super.internal();

  final String reviewID;

  @override
  Override overrideWith(
    FutureOr<bool> Function(RemoveReviewRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveReviewProvider._internal(
        (ref) => create(ref as RemoveReviewRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reviewID: reviewID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _RemoveReviewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveReviewProvider && other.reviewID == reviewID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reviewID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RemoveReviewRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `reviewID` of this provider.
  String get reviewID;
}

class _RemoveReviewProviderElement
    extends AutoDisposeFutureProviderElement<bool> with RemoveReviewRef {
  _RemoveReviewProviderElement(super.provider);

  @override
  String get reviewID => (origin as RemoveReviewProvider).reviewID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
