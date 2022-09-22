import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Current {
  String? aid;
  String? cid;
  String? nextCid;
  int page;
  int pages;
  int cIndex;
  String? chapterName;
  AnimationController? controller;

  Current(
      {this.aid,
      this.cid,
      this.nextCid,
      required this.page,
      required this.pages,
      required this.cIndex,
      this.chapterName,
      this.controller});

  @override
  String toString() {
    return 'Current(aid: $aid, cid: $cid, nextCid: $nextCid, page: $page, pages: $pages, cIndex: $cIndex, chapterName: $chapterName, controller: $controller)';
  }

  factory Current.fromMap(Map<String, dynamic> data) => Current(
        aid: data['aid'] as String?,
        cid: data['cid'] as String?,
        nextCid: data['nextCid'] as String?,
        page: data['page'] as int,
        pages: data['pages'] as int,
        cIndex: data['cIndex'] as int,
        chapterName: data['chapterName'] as String?,
        controller: data['controller'] as AnimationController?,
      );

  Map<String, dynamic> toMap() => {
        'aid': aid,
        'cid': cid,
        'nextCid': nextCid,
        'page': page,
        'pages': pages,
        'cIndex': cIndex,
        'chapterName': chapterName,
        'controller': controller
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
    String? cid,
    String? nextCid,
    int? page,
    int? pages,
    int? cIndex,
    String? chapterName,
    AnimationController? controller,
  }) {
    return Current(
      aid: aid ?? this.aid,
      cid: cid ?? this.cid,
      nextCid: nextCid ?? this.nextCid,
      page: page ?? this.page,
      pages: pages ?? this.pages,
      cIndex: cIndex ?? this.cIndex,
      chapterName: chapterName ?? this.chapterName,
      controller: controller ?? this.controller,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Current) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      aid.hashCode ^
      cid.hashCode ^
      page.hashCode ^
      pages.hashCode ^
      cIndex.hashCode ^
      chapterName.hashCode ^
      controller.hashCode;
}
