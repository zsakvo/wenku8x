import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

void showErrorToast(context, content) {
  _showToast(context, content,
      duration: const Duration(milliseconds: 3000),
      backgroundColor: Theme.of(context).colorScheme.error,
      fontColor: Theme.of(context).colorScheme.onError);
}

void _showToast(
  context,
  content, {
  Duration? duration,
  Color? backgroundColor,
  Color? fontColor,
}) {
  context.showFlash(
    builder: (context, controller) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Flash(
          controller: controller,
          position: FlashPosition.bottom,
          dismissDirections: const [FlashDismissDirection.startToEnd],
          child: const SizedBox(
            width: double.infinity,
            child: Material(
              elevation: 24,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('A custom with Flash'),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
