import 'package:wenku8x/app/models/book.dart';

class ReaderProgressService {
  static final ReaderProgressService _instance =
      ReaderProgressService._internal();

  BookModel? _book;

  // Private constructor
  ReaderProgressService._internal();

  // Factory constructor to return the singleton instance
  factory ReaderProgressService() => _instance;

  // Method to initialize with book
  void init(BookModel book) {
    _book = book;
  }

  // Getter for book
  BookModel? get book => _book;

  double getCurrentProgress() {
    if (_book == null) {
      throw Exception('ReaderProgressService not initialized with a book');
    }
    return 0.0;
  }
}
