import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:wenku8x/main.dart';
import 'package:wenku8x/utils/log.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:wenku8x/views/reader/constants/theme.dart';

class PreferenceView extends StatefulHookConsumerWidget {
  const PreferenceView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreferenceViewState();
}

class _PreferenceViewState extends ConsumerState<PreferenceView> {
  var top = 0.0;
  final titleStyle = const TextStyle(
    fontSize: 20,
  );
  final subTitleStyle = const TextStyle(fontSize: 14);
  @override
  Widget build(BuildContext context) {
    final dynamicColor = useState(false);
    final highRefreshRate = useState(false);
    final autoSign = useState(false);
    final traditionalChinese = useState(false);
    final colorSeed = useState(Color(spInstance.getInt("colorSeed") ?? 4294198070));
    // final getSpInstance = useMemoized(() => SharedPreferences.getInstance());
    // final spInstance = useFuture(getSpInstance, initialData: null);

    setSpBool(String key, bool value, ValueNotifier<bool> state) {
      // final sp = spInstance.data;
      // if (spInstance != null) {
      state.value = value;
      spInstance.setBool(key, value);
      // }
    }

    useEffect(() {
      // final sp = spInstance.data;
      Log.d(spInstance, "??");
      // if (spInstance != null) {
      dynamicColor.value = spInstance.getBool("dynamicColor") ?? true;
      highRefreshRate.value = spInstance.getBool("highRefreshRate") ?? false;
      autoSign.value = spInstance.getBool("autoSign") ?? false;
      traditionalChinese.value = spInstance.getBool("traditionalChinese") ?? false;
      // }
      return () {};
    }, []);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          top: false,
          child: CustomScrollView(slivers: [
            SliverAppBar.large(
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.pop();
                  },
                ),
                flexibleSpace: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: Text(
                      '设置',
                      style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
                    ),
                    centerTitle: false,
                    titlePadding: EdgeInsetsDirectional.only(
                      start: top > 140 ? 16.0 : 56,
                      bottom: 16.0,
                    ),
                  );
                })),
            SliverList(
                delegate: SliverChildListDelegate([
              ListTile(
                subtitle: Text(
                  "平台特性",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                title: Text("动态取色", style: titleStyle),
                onTap: () => setSpBool("dynamicColor", !dynamicColor.value, dynamicColor),
                subtitle: Text(
                  "跟随系统桌面自动获取主题色",
                  style: subTitleStyle,
                ),
                trailing: Transform.scale(
                  scaleX: 0.8,
                  scaleY: 0.8,
                  child: Switch(
                    value: dynamicColor.value,
                    onChanged: (value) => setSpBool("dynamicColor", !value, dynamicColor),
                  ),
                ),
              ),
              dynamicColor.value
                  ? const SizedBox.shrink()
                  : ListTile(
                      contentPadding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                      title: Text("选取颜色", style: titleStyle),
                      onTap: () {
                        final bakColor = ref.read(colorThemeProvider.notifier).state;
                        // openMainColorPicker(context, colorSeed, (color) {
                        //   ref.read(colorThemeProvider.notifier).state = color! as MaterialColor;
                        // }, () {
                        //   spInstance.setInt("colorSeed", ref.read(colorThemeProvider.notifier).state.value);
                        //   GoRouter.of(context).pop();
                        // }, () {
                        //   ref.read(colorThemeProvider.notifier).state = bakColor;
                        //   GoRouter.of(context).pop();
                        // });
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              contentPadding: const EdgeInsets.all(6.0),
                              title: const Text("颜色选择器"),
                              content: MaterialColorPicker(
                                  elevation: 0,
                                  spacing: 12,
                                  selectedColor: colorSeed.value,
                                  allowShades: false,
                                  onMainColorChange: (ColorSwatch<dynamic>? color) {
                                    colorSeed.value = color as MaterialColor;
                                    ref.read(colorThemeProvider.notifier).state = color;
                                  }),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      ref.read(colorThemeProvider.notifier).state = bakColor;
                                      GoRouter.of(context).pop();
                                    },
                                    child: const Text("取消")),
                                FilledButton(
                                    onPressed: () {
                                      spInstance.setInt("colorSeed", ref.read(colorThemeProvider.notifier).state.value);
                                      colorSeed.value = bakColor;
                                      ref.read(readerThemeProvider.notifier).update();
                                      GoRouter.of(context).pop();
                                    },
                                    child: const Text("确定"))
                              ],
                            );
                          },
                        );
                      },
                      subtitle: Text(
                        "手动选择一个色彩，这将作为种子被应用",
                        style: subTitleStyle,
                      ),
                    ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                title: Text("强制高刷", style: titleStyle),
                onTap: () => setSpBool("highRefreshRate", !highRefreshRate.value, highRefreshRate),
                subtitle: Text(
                  "一加的部分机型可能需要",
                  style: subTitleStyle,
                ),
                trailing: Transform.scale(
                  scaleX: 0.8,
                  scaleY: 0.8,
                  child: Switch(
                    value: highRefreshRate.value,
                    onChanged: (value) => setSpBool("highRefreshRate", value, highRefreshRate),
                  ),
                ),
              ),
              ListTile(
                subtitle: Text(
                  "应用特性",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                title: Text("自动签到", style: titleStyle),
                onTap: () => setSpBool("autoSign", !autoSign.value, autoSign),
                subtitle: Text(
                  "启动 App 时尝试自动签到",
                  style: subTitleStyle,
                ),
                trailing: Transform.scale(
                  scaleX: 0.8,
                  scaleY: 0.8,
                  child: Switch(
                    value: autoSign.value,
                    onChanged: (value) => setSpBool("autoSign", value, autoSign),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                title: Text("简繁转换", style: titleStyle),
                onTap: () => setSpBool("traditionalChinese", !traditionalChinese.value, traditionalChinese),
                subtitle: Text(
                  "当前显示为简体中文",
                  style: subTitleStyle,
                ),
                trailing: Transform.scale(
                  scaleX: 0.8,
                  scaleY: 0.8,
                  child: Switch(
                    value: traditionalChinese.value,
                    onChanged: (value) => setSpBool("traditionalChinese", value, traditionalChinese),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                title: Text("清除缓存", style: titleStyle),
                onTap: () {},
                subtitle: Text(
                  "当前缓存占用 100MB",
                  style: subTitleStyle,
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                title: Text("退出登录", style: titleStyle.copyWith(color: Theme.of(context).colorScheme.error)),
                onTap: () {},
                subtitle: Text(
                  "这不会移除你的本地数据",
                  style: subTitleStyle,
                ),
              )
            ]))
          ]),
        ));
  }
}
