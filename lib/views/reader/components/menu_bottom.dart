import 'package:flutter/material.dart';

class MenuBottom extends StatefulWidget {
  const MenuBottom(
      {Key? key,
      required this.visible,
      required this.theme,
      required this.onCatalogTap,
      required this.onStyleTap,
      required this.onProgressTap,
      required this.onTextTap,
      required this.onConfigTap})
      : super(key: key);
  final bool visible;
  final Map<dynamic, dynamic> theme;

  final void Function() onCatalogTap;
  final void Function() onStyleTap;
  final void Function() onProgressTap;
  final void Function() onTextTap;
  final void Function() onConfigTap;

  @override
  State<MenuBottom> createState() => MenuBottomState();
}

class MenuBottomState extends State<MenuBottom> {
  late bool visible;
  @override
  void initState() {
    super.initState();
    visible = widget.visible;
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
    return Material(
      child: AnimatedContainer(
          width: MediaQuery.of(context).size.width,
          height: visible ? MediaQuery.of(context).viewPadding.bottom + 56 : 0,
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
          decoration: BoxDecoration(
              color: Color(widget.theme["pannelColor"]),
              border: const Border(top: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.08)))),
          child: Wrap(
            children: [
              Row(children: [
                Flexible(
                    child: Center(
                  child: IconButton(
                      onPressed: widget.onCatalogTap,
                      icon: const Icon(
                        Icons.menu,
                        size: 20,
                        color: Colors.black,
                      )),
                )),
                Flexible(
                    child: Center(
                  child: IconButton(
                      onPressed: widget.onStyleTap,
                      icon: const Icon(
                        Icons.palette_outlined,
                        size: 20,
                        color: Colors.black,
                      )),
                )),
                Flexible(
                    child: Center(
                  child: IconButton(
                      onPressed: widget.onProgressTap,
                      icon: const Icon(
                        Icons.toll,
                        size: 20,
                        color: Colors.black,
                      )),
                )),
                Flexible(
                    child: Center(
                  child: IconButton(
                      onPressed: widget.onStyleTap,
                      icon: const Icon(
                        Icons.text_format,
                        size: 20,
                        color: Colors.black,
                      )),
                )),
                Flexible(
                    child: Center(
                  child: IconButton(
                      onPressed: widget.onConfigTap,
                      icon: const Icon(
                        Icons.settings_outlined,
                        size: 20,
                        color: Colors.black,
                      )),
                )),
              ])
            ],
          )),
    );
  }
}