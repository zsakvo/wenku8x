import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/screen/profile/profile_provider.dart';
import 'package:wenku8x/screen/profile/switch_card.dart';
import 'package:wenku8x/screen/profile/tap_card.dart';
import 'package:wenku8x/theme/extend.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final config = ref.watch(configProvider);
    final profile = ref.watch(profileProvider);
    final avatarFile = useFuture(useMemoized(() async {
      final docDir = await getApplicationDocumentsDirectory();
      return File("${docDir.path}/avatar.jpg");
    }, [profile]));
    useEffect(() {
      Future(() {
        API.getUserInfo(ref);
      });
      return null;
    }, []);
    return Scaffold(
        backgroundColor:
            Theme.of(context).extension<ExtendColors>()!.elevationBackground,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
                child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 64, bottom: 8),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                    child: Image.file(
                                  avatarFile.data ??
                                      File("assets/image/akari.jpg"),
                                  width: 64,
                                  height: 64,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/image/akari.jpg",
                                      width: 64,
                                      height: 64,
                                    );
                                  },
                                )),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile.nickname!,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          height: 1.8),
                                    ),
                                    Text(
                                      "${profile.rank!}\t/\t${profile.score!}积分",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.7),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                )),
                                IconButton.outlined(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.5),
                                            width: 0.7),
                                        minimumSize: const Size(42, 36)),
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 16),
                                    onPressed: () {
                                      API.getUserSign(ref);
                                    },
                                    icon: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Icon(
                                            Icons.water_drop_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            size: 18,
                                          ),
                                        ),
                                        Text(
                                          "签到",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ]))),
              SliverToBoxAdapter(
                  child: SwitchCard(
                title: "颜色跟随",
                subtitle: "根据系统模式自动打开或关闭暗色主题（限Android10+）",
                value: config.autoDarkMode,
                onChanged: (value) {
                  // 添加一个微小的延时，避免重构时引起的闪烁掉帧
                  Future.delayed(const Duration(milliseconds: 120)).then((_) {
                    ref
                        .read(configProvider.notifier)
                        .update(config.copyWith(autoDarkMode: value));
                  });
                },
              )),
              if (!config.autoDarkMode)
                SliverToBoxAdapter(
                    child: SwitchCard(
                  title: "深色模式",
                  subtitle: "也许能让你熬夜的时候舒适一点",
                  value: config.isDarkMode,
                  onChanged: (value) {
                    // 添加一个微小的延时，避免重构时引起的闪烁掉帧
                    Future.delayed(const Duration(milliseconds: 120)).then((_) {
                      ref
                          .read(configProvider.notifier)
                          .update(config.copyWith(isDarkMode: value));
                    });
                  },
                )),
              SliverToBoxAdapter(
                  child: SwitchCard(
                title: "壁纸主题",
                subtitle: "Material You主题可根据当前壁纸派生自定义配色主题（限Android12+）",
                value: config.dynamicColor,
                onChanged: (value) {
                  // 添加一个微小的延时，避免重构时引起的闪烁掉帧
                  Future.delayed(const Duration(milliseconds: 120)).then((_) =>
                      ref
                          .read(configProvider.notifier)
                          .update(config.copyWith(dynamicColor: value)));
                },
              )),
              if (!config.dynamicColor)
                SliverToBoxAdapter(
                    child: TapCard(
                  title: "颜色样式",
                  subtitle: "选择一组你喜欢的颜色组合，将之应用到APP内",
                  onTap: () {},
                  trailing: IconButton.filledTonal(
                      onPressed: () {
                        GoRouter.of(context).push("/palette");
                      },
                      icon: Icon(
                        Icons.palette_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                )),
              // SliverToBoxAdapter(
              //     child: SwitchCard(
              //   title: "固定排序",
              //   subtitle: "根据图书加入书架的时间顺序进行排序（默认规则为图书最后阅读时间）",
              //   value: false,
              //   onChanged: (value) {},
              // )),
              // SliverToBoxAdapter(
              //     child: SwitchCard(
              //   title: "简繁转换",
              //   subtitle: "当前为简体中文（注意，这会清除你的书籍缓存）",
              //   value: false,
              //   onChanged: (value) {},
              // )),
              // SliverToBoxAdapter(
              //     child: TapCard(
              //   title: "自定义头像",
              //   subtitle: "网站存储的用户头像质量较低，为了舒适，你可以自己设置一个地址（显然，这只在本地生效）",
              //   onTap: () {},
              //   trailing: IconButton.filledTonal(
              //       onPressed: () {},
              //       icon: Icon(
              //         Icons.face_outlined,
              //         color: Theme.of(context).colorScheme.primary,
              //       )),
              // )),
              SliverToBoxAdapter(
                  child: TapCard(
                title: "清除缓存",
                subtitle: "移除图书的章节和目录缓存（这理应不会移除你的阅读进度）",
                onTap: () {},
                trailing: IconButton.filledTonal(
                    onPressed: () {
                      clearCache();
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              )),
              SliverToBoxAdapter(
                  child: TapCard(
                title: "意见反馈",
                subtitle: "无论你有什么意见和建议，都欢迎找我聊聊。当然，这不代表一定会被实现。",
                onTap: () {},
                trailing: IconButton.filledTonal(
                    onPressed: () {
                      launchUrl(Uri.parse(
                          'https://github.com/zsakvo/wenku8x/issues/new'));
                    },
                    icon: Icon(
                      Icons.lightbulb_outline,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              )),
              SliverToBoxAdapter(
                  child: TapCard(
                title: "退出登录",
                titleColor: Theme.of(context).colorScheme.error,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                subtitle: "你的历史数据会被保留，除非额外点一下清除缓存。",
                subTitleColor:
                    Theme.of(context).colorScheme.error.withOpacity(1),
                onTap: () async {},
                trailing: IconButton.filled(
                    onPressed: () async {
                      Directory appDocDir =
                          await getApplicationDocumentsDirectory();
                      final cookieJar = PersistCookieJar(
                          storage: FileStorage(appDocDir.path));
                      cookieJar.deleteAll();
                      // ignore: use_build_context_synchronously
                      GoRouter.of(context).go("/login");
                    },
                    style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error),
                    icon: Icon(
                      Icons.exit_to_app_outlined,
                      color: Theme.of(context).colorScheme.onError,
                    )),
              )),
            ]))));
  }
}
