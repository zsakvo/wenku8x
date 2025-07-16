import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';

class PreferenceScreen extends StatefulHookConsumerWidget {
  const PreferenceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreferenceScreenState();
}

class _PreferenceScreenState extends ConsumerState<PreferenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: ""),
      body: ListView(children: [
         
        ],
      ),
    );
  }
}
