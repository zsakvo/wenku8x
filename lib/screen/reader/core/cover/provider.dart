import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/reader/core/provider.dart';

part 'provider.freezed.dart';

@freezed
class CoverReader with _$CoverReader {
  const CoverReader._();

  const factory CoverReader({
    required String name,
    required String aid,
    @Default([]) List<Widget> pages,
  }) = _CoverReader;
}

class CoverReaderNotifier
    extends FamilyNotifier<CoverReader, (BuildContext, String, String)> {
  @override
  CoverReader build(arg) {
    ref.watch(readerCoreProvider(arg));
    return CoverReader(name: arg.$2, aid: arg.$3, pages: [
      Container(
        child: Text("loading"),
      )
    ]);
  }
}

final coverReaderProvider = NotifierProvider.family<CoverReaderNotifier,
    CoverReader, (BuildContext, String, String)>(CoverReaderNotifier.new);
