import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/modals/case_book.dart';
import 'package:wenku8x/views/home/home_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wenku8x/widgets/list_book.dart';

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
            margin: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 20.w, bottom: 4.w),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.12),
                borderRadius: BorderRadius.circular(30)),
            child: InkWell(
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
                    onTap: () => customDialog(context),
                  ))
                ],
              ),
              onTap: () {
                GoRouter.of(context).push("/search");
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          "排序方式：最近阅读",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.7),
                              fontSize: 24.sp),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.swap_horiz,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6),
                          ),
                        )
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          "视图：列表",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.7),
                              fontSize: 24.sp),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.calendar_view_month,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          Expanded(
              child: EasyRefresh(
                  refreshOnStart: true,
                  onRefresh: () async {
                    ref.read(booksListProvider.notifier).refresh();
                  },
                  child: ListView.builder(
                    itemExtent: 230.w,
                    itemCount: booksList.length,
                    itemBuilder: (context, index) {
                      final CaseBook book = booksList[index];
                      return ListBookTile(context,
                          cover: book.cover,
                          name: book.bookName,
                          desc1: "更新时间：${book.updateTime}",
                          desc2: "最新章节：${book.lastChapter}");
                    },
                  )))
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
                  left: 32.w,
                  right: 32.w),
              margin: EdgeInsets.only(bottom: 16.w),
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
                      fontFamily: "Optima",
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
                onTap: () {
                  GoRouter.of(context).push("/search");
                },
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
              margin: EdgeInsets.symmetric(vertical: 14.w, horizontal: 32.w),
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
                onTap: () {
                  GoRouter.of(context).push("/rank/allvisit");
                },
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
                onTap: () {
                  GoRouter.of(context).push("/rank/allvote");
                },
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
                onTap: () {
                  GoRouter.of(context).push("/rank/allvisit");
                },
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
                onTap: () {
                  GoRouter.of(context).push("/rank/size");
                },
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
                onTap: () {
                  GoRouter.of(context).push("/rank/fullflag");
                },
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
                onTap: () {
                  GoRouter.of(context).push("/rank/postdate");
                },
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

customDialog(BuildContext context) {
  var numberDialog = Align(
    alignment: const Alignment(0, -1),
    child: Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        padding: const EdgeInsets.all(0.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "wenku8",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Optima",
                              color: Theme.of(context).colorScheme.primary),
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
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://avatars.githubusercontent.com/u/6316115?v=4",
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
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(112.w, 56.w),
                        side: BorderSide(
                            width: 1.0,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.4)),
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
                        bottom: BorderSide(
                            width: 0.4,
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.8)),
                        top: BorderSide(
                            width: 0.4,
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.8)))),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 26, right: 26),
                    child: Icon(
                      Icons.filter_drama,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "共有 12345 经验值",
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
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
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "切换颜色模式",
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                    ),
                  )
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                      width: 0.4,
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.8)),
                )),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 26, right: 26),
                    child: Icon(
                      Icons.error_outline,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "退出登录",
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.w),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextButton(
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(164.w, 60.w)),
                      onPressed: () {},
                      child: Text(
                        "隐私权政策",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.7)),
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "·",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(140.w, 60.w)),
                      onPressed: () {},
                      child: Text("问题反馈",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.7))))
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
