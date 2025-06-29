import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/hooks/use_brightness.dart';
import 'package:wenku8x/app/services/app.dart';
import 'package:wenku8x/app/ui/router.dart';
import 'package:wenku8x/app/ui/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppService().initialize();
  runApp(ProviderScope(retry: (retryCount, error) => null, child: ReaderApp()));
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
