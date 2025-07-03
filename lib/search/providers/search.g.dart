// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SearchFilter)
const searchFilterProvider = SearchFilterFamily._();

final class SearchFilterProvider
    extends $AsyncNotifierProvider<SearchFilter, List<BookModel>> {
  const SearchFilterProvider._({
    required SearchFilterFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchFilterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchFilterHash();

  @override
  String toString() {
    return r'searchFilterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SearchFilter create() => SearchFilter();

  @override
  bool operator ==(Object other) {
    return other is SearchFilterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchFilterHash() => r'75bbbab75340befab9648d86e9a2028fe8ae622a';

final class SearchFilterFamily extends $Family
    with
        $ClassFamilyOverride<
          SearchFilter,
          AsyncValue<List<BookModel>>,
          List<BookModel>,
          FutureOr<List<BookModel>>,
          String
        > {
  const SearchFilterFamily._()
    : super(
        retry: null,
        name: r'searchFilterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchFilterProvider call(String searchKey) =>
      SearchFilterProvider._(argument: searchKey, from: this);

  @override
  String toString() => r'searchFilterProvider';
}

abstract class _$SearchFilter extends $AsyncNotifier<List<BookModel>> {
  late final _$args = ref.$arg as String;
  String get searchKey => _$args;

  FutureOr<List<BookModel>> build(String searchKey);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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
