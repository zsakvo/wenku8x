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
      this.latestSection});

  set value(BookMeta value) {}
}
