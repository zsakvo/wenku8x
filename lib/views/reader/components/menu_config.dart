import 'package:flutter/material.dart';
import 'package:wenku8x/views/reader/constants/theme.dart';
import 'package:wenku8x/views/reader/page_string.dart';

class MenuConfig extends StatefulWidget {
  const MenuConfig(
      {Key? key,
      // required this.backgroundColor,
      // required this.primaryColor,
      // required this.secondColor,
      // required this.tertiaryColor,
      // required this.textColor
      required this.horizontal,
      required this.volumeKey,
      required this.fullNext,
      required this.hideExtra,
      required this.onChange,
      required this.currentTheme})
      : super(key: key);

  // final Color backgroundColor;
  // final Color primaryColor;
  // final Color secondColor;
  // final Color tertiaryColor;
  // final Color textColor;
  final bool horizontal;
  final bool volumeKey;
  final bool fullNext;
  final bool hideExtra;
  final void Function(String key, bool value) onChange;

  final ReaderTheme currentTheme;

  @override
  State<MenuConfig> createState() => MenuConfigState();
}

class MenuConfigState extends State<MenuConfig> {
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
    final baseHeight = MediaQuery.of(context).viewPadding.bottom + 48 + 154;
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                  child: Text(
                    "设置",
                    style: TextStyle(fontSize: 16, color: currentTheme.pannelTextColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: widget.horizontal
                                ? currentTheme.pannelContainerColor
                                : currentTheme.pannelContainerColorSelected,
                            child: IconButton(
                              onPressed: () {},
                              iconSize: 24,
                              icon: const Icon(
                                Icons.auto_stories_outlined,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              "横向翻页",
                              style: TextStyle(fontSize: 12, color: currentTheme.pannelContainerColorSelected),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: widget.volumeKey
                                ? currentTheme.pannelContainerColor
                                : currentTheme.pannelContainerColorSelected,
                            child: IconButton(
                              onPressed: () {},
                              iconSize: 24,
                              icon: const Icon(
                                Icons.volume_up_outlined,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              "音量翻页",
                              style: TextStyle(fontSize: 12, color: currentTheme.pannelContainerColorSelected),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: widget.fullNext
                                ? currentTheme.pannelContainerColor
                                : currentTheme.pannelContainerColorSelected,
                            child: IconButton(
                              onPressed: () {},
                              iconSize: 24,
                              icon: const Icon(
                                Icons.swipe_right_outlined,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              "全屏翻页",
                              style: TextStyle(fontSize: 12, color: currentTheme.pannelContainerColorSelected),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: widget.hideExtra
                                ? currentTheme.pannelContainerColor
                                : currentTheme.pannelContainerColorSelected,
                            child: IconButton(
                              onPressed: () {},
                              iconSize: 24,
                              icon: const Icon(
                                Icons.local_library_outlined,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              "沉浸阅读",
                              style: TextStyle(fontSize: 12, color: currentTheme.pannelContainerColorSelected),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
