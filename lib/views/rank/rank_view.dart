import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RankView extends StatefulHookConsumerWidget {
  final String type;
  const RankView(this.type, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RankViewState();
}

class _RankViewState extends ConsumerState<RankView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.type)),
    );
  }
}
