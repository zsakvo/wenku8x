import 'package:flutter/material.dart';
import 'package:wenku8x/service/navigation.dart';

final currentColorScheme = Theme.of(NavigationService.navigatorKey.currentContext!).colorScheme;

final readerBackgroundColor = currentColorScheme.background;

final readerTextColor = currentColorScheme.onBackground;

final pannelBackgroundColor = currentColorScheme.primary.withOpacity(.08);

final pannelTextColor = currentColorScheme.onBackground;

final primaryColor = currentColorScheme.primary;

final dividerColor = currentColorScheme.onBackground.withOpacity(.08);

final pannelContainerColor = currentColorScheme.surfaceVariant.withOpacity(.8);

final pannelContainerColorSelected = currentColorScheme.secondary.withOpacity(.8);

class ReaderTheme {
  final Color readerBackgroundColor;
  final Color readerTextColor;
  final Color pannelBackgroundColor;
  final Color pannelTextColor;
  final Color primaryColor;
  final Color dividerColor;
  final Color pannelContainerColor;
  final Color pannelContainerColorSelected;
  final String name;

  ReaderTheme(
      {required this.name,
      required this.readerBackgroundColor,
      required this.readerTextColor,
      required this.pannelBackgroundColor,
      required this.pannelTextColor,
      required this.primaryColor,
      required this.dividerColor,
      required this.pannelContainerColor,
      required this.pannelContainerColorSelected});
}

final monet = ReaderTheme(
    name: "莫奈",
    readerBackgroundColor: readerBackgroundColor,
    readerTextColor: readerTextColor,
    pannelBackgroundColor: pannelBackgroundColor,
    pannelTextColor: pannelTextColor,
    primaryColor: primaryColor,
    dividerColor: dividerColor,
    pannelContainerColor: pannelContainerColor,
    pannelContainerColorSelected: pannelContainerColorSelected);

final ama = ReaderTheme(
    name: "亚麻",
    readerBackgroundColor: const Color(0xfffffbf2),
    readerTextColor: const Color(0xff262626),
    pannelBackgroundColor: const Color(0xfffbfaf5),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffebe5d8),
    dividerColor: const Color(0xffe4e4e1),
    pannelContainerColor: const Color(0xfffefdfb),
    pannelContainerColorSelected: const Color(0xfff9f4ea));

final hashibami = ReaderTheme(
    name: "榛子",
    readerBackgroundColor: const Color(0xfff4e9c8),
    readerTextColor: const Color(0xff262626),
    pannelBackgroundColor: const Color(0xfff9f1da),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffddcca1),
    dividerColor: const Color(0xffe2dfd4),
    pannelContainerColor: const Color(0xfffdf9ed),
    pannelContainerColorSelected: const Color(0xfff2e7c7));

final usuao = ReaderTheme(
    name: "薄青",
    readerBackgroundColor: const Color(0xffe5f0e4),
    readerTextColor: const Color(0xff262626),
    pannelBackgroundColor: const Color(0xfff4fbf4),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffd0e2d0),
    dividerColor: const Color(0xffe1e4e1),
    pannelContainerColor: const Color(0xfffefdfb),
    pannelContainerColorSelected: const Color(0xffe2ede1));

final chigusa = ReaderTheme(
    name: "千草",
    readerBackgroundColor: const Color(0xffe0edf1),
    readerTextColor: const Color(0xff262626),
    pannelBackgroundColor: const Color(0xffe7f5f6),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffcfdde1),
    dividerColor: const Color(0xffe5e5e5),
    pannelContainerColor: const Color(0xfff3fafb),
    pannelContainerColorSelected: const Color(0xffdfecf0));

final sekichiku = ReaderTheme(
    name: "石竹",
    readerBackgroundColor: const Color(0xfff0dfdf),
    readerTextColor: const Color(0xff262626),
    pannelBackgroundColor: const Color(0xfffaeceb),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffe9cccc),
    dividerColor: const Color(0xffe5e5e5),
    pannelContainerColor: const Color(0xfffdf6f5),
    pannelContainerColorSelected: const Color(0xfff2e1e1));

final namari = ReaderTheme(
    name: "铅色",
    readerBackgroundColor: const Color(0xffdcdcdc),
    readerTextColor: const Color(0xff262626),
    pannelBackgroundColor: const Color(0xffe7e7e7),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffd0d0d0),
    dividerColor: const Color(0xffe5e5e5),
    pannelContainerColor: const Color(0xfff3f3f3),
    pannelContainerColorSelected: const Color(0xffdadada));

final karasubo = ReaderTheme(
    name: "乌羽",
    readerBackgroundColor: const Color(0xff1a1c1d),
    readerTextColor: const Color(0xff808080),
    pannelBackgroundColor: const Color(0xff17191a),
    pannelTextColor: const Color(0xff666666),
    primaryColor: const Color(0xff0f1112),
    dividerColor: const Color(0xff444444),
    pannelContainerColor: const Color(0xff232526),
    pannelContainerColorSelected: const Color(0xff181a1b));
