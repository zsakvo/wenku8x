import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/reader/reader_provider.dart';

class MenuTop extends StatefulHookConsumerWidget {
  const MenuTop(this.provider, {super.key});
  final dynamic provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuTopState();
}

class _MenuTopState extends ConsumerState<MenuTop>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final reader = ref.watch(widget.provider);
    final height = MediaQuery.of(context).size.height;
    final topPos = useState(-height);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        topPos.value = -context.findRenderObject()!.paintBounds.size.height;
      });
      return null;
    }, []);

    final state = ref
        .watch(readerMenuStateProvider.select((value) => value.menuTopVisible));
    return AnimatedPositioned(
        top: state ? 0 : topPos.value,
        left: 0,
        duration: const Duration(milliseconds: 200),
        child: Material(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 8, bottom: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                  Expanded(
                      child: Text(
                    reader.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16),
                  )),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
                  // const SizedBox(
                  //   width: 36,
                  // )
                ],
              )),
        ));
  }
}
