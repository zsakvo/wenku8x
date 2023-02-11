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
  flashStyle = FlashBehavior.floating,
}) {
  showFlash(
    context: context,
    duration: duration,
    builder: (context, controller) {
      return Flash(
        controller: controller,
        behavior: flashStyle,
        backgroundColor: backgroundColor,
        position: FlashPosition.bottom,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          content: Text(
            content,
            maxLines: 12,
            style: TextStyle(color: fontColor),
          ),
        ),
      );
    },
  );
}
