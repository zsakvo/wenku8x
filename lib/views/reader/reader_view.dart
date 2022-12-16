import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReaderView extends StatefulHookConsumerWidget {
  final String aid;
  const ReaderView({required this.aid, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReaderViewState();
}

class _ReaderViewState extends ConsumerState<ReaderView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      child: Text(widget.aid),
    ));
  }
}
