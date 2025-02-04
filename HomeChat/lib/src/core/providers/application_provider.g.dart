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
String _$channelHash() => r'715544005c0a995ecee1d79ba4d926f58252cdb6';

/// See also [channel].
@ProviderFor(channel)
final channelProvider = Provider<WebSocketClient>.internal(
  channel,
  name: r'channelProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$channelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChannelRef = ProviderRef<WebSocketClient>;
String _$authRepositoryHash() => r'7ee9a373e43c51bf91445e0d99e35444b221f6ec';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$loginServiceHash() => r'9d72644d5042e7cd35bd66e4c3519f008cb35b81';

/// See also [loginService].
@ProviderFor(loginService)
final loginServiceProvider = Provider<LoginService>.internal(
  loginService,
  name: r'loginServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginServiceRef = ProviderRef<LoginService>;
String _$registerServiceHash() => r'65b2996b3b7f0bfd6c6dd8bad8ce42ca5dc523e5';

/// See also [registerService].
@ProviderFor(registerService)
final registerServiceProvider = Provider<RegisterService>.internal(
  registerService,
  name: r'registerServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$registerServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RegisterServiceRef = ProviderRef<RegisterService>;
String _$getMeHash() => r'2ead3eae83297ce752d456a379f1a1a8d2939e1b';

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
String _$repositoryMessagesHash() =>
    r'0f8cd14cbb7c231e70235ebeff0adf7480d1aeb5';

/// See also [repositoryMessages].
@ProviderFor(repositoryMessages)
final repositoryMessagesProvider = Provider<RepositoryMessages>.internal(
  repositoryMessages,
  name: r'repositoryMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repositoryMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RepositoryMessagesRef = ProviderRef<RepositoryMessages>;
String _$repositoryGeneralHash() => r'3da1a16034213addd2efb02f39b3ce86fda214e6';

/// See also [repositoryGeneral].
@ProviderFor(repositoryGeneral)
final repositoryGeneralProvider = Provider<RepositoryGeneral>.internal(
  repositoryGeneral,
  name: r'repositoryGeneralProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repositoryGeneralHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RepositoryGeneralRef = ProviderRef<RepositoryGeneral>;
String _$getMeUsersHash() => r'acdb0bc29609b0139a1750f2ba5c7887a2a13456';

/// See also [getMeUsers].
@ProviderFor(getMeUsers)
final getMeUsersProvider = FutureProvider<List<UserModel>>.internal(
  getMeUsers,
  name: r'getMeUsersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMeUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetMeUsersRef = FutureProviderRef<List<UserModel>>;
String _$logoutHash() => r'12388f796042c00ba720999f9878ad984304660b';

/// See also [logout].
@ProviderFor(logout)
final logoutProvider = FutureProvider<void>.internal(
  logout,
  name: r'logoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LogoutRef = FutureProviderRef<void>;
String _$connectedHash() => r'e4a26ff0deb155b555341183367f51fda64a3175';

/// See also [connected].
@ProviderFor(connected)
final connectedProvider = FutureProvider<void>.internal(
  connected,
  name: r'connectedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$connectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectedRef = FutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
