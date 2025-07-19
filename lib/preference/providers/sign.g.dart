// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(UserSign)
const userSignProvider = UserSignProvider._();

final class UserSignProvider extends $NotifierProvider<UserSign, bool> {
  const UserSignProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSignProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSignHash();

  @$internal
  @override
  UserSign create() => UserSign();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$userSignHash() => r'd4abea2727dbb3f491ef9019f5fe1e4c40c76ecb';

abstract class _$UserSign extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
