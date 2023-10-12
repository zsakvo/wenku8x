// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/reader/menu_bars/menu_catalog.dart';
import 'package:wenku8x/screen/reader/menu_bars/menu_config.dart';
import 'package:wenku8x/screen/reader/menu_bars/menu_text.dart';
import 'package:wenku8x/screen/reader/menu_bars/menu_top.dart';
import 'package:wenku8x/screen/reader/menu_bars/progress_bar.dart';
import 'package:wenku8x/screen/reader/scroll_reader.dart';

import 'menu_bars/menu_bottom.dart';
import 'menu_bars/menu_theme.dart';
import 'reader_provider.dart';

class ReaderScreen extends StatefulHookConsumerWidget {
  const ReaderScreen(
      {required this.name, required this.aid, super.key, required this.cIndex});

  final String name;
  final String aid;
  final int cIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  List<Chapter> catalog = [];
  String cachedText = '';
  @override
  Widget build(BuildContext context) {
    final provider = readerProvider((widget.name, widget.aid, widget.cIndex));
    final reader = ref.watch(provider);
    final loading = ref.watch(loadingProvider);

    useEffect(() {
      Future(() {
        ref.read(loadingProvider.notifier).state = true;
      });
      Future.delayed(const Duration(milliseconds: 500)).then((value) async {
        ref.read(provider.notifier).init(context, widget.cIndex);
        await ref.read(provider.notifier).initCatalog();
        ref.read(provider.notifier).initPages();
      });
      return null;
    }, []);

    return Theme(
        data: reader.theme,
        child: Scaffold(
            body: Stack(
          children: [
            Listener(
                onPointerMove: ref.read(provider.notifier).onPointerMove,
                onPointerUp: ref.read(provider.notifier).onPointerUp,
                onPointerDown: ref.read(provider.notifier).onPointerDown,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: ScrollReader(
                      reader.pages, ref.read(provider.notifier).pageController,
                      loadNext: ref.read(provider.notifier).loadNextChapter,
                      onPageScrollEnd:
                          ref.read(provider.notifier).onPageScrollEnd),
                )),
            const MenuBottom(),
            const ProgressBar(),
            MenuCatalog(provider),
            MenuTop(provider),
            MenuPalette(provider),
            MenuText(provider),
            MenuConfig(provider),
            if (loading)
              Container(
                color: Theme.of(context).colorScheme.background,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: SizedBox(
                      width: 96, height: 3, child: LinearProgressIndicator()),
                ),
              )
          ],
        )));
  }
}
