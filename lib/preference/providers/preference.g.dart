// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Preference)
const preferenceProvider = PreferenceProvider._();

final class PreferenceProvider
    extends $NotifierProvider<Preference, PreferenceModel> {
  const PreferenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferenceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferenceHash();

  @$internal
  @override
  Preference create() => Preference();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreferenceModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreferenceModel>(value),
    );
  }
}

String _$preferenceHash() => r'9108b5b8ab5363c505578f1157bed287eb1c5b3d';

abstract class _$Preference extends $Notifier<PreferenceModel> {
  PreferenceModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PreferenceModel, PreferenceModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PreferenceModel, PreferenceModel>,
              PreferenceModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
