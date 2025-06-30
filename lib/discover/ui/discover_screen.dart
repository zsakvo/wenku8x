import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';
import 'package:wenku8x/discover/providers/discover.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final List<RankingCategory> _rankings = [
    RankingCategory(
      title: '总榜',
      icon: Icons.trending_up,
      accentColor: const Color(0xFF2196F3),
      books: [
        BookItem(title: '修仙传奇', author: '天下归元', rank: 1),
        BookItem(title: '仙路至尊', author: '梦入神机', rank: 2),
        BookItem(title: '万界神帝', author: '唐家三少', rank: 3),
      ],
    ),
    RankingCategory(
      title: '月票榜',
      icon: Icons.ballot,
      accentColor: const Color(0xFF9C27B0),
      books: [
        BookItem(title: '星辰变', author: '我吃西红柿', rank: 1),
        BookItem(title: '斗破苍穹', author: '天蚕土豆', rank: 2),
        BookItem(title: '完美世界', author: '辰东', rank: 3),
      ],
    ),
    RankingCategory(
      title: '推荐榜',
      icon: Icons.favorite_border,
      accentColor: const Color(0xFF4CAF50),
      books: [
        BookItem(title: '神墓', author: '辰东', rank: 1),
        BookItem(title: '择天记', author: '猫腻', rank: 2),
        BookItem(title: '庆余年', author: '猫腻', rank: 3),
      ],
    ),
    RankingCategory(
      title: '字数榜',
      icon: Icons.format_list_numbered,
      accentColor: const Color(0xFFFF9800),
      books: [
        BookItem(title: '一念永恒', author: '耳根', rank: 1),
        BookItem(title: '武动乾坤', author: '天蚕土豆', rank: 2),
        BookItem(title: '大主宰', author: '天蚕土豆', rank: 3),
      ],
    ),
    RankingCategory(
      title: '新书榜',
      icon: Icons.new_releases_outlined,
      accentColor: const Color(0xFFF44336),
      books: [
        BookItem(title: '道君', author: '跃千愁', rank: 1),
        BookItem(title: '万古神帝', author: '飞天鱼', rank: 2),
        BookItem(title: '帝霸', author: '厌笔萧生', rank: 3),
      ],
    ),
    RankingCategory(
      title: '收藏榜',
      icon: Icons.bookmark_border,
      accentColor: const Color(0xFF607D8B),
      books: [
        BookItem(title: '雪中悍刀行', author: '烽火戏诸侯', rank: 1),
        BookItem(title: '剑来', author: '烽火戏诸侯', rank: 2),
        BookItem(title: '将夜', author: '猫腻', rank: 3),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final discovers = ref.watch(discoverAllProvider);
    return Scaffold(
      appBar: AppTopBar(title: "发现"),
      body: RefreshIndicator.adaptive(
        onRefresh: ref.read(discoverAllProvider.notifier).refresh,
        child: switch (discovers) {
          AsyncData(:final value) => ListView.builder(
            padding: const EdgeInsets.only(left: 16, right: 16),
            itemCount: value.length,
            itemBuilder: (context, index) {
              final ranking = value[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildRankingSection(ranking),
              );
            },
          ),
          _ => const Center(child: Text("暂无数据")),
        },
      ),
      // ListView.builder(
      //   padding: const EdgeInsets.all(16.0),
      //   itemCount: _rankings.length,
      //   itemBuilder: (context, index) {
      //     final ranking = _rankings[index];
      //     return Padding(
      //       padding: const EdgeInsets.only(bottom: 24.0),
      //       child: _buildRankingSection(ranking),
      //     );
      //   },
      // ),
    );
  }

  Widget _buildRankingSection(Map<String, dynamic> ranking) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 榜单标题区域
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3),
                  width: 6,
                  height: 20,
                  decoration: BoxDecoration(
                    color: ranking['color'],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  ranking['title'],
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
          // 分割线
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.grey[100],
          ),
          // 书籍列表
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: (ranking['data'] as List<BookModel>)
                  .mapIndexed(
                    (index, book) =>
                        _buildBookRow(book, ranking['color'], index),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookRow(BookModel book, Color accentColor, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          // 排名
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: index <= 2 ? accentColor : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: index <= 2 ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 书籍封面
          Container(
            width: 32,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[300]!, width: 0.5),
            ),
            child: CachedNetworkImage(
              imageUrl: book.coverUrl,
              fit: BoxFit.cover,
              width: 42,
              height: 68,
              httpHeaders: {
                "User-Agent":
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3",
              },
            ),
          ),
          const SizedBox(width: 12),
          // 书籍信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  book.author!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RankingCategory {
  final String title;
  final IconData icon;
  final Color accentColor;
  final List<BookItem> books;

  RankingCategory({
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.books,
  });
}

class BookItem {
  final String title;
  final String author;
  final int rank;

  BookItem({required this.title, required this.author, required this.rank});
}
