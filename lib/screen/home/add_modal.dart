import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddModal extends StatefulHookConsumerWidget {
  const AddModal(this.controller, {super.key});
  final FlashController<Object?> controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModalState();
}

class _AddModalState extends ConsumerState<AddModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16, top: 4),
            child: Text(
              "添加书籍",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          GridView.extent(
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
            maxCrossAxisExtent: 120,
            children: [
              buildButton(
                  title: "点击榜单",
                  icon: "assets/svg/ic_pannel_vip.svg",
                  onTap: () {
                    widget.controller.dismiss();
                    GoRouter.of(context).push("/rank/visit/点击榜");
                  }),
              buildButton(
                  title: "推荐榜单",
                  icon: "assets/svg/ic_pannel_thumb.svg",
                  onTap: () {
                    widget.controller.dismiss();
                    GoRouter.of(context).push("/rank/vote/推荐榜");
                  }),
              buildButton(
                  title: "最新入库",
                  icon: "assets/svg/ic_pannel_drive.svg",
                  onTap: () {
                    widget.controller.dismiss();
                    GoRouter.of(context).push("/rank/postdate/最新入库");
                  }),
              buildButton(
                  title: "收藏排行",
                  icon: "assets/svg/ic_pannel_medal.svg",
                  onTap: () {
                    widget.controller.dismiss();
                    GoRouter.of(context).push("/rank/goodnum/收藏排行");
                  }),
              buildButton(
                  title: "字数排行",
                  icon: "assets/svg/ic_pannel_seeding.svg",
                  onTap: () {
                    widget.controller.dismiss();
                    GoRouter.of(context).push("/rank/size/字数排行");
                  }),
              buildButton(
                  title: "完结小说",
                  icon: "assets/svg/ic_pannel_nft.svg",
                  onTap: () {
                    widget.controller.dismiss();
                    GoRouter.of(context).push("/rank/fullflag/完结小说");
                  }),
              buildButton(
                  title: "最近更新",
                  icon: "assets/svg/ic_pannel_pen.svg",
                  onTap: () {
                    widget.controller.dismiss();
                    GoRouter.of(context).push("/rank/lastupdate/最近更新");
                  }),
              buildButton(
                  title: "搜索书籍",
                  icon: "assets/svg/ic_topbar_search.svg",
                  onTap: () {
                    widget.controller.dismiss();
                    GoRouter.of(context).push("/search");
                  }),
            ],
          ),
          FilledButton.tonal(
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  fixedSize: Size(MediaQuery.of(context).size.width - 32, 48)),
              onPressed: () {
                widget.controller.dismiss();
              },
              child: const Text("取消"))
        ],
      ),
    );
  }

  buildButton(
      {required String title, required String icon, VoidCallback? onTap}) {
    return SizedBox(
      width: 64,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Theme.of(context).colorScheme.surface,
                child: SvgPicture.asset(
                  icon,
                  width: 28,
                  height: 28,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
