import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/providers/user.dart';
import 'package:wenku8x/app/ui/components/avatar.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';
import 'package:wenku8x/app/utils/flash.dart';
import 'package:wenku8x/preference/models/preference.dart';
import 'package:wenku8x/preference/providers/preference.dart';
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
    final preference = ref.watch(preferenceProvider);
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
                      minimumSize: Size(54, 30),
                      // maximumSize: Size(68, 30),
                      textStyle: TextStyle(fontSize: 13),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
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
                PreferenceDropDownTile(
                  title: "夜间模式",
                  values: [
                    {"title": "跟随系统", "value": ThemeMode.system},
                    {"title": "浅色模式", "value": ThemeMode.light},
                    {"title": "深色模式", "value": ThemeMode.dark},
                  ],
                  onSelected: (value) {
                    logger.debug("Selected night mode: $value");
                    ref.read(preferenceProvider.notifier).setBrightness(value);
                  },
                  value: preference.brightness,
                ),
                PreferenceDropDownTile(
                  title: "主题风格",
                  values: [
                    {
                      "title": "预设主题",
                      "value": StyleMode.preset,
                      "description": "使用预置的颜色风格",
                    },
                    {
                      "title": "Material3",
                      "value": StyleMode.md3,
                      "description": "使用 Material3 颜色风格，同时将允许你自定义主色调",
                    },
                  ],
                  value: preference.styleMode,
                ),
                PreferenceDropDownTile(
                  title: "语言设置",
                  values: [
                    {"title": "简体中文", "value": AppLanguage.sc},
                    {"title": "繁体中文", "value": AppLanguage.tc},
                  ],
                  value: preference.language,
                ),
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
                  value: preference.autoSignIn,
                  onChanged: (value) {
                    ref.read(preferenceProvider.notifier).setAutoSignIn(value);
                  },
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
