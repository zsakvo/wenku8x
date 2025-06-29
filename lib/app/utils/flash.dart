import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:wenku8x/app/ui/router.dart';

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
}
