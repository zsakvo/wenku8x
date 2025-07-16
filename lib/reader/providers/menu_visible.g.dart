// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_visible.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Menu)
const menuProvider = MenuProvider._();

final class MenuProvider extends $NotifierProvider<Menu, MenuVisible> {
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
  Override overrideWithValue(MenuVisible value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuVisible>(value),
    );
  }
}

String _$menuHash() => r'f556f000b03647a934fbb2716290e7040f7b3947';

abstract class _$Menu extends $Notifier<MenuVisible> {
  MenuVisible build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MenuVisible, MenuVisible>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MenuVisible, MenuVisible>,
              MenuVisible,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
