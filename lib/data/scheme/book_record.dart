import 'package:isar/isar.dart';

part 'book_record.g.dart';

@collection
class BookRecord {
  Id id = Isar.autoIncrement;

  late String aid;

  int chapterIndex = 0;

  int pageIndex = 0;
}
