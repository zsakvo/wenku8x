import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/views/home/home_model.dart';

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final drawerVisible = ref.watch(drawerToggleProvider);
    return Scaffold(
      key: _scaffoldKey,
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.12),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => onMenuBtnTap(_scaffoldKey),
                    icon: const Icon(Icons.menu)),
                const Expanded(
                    child: Text(
                  "搜索书籍",
                  style: TextStyle(fontSize: 16),
                )),
                ClipOval(
                    child: InkWell(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://avatars.githubusercontent.com/u/6316115?v=4",
                    width: 32,
                    height: 32,
                  ),
                  onTap: () => dialogBuilder(context),
                ))
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 16,
                  bottom: 16,
                  left: 20,
                  right: 20),
              margin: const EdgeInsets.only(bottom: 16),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.8,
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withOpacity(0.1)))),
              child: Text(
                "wenku8",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            ListTile(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
                tileColor:
                    Theme.of(context).colorScheme.outline.withOpacity(0.1),
                leading: const Icon(Icons.favorite_border),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "收藏",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.search),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "搜索",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.history),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "历史",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Text(
                "排行榜单",
                style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 2,
                    color: Theme.of(context).colorScheme.outline),
              ),
            ),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.label_outline),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "点击榜",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.label_outline),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "推荐榜",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.label_outline),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "收藏榜",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.label_outline),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "字数榜",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.label_outline),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "完结榜",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.label_outline),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "新入库",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                thickness: 0.7,
                height: 0.7,
                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              ),
            ),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.settings_outlined),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "设置",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
            ListTile(
                tileColor: Colors.transparent,
                leading: const Icon(Icons.help_outline),
                title: Transform.translate(
                  offset: const Offset(-16, -1),
                  child: Text(
                    "帮助与反馈",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}

Function onMenuBtnTap = (GlobalKey<ScaffoldState> key) {
  key.currentState?.openDrawer();
};

Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Transform.translate(
        offset: Offset(0, -(MediaQuery.of(context).size.height) / 2 + 170),
        child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            insetPadding: const EdgeInsets.symmetric(horizontal: 0),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              child: const Text('A dialog is a type of modal window that\n'
                  'appears in front of app content to\n'
                  'provide critical information, or prompt\n'
                  'for a decision to be made.'),
            )),
      );
    },
  );
}
