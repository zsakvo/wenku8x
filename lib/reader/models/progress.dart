import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress.freezed.dart';
part 'progress.g.dart';

@freezed
abstract class ProgressModel with _$ProgressModel {
  const factory ProgressModel({
    required String bookId,
    required String chapterId,
    @Default(0) int paragraphIndex,
    @Default(0) int lineIndex,
  }) = _ProgressModel;

  factory ProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressModelFromJson(json);

  const ProgressModel._();
}
