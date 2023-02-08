import 'package:flutter/material.dart';

class MenuBottom extends StatefulWidget {
  const MenuBottom(
      {Key? key,
      // required this.visible,
      required this.backgroundColor,
      required this.onCatalogTap,
      required this.onStyleTap,
      required this.onProgressTap,
      required this.onTextTap,
      required this.onConfigTap})
      : super(key: key);
  // final bool visible;
  final Color backgroundColor;

  final void Function() onCatalogTap;
  final void Function() onStyleTap;
  final void Function() onProgressTap;
  final void Function() onTextTap;
  final void Function() onConfigTap;

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
    final onSurfaceVariantColor =
        Theme.of(context).colorScheme.onSurfaceVariant;
    final primarayColor = Theme.of(context).colorScheme.primary;
    return Positioned(
        bottom: 0,
        left: 0,
        child: Material(
          child: AnimatedContainer(
              width: MediaQuery.of(context).size.width,
              height:
                  visible ? MediaQuery.of(context).viewPadding.bottom + 48 : 0,
              duration: const Duration(milliseconds: 120),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom),
              decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  border: const Border(
                      top: BorderSide(
                          width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.08)))),
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
                            color: onSurfaceVariantColor,
                          )),
                    )),
                    Flexible(
                        child: Center(
                      child: IconButton(
                          onPressed: widget.onStyleTap,
                          icon: Icon(
                            Icons.palette_outlined,
                            size: 20,
                            color: onSurfaceVariantColor,
                          )),
                    )),
                    Flexible(
                        child: Center(
                      child: IconButton(
                          onPressed: widget.onProgressTap,
                          icon: Icon(
                            Icons.toll,
                            size: 20,
                            color: onSurfaceVariantColor,
                          )),
                    )),
                    Flexible(
                        child: Center(
                      child: IconButton(
                          onPressed: widget.onTextTap,
                          icon: Icon(
                            Icons.text_format,
                            size: 20,
                            color: onSurfaceVariantColor,
                          )),
                    )),
                    Flexible(
                        child: Center(
                      child: IconButton(
                          onPressed: widget.onConfigTap,
                          icon: Icon(
                            Icons.settings_outlined,
                            size: 20,
                            color: onSurfaceVariantColor,
                          )),
                    )),
                  ])
                ],
              )),
        ));
  }
}
