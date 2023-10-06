import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/main.dart';

import '../reader_provider.dart';

class MenuText extends StatefulHookConsumerWidget {
  const MenuText(this.provider, {super.key});
  final dynamic provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuTextState();
}

class _MenuTextState extends ConsumerState<MenuText>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final state = ref.watch(
        readerMenuStateProvider.select((value) => value.menuTextVisible));
    final reader = ref.watch<Reader>(widget.provider);
    final sizeVal = useState(reader.textStyle.fontSize ?? 17.0);
    final heightVal = useState(reader.textStyle.height ?? 1.7);
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 250),
        left: 0,
        bottom: state ? 42 + bottomPadding : -height,
        child: Container(
            color: Theme.of(context).colorScheme.surface,
            width: MediaQuery.of(context).size.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                child: Text(
                  "排版",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IconButton(
                      icon: Icon(
                        Icons.text_decrease,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Flexible(
                    child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor:
                              Theme.of(context).colorScheme.outline,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.background,
                          trackHeight: 16,
                          overlayShape: SliderComponentShape.noOverlay,
                          thumbColor: Theme.of(context).colorScheme.surface,
                          thumbShape: const RoundSliderThumbShape(
                            disabledThumbRadius: 9, //禁用是滑块大小
                            enabledThumbRadius: 9, //滑块大小
                          ),
                        ),
                        child: Slider(
                            value: sizeVal.value,
                            min: 14,
                            max: 32,
                            onChanged: (val) {
                              sizeVal.value = val;
                            },
                            onChangeEnd: (val) {
                              ref
                                  .read(widget.provider.notifier)
                                  .updateTextStyle(
                                      reader.textStyle.copyWith(fontSize: val));
                              sp.setDouble('fontSize', val);
                            })),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IconButton(
                      icon: Icon(
                        Icons.text_increase,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IconButton(
                      icon: Icon(
                        Icons.drag_handle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Flexible(
                    child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor:
                              Theme.of(context).colorScheme.outline,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.background,
                          trackHeight: 16,
                          overlayShape: SliderComponentShape.noOverlay,
                          thumbColor: Theme.of(context).colorScheme.surface,
                          thumbShape: const RoundSliderThumbShape(
                            disabledThumbRadius: 9, //禁用是滑块大小
                            enabledThumbRadius: 9, //滑块大小
                          ),
                        ),
                        child: Slider(
                            value: heightVal.value,
                            min: 1.3,
                            max: 2.5,
                            onChanged: (val) {
                              heightVal.value = val;
                            },
                            onChangeEnd: (val) {
                              ref
                                  .read(widget.provider.notifier)
                                  .updateTextStyle(
                                      reader.textStyle.copyWith(height: val));
                              sp.setDouble('fontHeight', val);
                            })),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.translate,
                              size: 22,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.background,
                                  minimumSize: const Size(148, 24),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "系统字体",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.keyboard_command_key,
                              size: 22,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Expanded(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    minimumSize: const Size(148, 24),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "页面边距",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  )))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}
