import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/main.dart';
import 'package:wenku8x/screen/reader/reader_provider.dart';

class MenuPalette extends StatefulHookConsumerWidget {
  const MenuPalette(this.provider, {super.key});
  final dynamic provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPaletteState();
}

class _MenuPaletteState extends ConsumerState<MenuPalette> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bottomPos = useState(-height);
    // final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final reader = ref.watch(widget.provider);
    final state = ref.watch(
        readerMenuStateProvider.select((value) => value.menuThemeVisible));
    final bottomHeight = ref.watch(
        readerMenuStateProvider.select((value) => value.bottomBarHeight));
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        bottomPos.value = -context.findRenderObject()!.paintBounds.size.height;
      });
      return null;
    }, []);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      left: 0,
      bottom: state ? bottomHeight : bottomPos.value,
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        color: Theme.of(context).colorScheme.surface,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              child: Text(
                "主题",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: readerThemes.map((theme) {
                  return GestureDetector(
                    onTap: () {
                      // widget.onThemeItemTap(theme);
                      ref.read(widget.provider.notifier).updateTheme(theme.id);
                      sp.setString("themeId", theme.id);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              width: 0.7,
                              color: theme.theme.colorScheme.outline),
                          color: theme.theme.colorScheme.background
                              .withOpacity(0.5)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: ClipOval(
                                child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: reader.themeId == theme.id
                                                ? Colors.transparent
                                                : theme.theme.colorScheme
                                                    .primaryContainer),
                                        color: reader.themeId == theme.id
                                            ? theme.theme.colorScheme.primary
                                            : Colors.transparent)),
                              ),
                            ),
                            Text(
                              theme.name.split("").join("\n"),
                              style: TextStyle(
                                  color: theme.theme.colorScheme.onBackground),
                            )
                          ]),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
