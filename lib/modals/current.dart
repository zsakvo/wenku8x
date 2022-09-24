import 'dart:convert';

import 'package:equatable/equatable.dart';

class Current extends Equatable {
  final String? aid;
  final String? cid;
  final int? page;
  final int? pages;
  final int? cIndex;
  final String? chapterName;

  const Current({
    this.aid,
    this.cid,
    this.page,
    this.pages,
    this.cIndex,
    this.chapterName,
  });

  factory Current.fromMap(Map<String, dynamic> data) => Current(
        aid: data['aid'] as String?,
        cid: data['cid'] as String?,
        page: data['page'] as int?,
        pages: data['pages'] as int?,
        cIndex: data['cIndex'] as int?,
        chapterName: data['chapterName'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'aid': aid,
        'cid': cid,
        'page': page,
        'pages': pages,
        'cIndex': cIndex,
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

  Current copyWith(
      {String? aid,
      String? cid,
      int? page,
      int? pages,
      int? cIndex,
      String? chapterName}) {
    return Current(
      aid: aid ?? this.aid,
      cid: cid ?? this.cid,
      page: page ?? this.page,
      pages: pages ?? this.pages,
      cIndex: cIndex ?? this.cIndex,
      chapterName: chapterName ?? this.chapterName,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [aid, cid, page, pages, cIndex, chapterName];
}
