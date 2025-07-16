import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/providers/user.dart';
import 'package:wenku8x/app/ui/components/avatar.dart';
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
    final user = ref.watch(userProvider);
    return Scaffold(
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: 32), child: Avatar(size: 72)),
          switch (user) {
            AsyncData(:final value) => ListTile(
              title: Text(value.nickname),
              subtitle: Text(value.rank),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: Implement edit user functionality
                },
              ),
            ),
            _ => const SizedBox.shrink(),
          },
        ],
      ),
    );
  }
}
