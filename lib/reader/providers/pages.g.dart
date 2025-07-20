// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pages.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Pages)
const pagesProvider = PagesFamily._();

final class PagesProvider
    extends $AsyncNotifierProvider<Pages, Map<int, PageLayout>> {
  const PagesProvider._({
    required PagesFamily super.from,
    required BookModel super.argument,
  }) : super(
         retry: null,
         name: r'pagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pagesHash();

  @override
  String toString() {
    return r'pagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Pages create() => Pages();

  @override
  bool operator ==(Object other) {
    return other is PagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pagesHash() => r'85c147c1b11e0a3761773f11f8c5c0df62d4ffff';

final class PagesFamily extends $Family
    with
        $ClassFamilyOverride<
          Pages,
          AsyncValue<Map<int, PageLayout>>,
          Map<int, PageLayout>,
          FutureOr<Map<int, PageLayout>>,
          BookModel
        > {
  const PagesFamily._()
    : super(
        retry: null,
        name: r'pagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PagesProvider call(BookModel book) =>
      PagesProvider._(argument: book, from: this);

  @override
  String toString() => r'pagesProvider';
}

abstract class _$Pages extends $AsyncNotifier<Map<int, PageLayout>> {
  late final _$args = ref.$arg as BookModel;
  BookModel get book => _$args;

  FutureOr<Map<int, PageLayout>> build(BookModel book);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<int, PageLayout>>, Map<int, PageLayout>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<int, PageLayout>>,
                Map<int, PageLayout>
              >,
              AsyncValue<Map<int, PageLayout>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
