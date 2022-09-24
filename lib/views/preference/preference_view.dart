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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: false,
        title: const Text("设置"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: SettingsList(
        platform: DevicePlatform.android,
        sections: [
          SettingsSection(
            title: const Text('平台特性'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.disabled_visible),
                title: const Text('帧率与分辨率'),
                value: const Text('默认'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.color_lens_outlined),
                title: const Text('主题色跟随系统'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('程序设置'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.delete_outline),
                title: const Text('清理缓存'),
                value: const Text('已缓存 100MB'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.swap_horiz_outlined),
                title: const Text('简繁转换'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
