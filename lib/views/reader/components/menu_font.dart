import 'package:flutter/material.dart';

import '../constants/theme.dart';

class MenuFont extends StatefulWidget {
  const MenuFont(
      {super.key,
      required this.fonts,
      required this.currentTheme,
      required this.currentFont,
      required this.onFontChange});

  final List<Map<String, String>> fonts;
  final ReaderTheme currentTheme;

  final String currentFont;

  final Function(String key) onFontChange;

  @override
  State<MenuFont> createState() => MenuFontState();
}

class MenuFontState extends State<MenuFont> {
  bool visible = false;
  late String currentFont;

  @override
  void initState() {
    currentFont = widget.currentFont;
    super.initState();
  }

  void open() {
    setState(() {
      visible = true;
    });
  }

  void close() {
    setState(() {
      visible = false;
    });
  }

  void toggle() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseHeight = MediaQuery.of(context).viewPadding.bottom + 48 + 172;
    final currentTheme = widget.currentTheme;
    return Positioned(
      bottom: -baseHeight,
      left: 0,
      child: Material(
        child: AnimatedContainer(
          alignment: visible ? Alignment.topCenter : Alignment.bottomCenter,
          duration: const Duration(milliseconds: 120),
          width: MediaQuery.of(context).size.width,
          height: visible ? baseHeight * 2 : baseHeight,
          color: currentTheme.pannelBackgroundColor,
          child: Wrap(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                  child: Text(
                    "字体设置",
                    style: TextStyle(fontSize: 16, color: currentTheme.pannelTextColor, fontWeight: FontWeight.bold),
                  ),
                ),
                ...widget.fonts.map((font) {
                  return RadioListTile(
                    dense: true,
                    value: font["key"],
                    groupValue: currentFont,
                    onChanged: (v) {
                      setState(() {
                        currentFont = v!;
                      });
                      widget.onFontChange(v!);
                    },
                    title: Text(
                      font["value"]!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
