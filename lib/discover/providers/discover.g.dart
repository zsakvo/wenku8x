// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(DiscoverAll)
const discoverAllProvider = DiscoverAllProvider._();

final class DiscoverAllProvider
    extends $AsyncNotifierProvider<DiscoverAll, List<Map<String, dynamic>>> {
  const DiscoverAllProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverAllProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverAllHash();

  @$internal
  @override
  DiscoverAll create() => DiscoverAll();
}

String _$discoverAllHash() => r'14a66dcaafadf446ba7ee1e89699fb9421f489c0';

abstract class _$DiscoverAll
    extends $AsyncNotifier<List<Map<String, dynamic>>> {
  FutureOr<List<Map<String, dynamic>>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<Map<String, dynamic>>>,
              List<Map<String, dynamic>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<Map<String, dynamic>>>,
                List<Map<String, dynamic>>
              >,
              AsyncValue<List<Map<String, dynamic>>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
