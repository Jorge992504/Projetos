// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$restClientHash() => r'0ee58f1fd102b2016ed621885f1e8d52ed00da66';

/// See also [restClient].
@ProviderFor(restClient)
final restClientProvider = Provider<RestClient>.internal(
  restClient,
  name: r'restClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$restClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RestClientRef = ProviderRef<RestClient>;
String _$authUserRepositoryHash() =>
    r'bdbe59bb2ed9336d65e0380cd27fafd049e470b8';

/// See also [authUserRepository].
@ProviderFor(authUserRepository)
final authUserRepositoryProvider = Provider<AuthUserRepository>.internal(
  authUserRepository,
  name: r'authUserRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authUserRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthUserRepositoryRef = ProviderRef<AuthUserRepository>;
String _$userLoginServiceHash() => r'c2033a9a764d2530f854620f0f8c5d2d2bea3af8';

/// See also [userLoginService].
@ProviderFor(userLoginService)
final userLoginServiceProvider = Provider<UserLoginService>.internal(
  userLoginService,
  name: r'userLoginServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userLoginServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserLoginServiceRef = ProviderRef<UserLoginService>;
String _$getMeHash() => r'c4a61900b43f254363666b37b3de0ec5fc6f41f7';

/// See also [getMe].
@ProviderFor(getMe)
final getMeProvider = FutureProvider<UserModel>.internal(
  getMe,
  name: r'getMeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetMeRef = FutureProviderRef<UserModel>;
String _$ishoppingRepositoryHash() =>
    r'0e05006cf6f371b06ab6094f11cafd2a0e1d9322';

/// See also [ishoppingRepository].
@ProviderFor(ishoppingRepository)
final ishoppingRepositoryProvider = Provider<IshoppingRepository>.internal(
  ishoppingRepository,
  name: r'ishoppingRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ishoppingRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IshoppingRepositoryRef = ProviderRef<IshoppingRepository>;
String _$getMeProductsHash() => r'f39c00f2a949b491c45f5db1980e897572771c8e';

/// See also [getMeProducts].
@ProviderFor(getMeProducts)
final getMeProductsProvider = FutureProvider<List<ProductsModel>>.internal(
  getMeProducts,
  name: r'getMeProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMeProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetMeProductsRef = FutureProviderRef<List<ProductsModel>>;
String _$logoutHash() => r'3bf203b34fdb2d8333ef28e1247317526db3aac4';

/// See also [logout].
@ProviderFor(logout)
final logoutProvider = AutoDisposeFutureProvider<void>.internal(
  logout,
  name: r'logoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LogoutRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
