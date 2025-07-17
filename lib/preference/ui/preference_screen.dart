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
          Padding(
            padding: EdgeInsets.only(top: 32, left: 20),
            child: Row(
              spacing: 14,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avatar(size: 56),
                switch (user) {
                  AsyncData(:final value) => RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${value.nickname}\n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            height: 1.5,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: value.rank,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            height: 1.5,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(172),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _ => const SizedBox.shrink(),
                },
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: Size(60, 34),
                      textStyle: TextStyle(height: 1.2),
                    ),
                    onPressed: () {},
                    child: Text("签到"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
