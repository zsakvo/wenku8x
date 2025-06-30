import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.g.dart';
part 'book.freezed.dart';

@freezed
abstract class BookModel with _$BookModel {
  const factory BookModel({
    required String aid,
    required String name,
    String? author,
    String? lastChapter,
    String? lastChapterId,
    String? lastUpdate,
    String? status,
    String? intro,
  }) = _BookModel;

  const BookModel._();

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  String get coverUrl =>
      "https://img.wenku8.com/image/${int.parse(this.aid) ~/ 1000}/${this.aid}/${this.aid}s.jpg";
}
