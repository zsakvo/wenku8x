import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:wenku8x/app/hooks/use_brightness.dart';
import 'package:wenku8x/app/services/app.dart';
import 'package:wenku8x/app/ui/router.dart';
import 'package:wenku8x/app/ui/theme/theme.dart';
import 'package:wenku8x/preference/models/preference.dart';
import 'package:wenku8x/preference/providers/preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppService().initialize();
  runApp(ProviderScope(retry: (retryCount, error) => null, child: ReaderApp()));
}

class ReaderApp extends ConsumerWidget {
  const ReaderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useBrightness(
    //   context,
    //   // autoDarkMode: preference.autoDarkMode,
    //   // isDarkMode: preference.isDarkMode,
    //   autoDarkMode: true,
    //   isDarkMode: false,
    // );
    final brightness = ref.watch(
      preferenceProvider.select((value) => value.brightness),
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: brightness == ThemeMode.dark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
      ),
      child: ToastificationWrapper(
        child: MaterialApp.router(
          title: '阅读',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: brightness,
          routerConfig: router,
        ),
      ),
    );
  }
}
