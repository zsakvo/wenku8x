import 'package:wenku8x/app/models/book.dart';
import 'package:wenku8x/detail/providers/catalog.dart';

class ReaderProviderService {
  static final ReaderProviderService _instance =
      ReaderProviderService._internal();
  factory ReaderProviderService() => _instance;
  ReaderProviderService._internal();

  late CatalogProvider catalogProvider_;

  init(BookModel book) {
    catalogProvider_ = catalogProvider(book.aid);
  }
}
