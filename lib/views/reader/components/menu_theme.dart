import 'package:flutter/material.dart';
import 'package:wenku8x/views/reader/constants/theme.dart';

class MenuTheme extends StatefulWidget {
  const MenuTheme({super.key, required this.currentTheme, required this.onThemeItemTap});

  final ReaderTheme currentTheme;
  final void Function(ReaderTheme theme) onThemeItemTap;

  @override
  State<MenuTheme> createState() => MenuThemeState();
}

class MenuThemeState extends State<MenuTheme> {
  bool visible = false;

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
    final baseHeight = MediaQuery.of(context).viewPadding.bottom + 48 + 182;
    final ReaderTheme currentTheme = widget.currentTheme;
    return Positioned(
        bottom: -baseHeight,
        left: 0,
        child: Material(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: MediaQuery.of(context).size.width,
            height: visible ? baseHeight * 2 : baseHeight,
            color: currentTheme.pannelBackgroundColor,
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                      child: Text(
                        "主题",
                        style:
                            TextStyle(fontSize: 16, color: currentTheme.pannelTextColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: readerThemeList.map((theme) {
                            return GestureDetector(
                              onTap: () {
                                widget.onThemeItemTap(theme);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(width: 0.7, color: theme.dividerColor),
                                    color: theme.pannelContainerColor),
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 18),
                                        child: ClipOval(
                                          child: Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: currentTheme.pannelBackgroundColor),
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: currentTheme.key == theme.key
                                                      ? theme.primaryColor
                                                      : theme.pannelContainerColor)),
                                        ),
                                      ),
                                      Text(
                                        theme.name.split("").join("\n"),
                                        style: TextStyle(color: theme.pannelTextColor),
                                      )
                                    ]),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
