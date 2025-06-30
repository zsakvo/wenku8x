// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(User)
const userProvider = UserProvider._();

final class UserProvider extends $AsyncNotifierProvider<User, UserModel> {
  const UserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userHash();

  @$internal
  @override
  User create() => User();
}

String _$userHash() => r'828e1bad3124e5e8bc1baa46a3027546f9fc621f';

abstract class _$User extends $AsyncNotifier<UserModel> {
  FutureOr<UserModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserModel>, UserModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserModel>, UserModel>,
              AsyncValue<UserModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(UserAvatar)
const userAvatarProvider = UserAvatarProvider._();

final class UserAvatarProvider
    extends $AsyncNotifierProvider<UserAvatar, String> {
  const UserAvatarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAvatarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAvatarHash();

  @$internal
  @override
  UserAvatar create() => UserAvatar();
}

String _$userAvatarHash() => r'cab7cefc3faae791297d323ed7d88c867b6d1c13';

abstract class _$UserAvatar extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
