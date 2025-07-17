import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:wenku8x/app/ui/router.dart';

enum DrawerPlacement { left, right, bottom }

class FlashHelper {
  static _showSnackbar(
    String content, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    rootNavigatorKey.currentContext?.showFlash(
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Flash(
            controller: controller,
            position: FlashPosition.bottom,
            forwardAnimationCurve: Curves.easeInCirc,
            reverseAnimationCurve: Curves.bounceIn,
            dismissDirections: const [FlashDismissDirection.startToEnd],
            child: SizedBox(
              width: double.infinity,
              child: Material(
                elevation: 24,
                color: backgroundColor,
                child: SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(content, style: TextStyle(color: textColor)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showLoading({BuildContext? context}) {
    context ??= rootNavigatorKey.currentContext;
    if (context == null) {
      throw Exception("Context is null, cannot show loading dialog.");
    }
    final colorScheme = Theme.of(context).colorScheme;
    context.showBlockDialog(barrierColor: colorScheme.surface.withAlpha(170));
  }

  static showError(dynamic err) {
    final ctx = rootNavigatorKey.currentContext;
    if (ctx == null) {
      throw Exception("Context is null, cannot show error snackbar.");
    }
    err = err.toString();
    final colorScheme = Theme.of(ctx).colorScheme;
    _showSnackbar(
      err,
      backgroundColor: colorScheme.errorContainer,
      textColor: colorScheme.onErrorContainer,
    );
  }

  static showDrawer<T>({
    BuildContext? context,
    DrawerPlacement placement = DrawerPlacement.left,
    required Widget Function(
      BuildContext context,
      FlashController<T?> controller,
    )
    childBuilder,
  }) {
    final ctx = context ?? rootNavigatorKey.currentContext;
    if (ctx == null) {
      throw Exception("Context is null, cannot show drawer.");
    }
    final _tween = switch (placement) {
      DrawerPlacement.left => Tween<Offset>(
        begin: Offset(-1.0, 0.0),
        end: Offset.zero,
      ),
      DrawerPlacement.right => Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset.zero,
      ),
      DrawerPlacement.bottom => Tween<Offset>(
        begin: Offset(0.0, 1.0),
        end: Offset.zero,
      ),
    };
    final alignment = switch (placement) {
      DrawerPlacement.left => AlignmentDirectional.centerStart,
      DrawerPlacement.right => AlignmentDirectional.centerEnd,
      DrawerPlacement.bottom => AlignmentDirectional.bottomCenter,
    };
    final _dismissDirections = switch (placement) {
      DrawerPlacement.left => [FlashDismissDirection.startToEnd],
      DrawerPlacement.right => [FlashDismissDirection.endToStart],
      DrawerPlacement.bottom => [FlashDismissDirection.vertical],
    };
    ctx.showModalFlash<T>(
      builder: (context, controller) {
        return Align(
          alignment: alignment,
          child: FadeTransition(
            opacity: controller.controller.drive(Tween(begin: 0.5, end: 1.0)),
            child: Flash(
              controller: controller,
              position: FlashPosition.bottom,
              slideAnimationCreator:
                  (context, position, parent, curve, reverseCurve) {
                    return CurvedAnimation(
                      parent: parent,
                      curve: curve,
                      reverseCurve: reverseCurve,
                    ).drive(_tween);
                  },
              dismissDirections: _dismissDirections,
              child: childBuilder(context, controller),
              //  FractionallySizedBox(
              //   widthFactor: 0.8,
              //   child: Material(
              //     elevation: 24,
              //     clipBehavior: Clip.antiAlias,
              //     shape: const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(8)),
              //     ),
              //     child: SafeArea(
              //       child: Column(
              //         children: [
              //           Padding(
              //             padding: EdgeInsets.all(16),
              //             child: Text('A custom with Flash'),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ),
          ),
        );
      },
    );
  }
}

showSelectionDialog<T>({BuildContext? context}) {
  context ??= rootNavigatorKey.currentContext;
  if (context == null) {
    throw Exception("Context is null, cannot show selection dialog.");
  }
  context.showModalFlash(
    builder: (context, controller) => Align(
      alignment: Alignment.bottomCenter,
      child: FadeTransition(
        opacity: controller.controller.drive(
          CurveTween(curve: Curves.fastOutSlowIn),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 12),
          child: Flash(
            controller: controller,
            position: FlashPosition.bottom,
            dismissDirections: [FlashDismissDirection.vertical],
            slideAnimationCreator:
                (context, position, parent, curve, reverseCurve) {
                  return CurvedAnimation(
                    parent: parent,
                    curve: curve,
                    reverseCurve: reverseCurve,
                  ).drive(
                    Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero),
                  );
                },
            child: Dialog(
              alignment: Alignment.bottomCenter,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                side: BorderSide(),
              ),
              insetPadding: ,
              
              child: SizedBox(
                width: double.infinity,
                height: 400,
                child: Text('Content'),
              ),
            
            ),
          ),
        ),
      ),
    ),
  );
}
