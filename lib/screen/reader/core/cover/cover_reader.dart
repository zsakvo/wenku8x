// 覆盖翻页
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/reader/core/cover/provider.dart';

class CoverReader extends StatefulHookConsumerWidget {
  const CoverReader({super.key, required this.name, required this.aid});

  final String name;
  final String aid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CoverReaderState();
}

class _CoverReaderState extends ConsumerState<CoverReader> {
  @override
  Widget build(BuildContext context) {
    final coverReader =
        ref.watch(coverReaderProvider((context, widget.name, widget.aid)));
    return GestureDetector(
      child: Stack(
        children: coverReader.pages,
      ),
      onPanDown: (details) {},
      onPanUpdate: (details) {},
      onPanEnd: (details) {},
    );
  }
}
