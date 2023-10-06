import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/utils/flash.dart';

import '../reader_provider.dart';

class MenuConfig extends StatefulHookConsumerWidget {
  const MenuConfig(this.provider, {super.key});
  final dynamic provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuConfigState();
}

class _MenuConfigState extends ConsumerState<MenuConfig>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final state = ref.watch(
        readerMenuStateProvider.select((value) => value.menuConfigVisible));
    final config = ref.watch(widget.provider.select((value) => value.config));
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 250),
        left: 0,
        bottom: state ? 42 + bottomPadding : -height,
        child: Container(
            // padding: const EdgeInsets.only(bottom: 0),
            color: Theme.of(context).colorScheme.surface,
            width: MediaQuery.of(context).size.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 18),
                child: Text(
                  "设置",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GridView.extent(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 8, right: 8, top: 24),
                maxCrossAxisExtent: 110,
                children: [
                  buildConfigButton(
                      label: "平移翻页",
                      icon: const Icon(
                        Icons.vertical_split_outlined,
                      ),
                      enabled: config.horizontalScroll),
                  buildConfigButton(
                    label: "滚动翻页",
                    icon: const Icon(
                      Icons.horizontal_split_outlined,
                    ),
                    enabled: config.verticalScroll,
                  ),
                  buildConfigButton(
                      label: "静默翻页",
                      icon: const Icon(
                        Icons.swipe_right_outlined,
                      ),
                      enabled: config.flickScroll),
                  buildConfigButton(
                      icon: const Icon(
                        Icons.auto_stories_outlined,
                      ),
                      label: "仿真翻页",
                      notWork: true,
                      enabled: config.simulationScroll),
                  buildConfigButton(
                      label: "音量键翻页",
                      icon: const Icon(
                        Icons.architecture_outlined,
                      ),
                      enabled: config.buttonScroll),
                  buildConfigButton(
                      label: "全局下一页",
                      icon: const Icon(
                        Icons.bolt_outlined,
                      ),
                      enabled: config.globalNext),
                  buildConfigButton(
                      label: "全屏显示",
                      icon: const Icon(
                        Icons.aspect_ratio,
                      ),
                      enabled: config.fullScreen),
                  buildConfigButton(
                      icon: const Icon(
                        Icons.local_library_outlined,
                      ),
                      label: "屏幕常亮",
                      enabled: config.keepScreenOn)
                ],
              ),
            ])));
  }

  buildConfigButton(
      {required String label,
      required Widget icon,
      Function()? onPressed,
      enabled = false,
      notWork = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: enabled
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
          child: IconButton(
            onPressed: () {
              if (notWork) Show.error("本功能暂未开放");
              if (onPressed != null) onPressed();
            },
            iconSize: 24,
            icon: icon,
            color: enabled
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.secondary),
          ),
        )
      ],
    );
  }
}
