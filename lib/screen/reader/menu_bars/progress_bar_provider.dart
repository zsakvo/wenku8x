import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
part 'progress_bar_provider.freezed.dart';

@freezed
class ChapterProgress with _$ChapterProgress {
  const ChapterProgress._();
  const factory ChapterProgress({
    required int chapterIndex, // 章节索引
    required int totalPages, // 章节总页数
    required int currentIndex, // 章节当前页索引
  }) = _ChapterProgress;
}

class ProgressNotifier extends AutoDisposeNotifier<ChapterProgress> {
  @override
  ChapterProgress build() {
    return const ChapterProgress(
        chapterIndex: 0, totalPages: 1, currentIndex: 0);
  }

  updateProgress(int index) {
    state = state.copyWith(currentIndex: index);
  }

  update(ChapterProgress cp) {
    state = cp;
  }
}

final progressProvider =
    NotifierProvider.autoDispose<ProgressNotifier, ChapterProgress>(
        ProgressNotifier.new);
