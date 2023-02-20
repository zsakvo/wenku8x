import 'package:flutter/material.dart';
import 'package:wenku8x/views/reader/constants/theme.dart';

class MenuBottom extends StatefulWidget {
  const MenuBottom(
      {Key? key,
      // required this.visible,
      required this.onCatalogTap,
      required this.onStyleTap,
      required this.onProgressTap,
      required this.onTextTap,
      required this.onConfigTap,
      required this.currentTheme})
      : super(key: key);
  // final bool visible;

  final void Function() onCatalogTap;
  final void Function() onStyleTap;
  final void Function() onProgressTap;
  final void Function() onTextTap;
  final void Function() onConfigTap;
  final ReaderTheme currentTheme;

  @override
  State<MenuBottom> createState() => MenuBottomState();
}

class MenuBottomState extends State<MenuBottom> {
  late bool visible = false;
  @override
  void initState() {
    super.initState();
    // visible = widget.visible;
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
    final currentTheme = widget.currentTheme;
    final baseHeight = MediaQuery.of(context).viewPadding.bottom + 48;
    // final currentTheme.pannelTextColor = Theme.of(context).colorScheme.onSurfaceVariant;
    // final primarayColor = Theme.of(context).colorScheme.primary;
    return Positioned(
        bottom: -baseHeight,
        left: 0,
        child: Material(
          child: AnimatedContainer(
              width: MediaQuery.of(context).size.width,
              height: visible ? 2 * baseHeight : baseHeight,
              duration: const Duration(milliseconds: 120),
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
              decoration: BoxDecoration(
                  color: currentTheme.pannelBackgroundColor,
                  border: Border(top: BorderSide(width: 0.5, color: currentTheme.dividerColor))),
              child: Wrap(
                children: [
                  Row(children: [
                    Flexible(
                        child: Center(
                      child: IconButton(
                          onPressed: widget.onCatalogTap,
                          icon: Icon(
                            Icons.menu,
                            size: 20,
                            color: currentTheme.pannelTextColor,
                          )),
                    )),
                    Flexible(
                        child: Center(
                      child: IconButton(
                          onPressed: widget.onStyleTap,
                          icon: Icon(
                            Icons.palette_outlined,
                            size: 20,
                            color: currentTheme.pannelTextColor,
                          )),
                    )),
                    Flexible(
                        child: Center(
                      child: IconButton(
                          onPressed: widget.onProgressTap,
                          icon: Icon(
                            Icons.toll,
                            size: 20,
                            color: currentTheme.pannelTextColor,
                          )),
                    )),
                    Flexible(
                        child: Center(
                      child: IconButton(
                          onPressed: widget.onTextTap,
                          icon: Icon(
                            Icons.text_format,
                            size: 20,
                            color: currentTheme.pannelTextColor,
                          )),
                    )),
                    Flexible(
                        child: Center(
                      child: IconButton(
                          onPressed: widget.onConfigTap,
                          icon: Icon(
                            Icons.settings_outlined,
                            size: 20,
                            color: currentTheme.pannelTextColor,
                          )),
                    )),
                  ])
                ],
              )),
        ));
  }
}
