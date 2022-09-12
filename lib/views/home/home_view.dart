import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: Theme.of(context).brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: [
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                const Icon(Icons.menu),
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "搜索书籍",
                    style: TextStyle(fontSize: 16),
                  ),
                )),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://avatars.githubusercontent.com/u/6316115?v=4",
                    width: 32,
                    height: 32,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
