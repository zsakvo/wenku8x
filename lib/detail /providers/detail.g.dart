// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Detail)
const detailProvider = DetailFamily._();

final class DetailProvider extends $AsyncNotifierProvider<Detail, BookModel> {
  const DetailProvider._({
    required DetailFamily super.from,
    required BookModel super.argument,
  }) : super(
         retry: null,
         name: r'detailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$detailHash();

  @override
  String toString() {
    return r'detailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Detail create() => Detail();

  @override
  bool operator ==(Object other) {
    return other is DetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$detailHash() => r'f313159b34415d3476cc4ee42eb8f5958445d352';

final class DetailFamily extends $Family
    with
        $ClassFamilyOverride<
          Detail,
          AsyncValue<BookModel>,
          BookModel,
          FutureOr<BookModel>,
          BookModel
        > {
  const DetailFamily._()
    : super(
        retry: null,
        name: r'detailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DetailProvider call(BookModel book) =>
      DetailProvider._(argument: book, from: this);

  @override
  String toString() => r'detailProvider';
}

abstract class _$Detail extends $AsyncNotifier<BookModel> {
  late final _$args = ref.$arg as BookModel;
  BookModel get book => _$args;

  FutureOr<BookModel> build(BookModel book);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<BookModel>, BookModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BookModel>, BookModel>,
              AsyncValue<BookModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
