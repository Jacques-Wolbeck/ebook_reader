import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:ebook_reader/shared/services/api_service.dart';
import 'package:mobx/mobx.dart';
part 'books_store.g.dart';

class BooksStore = _BooksStore with _$BooksStore;

abstract class _BooksStore with Store {
  @observable
  List<BookModel> booksList = [];
  @observable
  bool isLoading = false;

  @action
  Future<void> loadData() async {
    isLoading = true;
    booksList = await ApiService.instance.fetchData();
    isLoading = false;
  }
}
