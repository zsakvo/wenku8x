import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:wenku8x/screen/palette/palette_provider.dart';
import 'package:wenku8x/screen/profile/profile_provider.dart';

class SelectablePalette extends StatefulHookConsumerWidget {
  const SelectablePalette(
      {super.key, required this.color, required this.isSelected});
  final PresetColors color;
  final bool isSelected;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectablePaletteState();
}

class _SelectablePaletteState extends ConsumerState<SelectablePalette> {
  @override
  Widget build(BuildContext context) {
    final tonalPalettes = CorePalette.contentOf(widget.color.color.value);
    return GestureDetector(
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surface.withOpacity(0.7)),
          child: ClipOval(
            child: SizedBox(
              width: 48,
              height: 48,
              child: Stack(children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 48,
                    height: 24,
                    decoration: BoxDecoration(
                        color: Color(tonalPalettes.primary.get(90))),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(100),
                        color: Color(tonalPalettes.secondary.get(60))),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(100),
                        color: Color(tonalPalettes.tertiary.get(90))),
                  ),
                ),
                if (widget.isSelected)
                  Positioned(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(tonalPalettes.primary.get(40)),
                      ),
                      child: const Icon(
                        Icons.check_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
              ]),
            ),
          )),
      onTap: () {
        ref
            .read(configProvider.notifier)
            .updateColorSeed(widget.color.color.value);
      },
    );
  }
}
