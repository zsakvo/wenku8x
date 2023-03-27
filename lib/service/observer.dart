import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:wenku8x/views/reader/constants/theme.dart';

class MyObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // if (provider.runtimeType.toString() == 'StateProvider<MaterialColor>') {
    //   container.read(readerThemeProvider.notifier).update();
    // }
  }
}
