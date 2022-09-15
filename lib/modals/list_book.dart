class ListBook {
  final String aid;
  final String title;
  final String hits;
  final String push;
  final String fav;
  final String author;
  final String status;
  final String lastUpdate;
  final String intro;

  const ListBook(
      {required this.aid,
      required this.title,
      required this.hits,
      required this.push,
      required this.fav,
      required this.author,
      required this.status,
      required this.lastUpdate,
      required this.intro});

  String get cover {
    int a = (int.parse(aid) / 1000).floor();
    return "http://img.wenku8.com/image/$a/$aid/${aid}s.jpg";
  }
}
