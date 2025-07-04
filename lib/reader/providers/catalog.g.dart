// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Catalog)
const catalogProvider = CatalogFamily._();

final class CatalogProvider
    extends $AsyncNotifierProvider<Catalog, CatalogModel> {
  const CatalogProvider._({
    required CatalogFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'catalogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$catalogHash();

  @override
  String toString() {
    return r'catalogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Catalog create() => Catalog();

  @override
  bool operator ==(Object other) {
    return other is CatalogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$catalogHash() => r'9378205c49a0528099b8836d821c78ade819357e';

final class CatalogFamily extends $Family
    with
        $ClassFamilyOverride<
          Catalog,
          AsyncValue<CatalogModel>,
          CatalogModel,
          FutureOr<CatalogModel>,
          String
        > {
  const CatalogFamily._()
    : super(
        retry: null,
        name: r'catalogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CatalogProvider call(String aid) =>
      CatalogProvider._(argument: aid, from: this);

  @override
  String toString() => r'catalogProvider';
}

abstract class _$Catalog extends $AsyncNotifier<CatalogModel> {
  late final _$args = ref.$arg as String;
  String get aid => _$args;

  FutureOr<CatalogModel> build(String aid);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<CatalogModel>, CatalogModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CatalogModel>, CatalogModel>,
              AsyncValue<CatalogModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
