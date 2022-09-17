import 'package:wenku8x/utils/util.dart';

class BookMeta {
  final String? aid;
  final String? title;
  final String? author;
  final String? dayHits;
  final String? totalHits;
  final String? push;
  final String? fav;
  final String? pressId;
  final String? pressValue;
  final String? status;
  final String? lastUpdate;
  final String? bookLength;
  final String? latestSection;
  final String? intro;

  BookMeta(
      {this.aid,
      this.title,
      this.author,
      this.dayHits,
      this.totalHits,
      this.push,
      this.fav,
      this.pressId,
      this.pressValue,
      this.status,
      this.lastUpdate,
      this.bookLength,
      this.latestSection,
      this.intro});

  set value(BookMeta value) {}

  String get cover {
    return Util.getCover(aid!);
  }
}
