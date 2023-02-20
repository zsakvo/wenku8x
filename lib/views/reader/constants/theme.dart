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
  final Color readerInfoColor;
  final Color pannelBackgroundColor;
  final Color pannelTextColor;
  final Color primaryColor;
  final Color dividerColor;
  final Color pannelContainerColor;
  final Color pannelContainerColorSelected;
  final String name;
  final String key;

  ReaderTheme(
      {required this.name,
      required this.key,
      required this.readerBackgroundColor,
      required this.readerTextColor,
      required this.readerInfoColor,
      required this.pannelBackgroundColor,
      required this.pannelTextColor,
      required this.primaryColor,
      required this.dividerColor,
      required this.pannelContainerColor,
      required this.pannelContainerColorSelected});
}

final monet = ReaderTheme(
    name: "莫奈",
    key: 'monet',
    readerBackgroundColor: readerBackgroundColor,
    readerTextColor: readerTextColor,
    readerInfoColor: readerTextColor,
    pannelBackgroundColor: pannelBackgroundColor,
    pannelTextColor: pannelTextColor,
    primaryColor: primaryColor,
    dividerColor: dividerColor,
    pannelContainerColor: pannelContainerColor,
    pannelContainerColorSelected: pannelContainerColorSelected);

final ama = ReaderTheme(
    name: "亚麻",
    key: 'ama',
    readerBackgroundColor: const Color(0xfff6f1e7),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff96928c),
    pannelBackgroundColor: const Color(0xfffbfaf5),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffebe5d8),
    dividerColor: const Color(0xffdbd6cd),
    pannelContainerColor: const Color(0xfff3f0e8),
    pannelContainerColorSelected: const Color(0xfff9f4ea));

final hashibami = ReaderTheme(
    name: "榛子",
    key: 'hashibami',
    readerBackgroundColor: const Color(0xfff4e9c8),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff908b76),
    pannelBackgroundColor: const Color(0xfff9f1da),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffddcca1),
    dividerColor: const Color(0xffd8d0b0),
    pannelContainerColor: const Color(0xffeae1c8),
    pannelContainerColorSelected: const Color(0xfff2e7c7));

final usuao = ReaderTheme(
    name: "薄青",
    key: 'usuao',
    readerBackgroundColor: const Color(0xffe5f0e4),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff959e95),
    pannelBackgroundColor: const Color(0xfff4fbf4),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffd0e2d0),
    dividerColor: const Color(0xffcad5ca),
    pannelContainerColor: const Color(0xffe1ece1),
    pannelContainerColorSelected: const Color(0xffe2ede1));

final chigusa = ReaderTheme(
    name: "千草",
    key: 'chigusa',
    readerBackgroundColor: const Color(0xffe0edf1),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff879092),
    pannelBackgroundColor: const Color(0xffe7f5f6),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffcfdde1),
    dividerColor: const Color(0xffc7d1d5),
    pannelContainerColor: const Color(0xffe2eaec),
    pannelContainerColorSelected: const Color(0xffdfecf0));

final sekichiku = ReaderTheme(
    name: "石竹",
    key: 'sekichiku',
    readerBackgroundColor: const Color(0xfff0dfdf),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff9d9292),
    pannelBackgroundColor: const Color(0xfffaeceb),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffe9cccc),
    dividerColor: const Color(0xffd8c9c9),
    pannelContainerColor: const Color(0xfff3e1e1),
    pannelContainerColorSelected: const Color(0xfff2e1e1));

final namari = ReaderTheme(
    name: "铅色",
    key: 'namari',
    readerBackgroundColor: const Color(0xffdcdcdc),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff868686),
    pannelBackgroundColor: const Color(0xffe7e7e7),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffd0d0d0),
    dividerColor: const Color(0xffc6c5c6),
    pannelContainerColor: const Color(0xffe2e2e2),
    pannelContainerColorSelected: const Color(0xffdadada));

final karasubo = ReaderTheme(
    name: "乌羽",
    key: 'karasubo',
    readerBackgroundColor: const Color(0xff1a1c1d),
    readerTextColor: const Color(0xff808080),
    readerInfoColor: const Color(0xff7e7e7e),
    pannelBackgroundColor: const Color(0xff17191a),
    pannelTextColor: const Color(0xff999999),
    primaryColor: const Color(0xff0f1112),
    dividerColor: const Color(0xff444444),
    pannelContainerColor: const Color(0xff202122),
    pannelContainerColorSelected: const Color(0xff181a1b));

final readerThemeList = [monet, ama, hashibami, usuao, chigusa, sekichiku, namari, karasubo];
