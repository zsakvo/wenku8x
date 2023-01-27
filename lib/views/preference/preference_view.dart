import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class PreferenceView extends StatefulHookConsumerWidget {
  const PreferenceView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreferenceViewState();
}

class _PreferenceViewState extends ConsumerState<PreferenceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 120,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              '设置',
              style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
            ),
            centerTitle: false,
            titlePadding: const EdgeInsetsDirectional.only(
              start: 16.0,
              bottom: 16.0,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          ListTile(
            title: const Text(
              "动态取色",
            ),
            onTap: () {},
            subtitle: Text("跟随系统桌面自动获取主题色"),
            trailing: Transform.scale(
              scaleX: 0.8,
              scaleY: 0.8,
              child: Switch(value: true, onChanged: (value) {}),
            ),
          )
        ]))
      ]),
    );
  }
}
