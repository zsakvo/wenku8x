import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:wenku8x/theme/extend.dart';
import '../service/navigation.dart';

class Show {
  static _snackbar(String content,
      {required Color backgroundColor, required Color textColor}) {
    NavigationService.navigatorKey.currentContext?.showFlash(
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
                    child: Text(content,
                        style: TextStyle(
                          color: textColor,
                        )),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static error(String err) {
    final ctx = NavigationService.navigatorKey.currentContext!;
    final colorScheme = Theme.of(ctx).colorScheme;
    _snackbar(err,
        backgroundColor: colorScheme.errorContainer,
        textColor: colorScheme.onErrorContainer);
  }

  static success(String err) {
    final ctx = NavigationService.navigatorKey.currentContext!;
    final colorScheme = Theme.of(ctx).colorScheme;
    _snackbar(err,
        backgroundColor: colorScheme.primary, textColor: colorScheme.onPrimary);
  }

  static info(String err) {
    final ctx = NavigationService.navigatorKey.currentContext!;
    final colorScheme = Theme.of(ctx).colorScheme;
    _snackbar(err,
        backgroundColor: colorScheme.tertiary,
        textColor: colorScheme.onTertiary);
  }

  static loading(Completer dissmissCompleter, {BuildContext? context}) {
    (context ?? NavigationService.navigatorKey.currentContext)?.showBlockDialog(
        dismissCompleter: dissmissCompleter,
        barrierColor: Colors.white.withOpacity(0.7));
  }

  static pannel(
      {BuildContext? context,
      required Widget Function(
              BuildContext context, FlashController<Object?> controller)
          builder}) {
    final ctx = (context ?? NavigationService.navigatorKey.currentContext)!;
    ctx.showModalFlash(
      builder: (context, controller) {
        return Align(
            alignment: Alignment.bottomCenter,
            child: FadeTransition(
                opacity:
                    controller.controller.drive(Tween(begin: 0.5, end: 1.0)),
                child: Flash(
                  controller: controller,
                  slideAnimationCreator:
                      (context, position, parent, curve, reverseCurve) {
                    return CurvedAnimation(
                            parent: parent,
                            curve: curve,
                            reverseCurve: reverseCurve)
                        .drive(Tween<Offset>(
                            begin: const Offset(
                              0.0,
                              1.0,
                            ),
                            end: Offset.zero));
                  },
                  dismissDirections: const [FlashDismissDirection.vertical],
                  child: Material(
                    color: Theme.of(context)
                        .extension<ExtendColors>()!
                        .elevationBackground,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(ctx).padding.bottom),
                        width: MediaQuery.of(ctx).size.width,
                        child: builder(context, controller)),
                  ),
                )));
      },
    );
  }
}
