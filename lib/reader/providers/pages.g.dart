// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pages.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(Pages)
const pagesProvider = PagesFamily._();

final class PagesProvider extends $AsyncNotifierProvider<Pages, LayoutResult> {
  const PagesProvider._({
    required PagesFamily super.from,
    required String super.argument,
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

String _$pagesHash() => r'51bf16a7f259a9adfc5d0b759a1936ca76f67345';

final class PagesFamily extends $Family
    with
        $ClassFamilyOverride<
          Pages,
          AsyncValue<LayoutResult>,
          LayoutResult,
          FutureOr<LayoutResult>,
          String
        > {
  const PagesFamily._()
    : super(
        retry: null,
        name: r'pagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PagesProvider call(String aid) => PagesProvider._(argument: aid, from: this);

  @override
  String toString() => r'pagesProvider';
}

abstract class _$Pages extends $AsyncNotifier<LayoutResult> {
  late final _$args = ref.$arg as String;
  String get aid => _$args;

  FutureOr<LayoutResult> build(String aid);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<LayoutResult>, LayoutResult>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LayoutResult>, LayoutResult>,
              AsyncValue<LayoutResult>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
