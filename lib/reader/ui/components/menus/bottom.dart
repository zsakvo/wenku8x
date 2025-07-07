import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MenuBottom extends HookConsumerWidget {
  final bool isVisible;
  final Widget? child;
  final double height;

  const MenuBottom({
    super.key,
    this.isVisible = false,
    this.child,
    this.height = 200, // 默认高度
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 使用 hooks 监听 isVisible 变化
    final isVisibleState = useState(isVisible);

    // 当属性变化时更新状态
    useEffect(() {
      isVisibleState.value = isVisible;
      return null;
    }, [isVisible]);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          bottom: isVisibleState.value ? 0 : -height,
          left: 0,
          right: 0,
          height: height,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
