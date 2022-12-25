import 'dart:convert';

import 'package:equatable/equatable.dart';

class Current extends Equatable {
  final String? aid;
  final int? page;
  final String? cid;
  final int? chapter;
  final String? chapterName;

  const Current({
    this.aid,
    this.page,
    this.cid,
    this.chapter,
    this.chapterName,
  });

  factory Current.fromMap(Map<String, dynamic> data) => Current(
        aid: data['aid'] as String?,
        page: data['page'] as int?,
        cid: data['cid'] as String?,
        chapter: data['chapter'] as int?,
        chapterName: data['chapterName'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'aid': aid,
        'page': page,
        'cid': cid,
        'chapter': chapter,
        'chapterName': chapterName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Current].
  factory Current.fromJson(String data) {
    return Current.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Current] to a JSON string.
  String toJson() => json.encode(toMap());

  Current copyWith({
    String? aid,
    int? page,
    String? cid,
    int? chapter,
    String? chapterName,
  }) {
    return Current(
      aid: aid ?? this.aid,
      page: page ?? this.page,
      cid: cid ?? this.cid,
      chapter: chapter ?? this.chapter,
      chapterName: chapterName ?? this.chapterName,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [aid, page, cid, chapter, chapterName];
}
