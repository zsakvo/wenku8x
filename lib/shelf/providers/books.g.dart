// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Books)
const booksProvider = BooksProvider._();

final class BooksProvider
    extends $AsyncNotifierProvider<Books, List<BookModel>> {
  const BooksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'booksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$booksHash();

  @$internal
  @override
  Books create() => Books();
}

String _$booksHash() => r'27109bd5f5ceddac72df9d930487ce892dda9d42';

abstract class _$Books extends $AsyncNotifier<List<BookModel>> {
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
