import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuTop extends StatefulWidget {
  const MenuTop({
    Key? key,
    required this.title,
    // required this.visible,
    required this.backgroundColor,
  }) : super(key: key);
  // final bool visible;
  final Color backgroundColor;
  final String title;

  // final void Function() onCatalogTap;

  @override
  State<MenuTop> createState() => MenuTopState();
}

class MenuTopState extends State<MenuTop> {
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
    final onPrimaryContainerColor = Theme.of(context).colorScheme.onPrimaryContainer;
    return Material(
      child: AnimatedContainer(
          width: MediaQuery.of(context).size.width,
          height: visible ? MediaQuery.of(context).viewPadding.top + 48 : 0,
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              border: const Border(top: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.08)))),
          child: Row(children: [
            IconButton(
                iconSize: visible ? 20 : 0,
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: onPrimaryContainerColor,
                )),
            Expanded(
                child: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.normal, color: onPrimaryContainerColor),
            )),
          ])),
    );
  }
}
