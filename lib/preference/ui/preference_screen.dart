import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/providers/user.dart';
import 'package:wenku8x/app/ui/components/avatar.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';
import 'package:wenku8x/preference/ui/components/section/section.dart';
import 'package:wenku8x/preference/ui/components/tile/drop_down_tile.dart';
import 'package:wenku8x/preference/ui/components/tile/switcher_tile.dart';
import 'package:wenku8x/preference/ui/components/tile/tile.dart';

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
                    style: FilledButton.styleFrom(minimumSize: Size(60, 36)),
                    onPressed: () {},
                    child: Text("签到"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 32, right: 20),
            child: PreferenceSection(
              title: "General",
              description: "General settings for the app",
              children: [
                PreferenceDropDownTile(title: "夜间模式"),
                PreferenceDropDownTile(title: "主题风格"),
                PreferenceDropDownTile(title: "语言设置"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 16, right: 20),
            child: PreferenceSection(
              title: "Account",
              children: [
                PreferenceSwitcherTile(
                  title: "自动签到",
                  negativeDescription: "已关闭",
                  positiveDescription: "已开启",
                ),
                PreferenceTile(title: "强制同步书架", onTap: () async {}),
                PreferenceTile(title: "退出登录"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 16, right: 20),
            child: PreferenceSection(
              title: "Extra",
              children: [
                PreferenceTile(title: "清除缓存"),
                PreferenceTile(title: "日志设置"),
                PreferenceTile(title: "关于 WENKU8X"),
                PreferenceTile(title: "开发者模式"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
