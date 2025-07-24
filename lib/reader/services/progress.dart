import 'package:wenku8x/reader/models/progress.dart';

class ReaderProgressService {
  static final ReaderProgressService _instance =
      ReaderProgressService._internal();

  ProgressModel? _progress;

  // Private constructor
  ReaderProgressService._internal();

  // Factory constructor to return the singleton instance
  factory ReaderProgressService() => _instance;

  // Method to initialize with book
  void init(ProgressModel progress) {
    _progress = progress;
  }

  // Getter for book
  ProgressModel? get progress => _progress;

  // int getCurrentProgress() {
  //   if (_progress == null) {
  //     throw Exception('ReaderProgressService not initialized with a progress');
  //   }
  //   return _progress!.paragraphIndex;
  // }

  String get chapterId {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    return _progress!.chapterId;
  }

  int get paragraphIndex {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    return _progress!.paragraphIndex;
  }

  int get lineIndex {
    if (_progress == null) {
      throw Exception('ReaderProgressService not initialized with a progress');
    }
    return _progress!.lineIndex;
  }
}
