import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/screen/profile/profile_provider.dart';
import 'package:wenku8x/service/navigation.dart';

class HomeAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar(
      {Key? key,
      required this.onSearchTap,
      required this.onAddTap,
      required this.onAvatarTap})
      : super(key: key);

  final Function() onSearchTap;
  final Function() onAddTap;
  final Function() onAvatarTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final colorScheme = getColorScheme(context);
    final avatarUpdater = ref.watch(avatarExistProvider);
    final avatarFile = useFuture(
      useMemoized(() async {
        final docDir = await getApplicationDocumentsDirectory();
        var file = File("${docDir.path}/avatar.jpg");
        return file.existsSync() ? file : null;
      }, [profile, avatarUpdater]),
    );

    useEffect(() {
      API.getUserInfo(ref);
      return null;
    }, []);
    return SafeArea(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 42,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: colorScheme.surfaceVariant.withOpacity(0.5)),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/ic_topbar_search.svg",
                              width: 23,
                              height: 23,
                              colorFilter: ColorFilter.mode(
                                  colorScheme.secondary, BlendMode.srcIn),
                            ),
                            Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    child: GestureDetector(
                                      child: Text("搜索书名或作者",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: colorScheme.secondary
                                                  .withOpacity(0.8))),
                                      onTap: () {
                                        onSearchTap();
                                      },
                                    ))),
                            VerticalDivider(
                              thickness: 1.2,
                              indent: 8,
                              endIndent: 8,
                              color: colorScheme.secondary.withOpacity(0.1),
                            ),
                            GestureDetector(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 16, left: 3),
                                  child: SvgPicture.asset(
                                    "assets/svg/ic_topbar_add.svg",
                                    width: 23,
                                    height: 23,
                                    colorFilter: ColorFilter.mode(
                                        colorScheme.secondary, BlendMode.srcIn),
                                  )),
                              onTap: () {
                                onAddTap();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 原形头像
                    GestureDetector(
                      child: ClipOval(
                          child: avatarFile.data == null
                              ? Image.asset(
                                  "assets/image/akari.jpg",
                                  width: 40,
                                  height: 40,
                                )
                              : Image.file(
                                  avatarFile.data!,
                                  width: 40,
                                  height: 40,
                                  // errorBuilder: (context, error, stackTrace) {
                                  //   return Image.asset(
                                  //     "assets/image/akari.jpg",
                                  //     width: 40,
                                  //     height: 40,
                                  //   );
                                  // },
                                )),
                      onTap: () {
                        onAvatarTap();
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Divider(
                    color: colorScheme.secondary.withOpacity(0.05),
                    height: 1,
                  ),
                )
              ],
            )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(71);
}
