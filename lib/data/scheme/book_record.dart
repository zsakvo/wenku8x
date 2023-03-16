import 'package:isar/isar.dart';

import 'dart:convert';

import 'package:equatable/equatable.dart';

part 'book_record.g.dart';

@collection
class BookRecord {
  Id id = Isar.autoIncrement;

  late String aid;

  int chapterIndex = 0;

  int pageIndex = 0;

  String? cfi;

  nextPage() {
    pageIndex++;
  }

  previousPage() {
    pageIndex--;
  }

  nextChapter() {
    chapterIndex++;
  }

  previousChapter() {
    chapterIndex--;
  }
}

// @collection
// class BookRecord extends Equatable {
//   final Id id = Isar.autoIncrement;
//   final String? aid;
//   final int chapterIndex;
//   final int pageIndex;

//   const BookRecord({this.aid, this.chapterIndex=0, this.pageIndex=0});

//   factory BookRecord.fromMap(Map<String, dynamic> data) => BookRecord(
//         aid: data['aid'] as String?,
//         chapterIndex: data['chapterIndex'] as int? ??0,
//         pageIndex: data['pageIndex'] as int? ??0,
//       );

//   Map<String, dynamic> toMap() => {
//         'aid': aid,
//         'chapterIndex': chapterIndex,
//         'pageIndex': pageIndex,
//       };

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object as [BookRecordx].
//   factory BookRecord.fromJson(String data) {
//     return BookRecord.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [BookRecordx] to a JSON string.
//   String toJson() => json.encode(toMap());

//   BookRecord copyWith({
//     String? aid,
//     int? chapterIndex,
//     int? pageIndex,
//   }) {
//     return BookRecord(
//       aid: aid ?? this.aid,
//       chapterIndex: chapterIndex ?? this.chapterIndex,
//       pageIndex: pageIndex ?? this.pageIndex,
//     );
//   }

//   @override
//   bool get stringify => true;

//   @override
//   List<Object?> get props => [aid, chapterIndex, pageIndex];
// }
