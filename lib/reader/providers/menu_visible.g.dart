// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_visible.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Menu)
const menuProvider = MenuProvider._();

final class MenuProvider extends $NotifierProvider<Menu, int> {
  const MenuProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuHash();

  @$internal
  @override
  Menu create() => Menu();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$menuHash() => r'a968df3101eced8f56fcdddce218ab5cbfc42efe';

abstract class _$Menu extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
