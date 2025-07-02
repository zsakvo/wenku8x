// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(DiscoverFilter)
const discoverFilterProvider = DiscoverFilterProvider._();

final class DiscoverFilterProvider
    extends $NotifierProvider<DiscoverFilter, DiscoverModel> {
  const DiscoverFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverFilterHash();

  @$internal
  @override
  DiscoverFilter create() => DiscoverFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscoverModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscoverModel>(value),
    );
  }
}

String _$discoverFilterHash() => r'33cdef648797b4f0e3398f8b0549d1e02aed79c3';

abstract class _$DiscoverFilter extends $Notifier<DiscoverModel> {
  DiscoverModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DiscoverModel, DiscoverModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DiscoverModel, DiscoverModel>,
              DiscoverModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DiscoverData)
const discoverDataProvider = DiscoverDataProvider._();

final class DiscoverDataProvider
    extends $AsyncNotifierProvider<DiscoverData, List<BookModel>> {
  const DiscoverDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverDataHash();

  @$internal
  @override
  DiscoverData create() => DiscoverData();
}

String _$discoverDataHash() => r'78e9602235494ac47c9c5c9a17cb4ffb5fdd2c85';

abstract class _$DiscoverData extends $AsyncNotifier<List<BookModel>> {
  FutureOr<List<BookModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<BookModel>>, List<BookModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BookModel>>, List<BookModel>>,
              AsyncValue<List<BookModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
