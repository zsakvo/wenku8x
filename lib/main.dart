import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/hooks/use_brightness.dart';
import 'package:wenku8x/app/ui/router.dart';
import 'package:wenku8x/app/ui/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: ReaderApp()));
}

class ReaderApp extends ConsumerWidget {
  const ReaderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useBrightness(
      context,
      // autoDarkMode: preference.autoDarkMode,
      // isDarkMode: preference.isDarkMode,
      autoDarkMode: true,
      isDarkMode: false,
    );
    return MaterialApp.router(
      title: '阅读',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // themeMode: preference.colorMode,
      routerConfig: router,
    );
  }
}
