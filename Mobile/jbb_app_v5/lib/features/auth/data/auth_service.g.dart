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
String _$getFirebaseTokenHash() => r'e0affc082c7beefabffa64afedc5563e96e025eb';

/// See also [getFirebaseToken].
@ProviderFor(getFirebaseToken)
final getFirebaseTokenProvider = AutoDisposeFutureProvider<String?>.internal(
  getFirebaseToken,
  name: r'getFirebaseTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getFirebaseTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetFirebaseTokenRef = AutoDisposeFutureProviderRef<String?>;
String _$getUserInfoHash() => r'73e8aa13561ad3015cd4bc54110bddb99f104f12';

/// See also [getUserInfo].
@ProviderFor(getUserInfo)
final getUserInfoProvider = AutoDisposeFutureProvider<UserModel>.internal(
  getUserInfo,
  name: r'getUserInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getUserInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetUserInfoRef = AutoDisposeFutureProviderRef<UserModel>;
String _$updateUserInfoHash() => r'218d9217ff26e0860cdf857f35b204b5e125d299';

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

/// See also [updateUserInfo].
@ProviderFor(updateUserInfo)
const updateUserInfoProvider = UpdateUserInfoFamily();

/// See also [updateUserInfo].
class UpdateUserInfoFamily extends Family<AsyncValue<bool>> {
  /// See also [updateUserInfo].
  const UpdateUserInfoFamily();

  /// See also [updateUserInfo].
  UpdateUserInfoProvider call({
    required String username,
    required String phone,
  }) {
    return UpdateUserInfoProvider(
      username: username,
      phone: phone,
    );
  }

  @override
  UpdateUserInfoProvider getProviderOverride(
    covariant UpdateUserInfoProvider provider,
  ) {
    return call(
      username: provider.username,
      phone: provider.phone,
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
  String? get name => r'updateUserInfoProvider';
}

/// See also [updateUserInfo].
class UpdateUserInfoProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [updateUserInfo].
  UpdateUserInfoProvider({
    required String username,
    required String phone,
  }) : this._internal(
          (ref) => updateUserInfo(
            ref as UpdateUserInfoRef,
            username: username,
            phone: phone,
          ),
          from: updateUserInfoProvider,
          name: r'updateUserInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateUserInfoHash,
          dependencies: UpdateUserInfoFamily._dependencies,
          allTransitiveDependencies:
              UpdateUserInfoFamily._allTransitiveDependencies,
          username: username,
          phone: phone,
        );

  UpdateUserInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.username,
    required this.phone,
  }) : super.internal();

  final String username;
  final String phone;

  @override
  Override overrideWith(
    FutureOr<bool> Function(UpdateUserInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateUserInfoProvider._internal(
        (ref) => create(ref as UpdateUserInfoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        username: username,
        phone: phone,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _UpdateUserInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateUserInfoProvider &&
        other.username == username &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);
    hash = _SystemHash.combine(hash, phone.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdateUserInfoRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `username` of this provider.
  String get username;

  /// The parameter `phone` of this provider.
  String get phone;
}

class _UpdateUserInfoProviderElement
    extends AutoDisposeFutureProviderElement<bool> with UpdateUserInfoRef {
  _UpdateUserInfoProviderElement(super.provider);

  @override
  String get username => (origin as UpdateUserInfoProvider).username;
  @override
  String get phone => (origin as UpdateUserInfoProvider).phone;
}

String _$addUserAddressHash() => r'5233fdd075ee1324e10666b6ee06159b6323edae';

/// See also [addUserAddress].
@ProviderFor(addUserAddress)
const addUserAddressProvider = AddUserAddressFamily();

/// See also [addUserAddress].
class AddUserAddressFamily extends Family<AsyncValue<bool>> {
  /// See also [addUserAddress].
  const AddUserAddressFamily();

  /// See also [addUserAddress].
  AddUserAddressProvider call({
    required AddressModel address,
  }) {
    return AddUserAddressProvider(
      address: address,
    );
  }

  @override
  AddUserAddressProvider getProviderOverride(
    covariant AddUserAddressProvider provider,
  ) {
    return call(
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
  String? get name => r'addUserAddressProvider';
}

/// See also [addUserAddress].
class AddUserAddressProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addUserAddress].
  AddUserAddressProvider({
    required AddressModel address,
  }) : this._internal(
          (ref) => addUserAddress(
            ref as AddUserAddressRef,
            address: address,
          ),
          from: addUserAddressProvider,
          name: r'addUserAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addUserAddressHash,
          dependencies: AddUserAddressFamily._dependencies,
          allTransitiveDependencies:
              AddUserAddressFamily._allTransitiveDependencies,
          address: address,
        );

  AddUserAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final AddressModel address;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddUserAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddUserAddressProvider._internal(
        (ref) => create(ref as AddUserAddressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddUserAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddUserAddressProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddUserAddressRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `address` of this provider.
  AddressModel get address;
}

class _AddUserAddressProviderElement
    extends AutoDisposeFutureProviderElement<bool> with AddUserAddressRef {
  _AddUserAddressProviderElement(super.provider);

  @override
  AddressModel get address => (origin as AddUserAddressProvider).address;
}

String _$editUserAddressHash() => r'1200b547af49f324aa73b26eb9448ca048308c87';

/// See also [editUserAddress].
@ProviderFor(editUserAddress)
const editUserAddressProvider = EditUserAddressFamily();

/// See also [editUserAddress].
class EditUserAddressFamily extends Family<AsyncValue<bool>> {
  /// See also [editUserAddress].
  const EditUserAddressFamily();

  /// See also [editUserAddress].
  EditUserAddressProvider call({
    required AddressModel address,
    required String addressLabel,
  }) {
    return EditUserAddressProvider(
      address: address,
      addressLabel: addressLabel,
    );
  }

  @override
  EditUserAddressProvider getProviderOverride(
    covariant EditUserAddressProvider provider,
  ) {
    return call(
      address: provider.address,
      addressLabel: provider.addressLabel,
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
  String? get name => r'editUserAddressProvider';
}

/// See also [editUserAddress].
class EditUserAddressProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [editUserAddress].
  EditUserAddressProvider({
    required AddressModel address,
    required String addressLabel,
  }) : this._internal(
          (ref) => editUserAddress(
            ref as EditUserAddressRef,
            address: address,
            addressLabel: addressLabel,
          ),
          from: editUserAddressProvider,
          name: r'editUserAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editUserAddressHash,
          dependencies: EditUserAddressFamily._dependencies,
          allTransitiveDependencies:
              EditUserAddressFamily._allTransitiveDependencies,
          address: address,
          addressLabel: addressLabel,
        );

  EditUserAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
    required this.addressLabel,
  }) : super.internal();

  final AddressModel address;
  final String addressLabel;

  @override
  Override overrideWith(
    FutureOr<bool> Function(EditUserAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditUserAddressProvider._internal(
        (ref) => create(ref as EditUserAddressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
        addressLabel: addressLabel,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _EditUserAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditUserAddressProvider &&
        other.address == address &&
        other.addressLabel == addressLabel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, addressLabel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditUserAddressRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `address` of this provider.
  AddressModel get address;

  /// The parameter `addressLabel` of this provider.
  String get addressLabel;
}

class _EditUserAddressProviderElement
    extends AutoDisposeFutureProviderElement<bool> with EditUserAddressRef {
  _EditUserAddressProviderElement(super.provider);

  @override
  AddressModel get address => (origin as EditUserAddressProvider).address;
  @override
  String get addressLabel => (origin as EditUserAddressProvider).addressLabel;
}

String _$deleteUserAddressHash() => r'2beb51e533dd2e8bb486f863c0251a3445af0788';

/// See also [deleteUserAddress].
@ProviderFor(deleteUserAddress)
const deleteUserAddressProvider = DeleteUserAddressFamily();

/// See also [deleteUserAddress].
class DeleteUserAddressFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteUserAddress].
  const DeleteUserAddressFamily();

  /// See also [deleteUserAddress].
  DeleteUserAddressProvider call({
    required String addressLabel,
  }) {
    return DeleteUserAddressProvider(
      addressLabel: addressLabel,
    );
  }

  @override
  DeleteUserAddressProvider getProviderOverride(
    covariant DeleteUserAddressProvider provider,
  ) {
    return call(
      addressLabel: provider.addressLabel,
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
  String? get name => r'deleteUserAddressProvider';
}

/// See also [deleteUserAddress].
class DeleteUserAddressProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteUserAddress].
  DeleteUserAddressProvider({
    required String addressLabel,
  }) : this._internal(
          (ref) => deleteUserAddress(
            ref as DeleteUserAddressRef,
            addressLabel: addressLabel,
          ),
          from: deleteUserAddressProvider,
          name: r'deleteUserAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteUserAddressHash,
          dependencies: DeleteUserAddressFamily._dependencies,
          allTransitiveDependencies:
              DeleteUserAddressFamily._allTransitiveDependencies,
          addressLabel: addressLabel,
        );

  DeleteUserAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.addressLabel,
  }) : super.internal();

  final String addressLabel;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeleteUserAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteUserAddressProvider._internal(
        (ref) => create(ref as DeleteUserAddressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        addressLabel: addressLabel,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeleteUserAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteUserAddressProvider &&
        other.addressLabel == addressLabel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, addressLabel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteUserAddressRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `addressLabel` of this provider.
  String get addressLabel;
}

class _DeleteUserAddressProviderElement
    extends AutoDisposeFutureProviderElement<bool> with DeleteUserAddressRef {
  _DeleteUserAddressProviderElement(super.provider);

  @override
  String get addressLabel => (origin as DeleteUserAddressProvider).addressLabel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
