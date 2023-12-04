import 'package:ebook_reader/shared/database/database_controller.dart';
import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:ebook_reader/shared/services/api_service.dart';
import 'package:mobx/mobx.dart';
part 'books_store.g.dart';

class BooksStore = _BooksStore with _$BooksStore;

abstract class _BooksStore with Store {
  final DatabaseController _db = DatabaseController.dbInstance;
  @observable
  List<BookModel> booksList = [];
  @observable
  List<BookModel> favoriteBooksList = [];
  @observable
  bool isLoading = false;
  @observable
  bool isFavoriteLoading = false;

  @action
  Future<void> loadDataFromApi() async {
    isLoading = true;
    booksList = await ApiService.instance.fetchData();
    isLoading = false;
  }

  @action
  Future<void> loadDataFromDatabase() async {
    isFavoriteLoading = true;
    favoriteBooksList = await _db.getAllfavorites();
    isFavoriteLoading = false;
  }

  @action
  Future<void> addFavoriteBook(BookModel book) async {
    await _db.insert(book);
    favoriteBooksList = await _db.getAllfavorites();
  }

  @action
  Future<void> deleteFavoriteBook(BookModel book) async {
    await _db.delete(book);
    favoriteBooksList = await _db.getAllfavorites();
  }
}
