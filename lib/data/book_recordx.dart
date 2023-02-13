import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookRecordx extends Equatable {
  final String? aid;
  final int? chapterIndex;
  final int? pageIndex;

  const BookRecordx({this.aid, this.chapterIndex, this.pageIndex});

  factory BookRecordx.fromMap(Map<String, dynamic> data) => BookRecordx(
        aid: data['aid'] as String?,
        chapterIndex: data['chapterIndex'] as int?,
        pageIndex: data['pageIndex'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'aid': aid,
        'chapterIndex': chapterIndex,
        'pageIndex': pageIndex,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookRecordx].
  factory BookRecordx.fromJson(String data) {
    return BookRecordx.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BookRecordx] to a JSON string.
  String toJson() => json.encode(toMap());

  BookRecordx copyWith({
    String? aid,
    int? chapterIndex,
    int? pageIndex,
  }) {
    return BookRecordx(
      aid: aid ?? this.aid,
      chapterIndex: chapterIndex ?? this.chapterIndex,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [aid, chapterIndex, pageIndex];
}
