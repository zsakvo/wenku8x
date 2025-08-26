import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/reader/providers/menu_visible.dart';
import 'package:wenku8x/reader/services/provider.dart';

class MenuTop extends StatefulHookConsumerWidget {
  const MenuTop({
    super.key,
    required this.bookName,
    this.bottomHeight = 52,
    this.height = 64,
  });
  final double bottomHeight;
  final double height;
  final String bookName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuTopState();
}

class _MenuTopState extends ConsumerState<MenuTop> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ReaderProviderService().menuProvider_);
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding =
        MediaQuery.of(context).padding.bottom + widget.bottomHeight;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: state.topVisible ? bottomPadding : -widget.height - bottomPadding,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 8),
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
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(
                        "assets/svg/ic_search_bar_back.svg",
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurfaceVariant,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(0, -1.3),
                        child: Text(
                          widget.bookName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 1,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.skip_previous, color: colorScheme.onSurface),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(
              height: 16,
              child: VerticalDivider(
                color: colorScheme.onSurface.withOpacity(.3),
                width: 20,
                thickness: .7,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.skip_next, color: colorScheme.onSurface),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
