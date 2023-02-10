import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:wenku8x/utils/log.dart';
import 'package:wenku8x/views/home/home_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wenku8x/widgets/list_book.dart';

import '../../data/scheme/case_book.dart';

const ranks = [
  {"icon": Icons.pan_tool_alt_outlined, "title": "点击"},
  {"icon": Icons.thumb_up_alt_outlined, "title": "推荐"},
  {"icon": Icons.file_open_outlined, "title": "收藏"},
  {"icon": Icons.edit_road_outlined, "title": "字数"},
  {"icon": Icons.school_outlined, "title": "完结"},
  {"icon": Icons.av_timer_outlined, "title": "新书"},
];

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final List<CaseBook> booksList = ref.watch(booksListProvider);
    return Scaffold(
      key: _scaffoldKey,
      body: EasyRefresh(
          refreshOnStart: true,
          onRefresh: () async {
            ref.read(booksListProvider.notifier).refresh();
          },
          child: CustomScrollView(slivers: [
            SliverAppBar.large(
                pinned: true,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu))
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    '书架',
                    style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
                  ),
                  centerTitle: false,
                  titlePadding: const EdgeInsetsDirectional.only(
                    start: 16.0,
                    bottom: 16.0,
                  ),
                )),
            const HeaderLocator.sliver(),
            const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
            SliverList(
                delegate: SliverChildListDelegate((booksList
                    .map((book) => ListBookTile(context,
                            cover: book.cover,
                            name: book.bookName,
                            desc1: "更新时间：${book.updateTime}",
                            desc2: "最新章节：${book.lastChapter}", onTap: () {
                          GoRouter.of(context).push("/reader?aid=${book.aid}&name=${book.bookName}");
                        }))
                    .toList()))),
            const FooterLocator.sliver(),
          ])),
      drawer: NavigationDrawer(
        selectedIndex: -1,
        onDestinationSelected: (value) {
          Log.d(value, "vvvv");
          switch (value) {
            case 2:
              GoRouter.of(context).push("/rank/allvisit");
              break;
            case 3:
              GoRouter.of(context).push("/rank/allvote");
              break;
            case 4:
              GoRouter.of(context).push("/rank/allvisit");
              break;
            case 5:
              GoRouter.of(context).push("/rank/size");
              break;
            case 6:
              GoRouter.of(context).push("/rank/fullflag");
              break;
            case 7:
              GoRouter.of(context).push("/rank/postdate");
              break;

            case 8:
              GoRouter.of(context).push("/preference");
              break;
          }
          _scaffoldKey.currentState!.closeDrawer();
        },
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(28, MediaQuery.of(context).padding.top + 16, 16, 10),
            child: Text(
              '常用',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const NavigationDrawerDestination(
            label: Text("搜索"),
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
          ),
          const NavigationDrawerDestination(
            label: Text("历史"),
            icon: Icon(Icons.settings_backup_restore),
            selectedIcon: Icon(Icons.settings_backup_restore),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 8, 28, 8),
            child: Divider(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              '排行',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ...ranks
              .map((rank) => NavigationDrawerDestination(
                    label: Text(rank["title"].toString()),
                    icon: Icon(rank["icon"] as IconData),
                  ))
              .toList(),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 8, 28, 8),
            child: Divider(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              '应用',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const NavigationDrawerDestination(
            label: Text("设置"),
            icon: Icon(Icons.settings_outlined),
          ),
          const NavigationDrawerDestination(
            label: Text("关于"),
            icon: Icon(Icons.help_outline),
          ),
        ],
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
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
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

customDialog(BuildContext context) {
  var numberDialog = Align(
    alignment: const Alignment(0, -1),
    child: Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        padding: const EdgeInsets.all(0.0),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "wenku8",
                      style:
                          TextStyle(fontSize: 18, fontFamily: "Optima", color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
                const InkWell(
                  child: Icon(Icons.close),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 18, left: 18, right: 18),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ClipOval(
                    child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: CachedNetworkImage(
                    imageUrl: "https://avatars.githubusercontent.com/u/6316115?v=4",
                    width: 42,
                    height: 42,
                  ),
                  onTap: () => customDialog(context),
                )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "沚水",
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      "UID 118943745",
                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(64, 32),
                    side: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),
                    textStyle: TextStyle(fontSize: 20.sp),
                  ),
                  onPressed: () {
                    GoRouter.of(context).go('/login');
                  },
                  child: const Text("签到"))
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.4, color: Theme.of(context).colorScheme.outline.withOpacity(0.8)),
                    top: BorderSide(width: 0.4, color: Theme.of(context).colorScheme.outline.withOpacity(0.8)))),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 26, right: 26),
                child: Icon(
                  Icons.filter_drama,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
              Text(
                "共有 12345 经验值",
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                ),
              )
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 26, right: 26),
                child: Icon(
                  Icons.invert_colors,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
              Text(
                "切换颜色模式",
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                ),
              )
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 0.4, color: Theme.of(context).colorScheme.outline.withOpacity(0.8)),
            )),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 26, right: 26),
                child: Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
              Text(
                "退出登录",
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                ),
              )
            ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.w),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(100, 32)),
                  onPressed: () {},
                  child: Text(
                    "隐私权政策",
                    style:
                        TextStyle(fontSize: 20.sp, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "·",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(100, 32)),
                  onPressed: () {},
                  child: Text("问题反馈",
                      style: TextStyle(
                          fontSize: 20.sp, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7))))
            ]),
          )
        ]),
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.only(top: 80),
        child: numberDialog,
      );
    },
  );
}
