import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wenku8x/hooks/brightness.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/router.dart';

import 'package:wenku8x/screen/profile/profile_provider.dart';
import 'package:wenku8x/theme/extend.dart';

import 'http/ajax.dart';

part 'main.freezed.dart';

// late final Isar isar;
late final SharedPreferences sp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  // isar = Isar.openSync([BookItemSchema], directory: Isar.defaultName);
  // 设置上下顶栏
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  if (Platform.isAndroid || Platform.isIOS) {
    const systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  EasyRefresh.defaultHeaderBuilder = () => const ClassicHeader(
      position: IndicatorPosition.locator,
      dragText: "下拉刷新",
      armedText: "释放开始",
      readyText: "刷新中……",
      processingText: "刷新中",
      processedText: "成功了",
      noMoreText: "没有更多",
      failedText: "失败了",
      messageText: "最后更新于 %T");
  EasyRefresh.defaultFooterBuilder = () => const ClassicFooter(
        position: IndicatorPosition.locator,
        dragText: '上拉加载',
        armedText: '释放开始',
        readyText: '加载中...',
        processingText: '加载中...',
        processedText: '成功了',
        noMoreText: '没有更多',
        failedText: '失败了',
        messageText: '最后更新于 %T',
      );
  final container = ProviderContainer();
  await Ajax.init();
  // 初始化个人信息
  API.getUserInfo(container);
  if (sp.getBool("highRefreshRate") ?? false) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final colorSeed = ref.watch(colorSeedProvider);
    final dynamicColor =
        ref.watch(configProvider.select((value) => value.dynamicColor));
    final colorSeed =
        ref.watch(configProvider.select((value) => value.colorSeed));

    final autoDarkMode =
        ref.watch(configProvider.select((value) => value.autoDarkMode));
    final darkModeProvider = configProvider.select((value) => value.isDarkMode);
    final isDarkMode = ref.watch(darkModeProvider);

    useBrightnessChanged(context,
        autoDarkMode: autoDarkMode, isDarkMode: isDarkMode);

    return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
      final lightCustom = ColorScheme.fromSeed(
          seedColor: Color(colorSeed), brightness: Brightness.light);
      final darkCustom = ColorScheme.fromSeed(
          seedColor: Color(colorSeed), brightness: Brightness.dark);

      final lightColor =
          dynamicColor ? (lightDynamic ?? lightCustom) : lightCustom;

      final darkColor = dynamicColor ? (darkDynamic ?? darkCustom) : darkCustom;

      final lightExtendColor = ExtendColors(colorScheme: lightColor);
      final darkExtendColor = ExtendColors(colorScheme: darkColor);

      return MaterialApp.router(
        title: '轻小说文库',
        themeMode: autoDarkMode
            ? ThemeMode.system
            : isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
        theme: ThemeData(
            colorScheme: lightColor,
            brightness: Brightness.light,
            useMaterial3: true,
            extensions: [lightExtendColor]),
        darkTheme: ThemeData(
            colorScheme: darkColor,
            brightness: Brightness.dark,
            useMaterial3: true,
            extensions: [darkExtendColor]),
        routerConfig: router,
      );
    });
  }
}

@freezed
class Main with _$Main {
  const factory Main({@Default('deepPurple') String colorSeed}) = _Main;
}
