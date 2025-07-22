import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/reader/services/provider.dart';

class MenuBookmark extends StatefulHookConsumerWidget {
  const MenuBookmark({super.key, this.bottomHeight = 52});
  final double bottomHeight;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuBookmarkState();
}

class _MenuBookmarkState extends ConsumerState<MenuBookmark> {
  @override
  Widget build(BuildContext context) {
    final menuState = ref.watch(ReaderProviderService().menuProvider_);
    final screenHeight = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding =
        widget.bottomHeight + MediaQuery.of(context).padding.bottom;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: 0,
      bottom: menuState.bookmark ? 0 : -screenHeight,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: bottomPadding + 16),
        height: screenHeight - 300,
        constraints: BoxConstraints(maxHeight: screenHeight),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Column(children: []),
      ),
    );
  }
}
