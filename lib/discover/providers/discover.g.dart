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
    extends $NotifierProvider<DiscoverData, PagingState<int, BookModel>> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagingState<int, BookModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagingState<int, BookModel>>(value),
    );
  }
}

String _$discoverDataHash() => r'7e34c8a21725a359f425fc01eb18fa7068ae0e33';

abstract class _$DiscoverData extends $Notifier<PagingState<int, BookModel>> {
  PagingState<int, BookModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<PagingState<int, BookModel>, PagingState<int, BookModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                PagingState<int, BookModel>,
                PagingState<int, BookModel>
              >,
              PagingState<int, BookModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
