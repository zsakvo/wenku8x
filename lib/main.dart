import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:wenku8x/data/scheme/book_record.dart';
import 'package:wenku8x/data/scheme/case_book.dart';
import 'package:wenku8x/http/ajax.dart';

import 'package:wenku8x/router.dart';
import 'package:wenku8x/themes/sakura/color_schemes.g.dart';
import 'package:wenku8x/utils/libs.dart';
import 'package:wenku8x/utils/scroll.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Isar.openSync([CaseBookSchema, BookRecordSchema]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);
  const systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent);
  if (Platform.isAndroid || Platform.isIOS) {
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
  await Ajax.init();
  initLibs();
  // await FlutterDisplayMode.setHighRefreshRate();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  static const _defaultLightColorScheme = lightColorScheme;

  static const _defaultDarkColorScheme = darkColorScheme;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1334),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
            return MaterialApp.router(
              theme: ThemeData(
                colorScheme: lightColorScheme ?? _defaultLightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
                useMaterial3: true,
              ),
              routeInformationProvider: AppPages.router.routeInformationProvider,
              routeInformationParser: AppPages.router.routeInformationParser,
              routerDelegate: AppPages.router.routerDelegate,
              scrollBehavior: CustScroll(),
            );
          });
        });
  }
}
