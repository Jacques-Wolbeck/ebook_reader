// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BooksStore on _BooksStore, Store {
  late final _$booksListAtom =
      Atom(name: '_BooksStore.booksList', context: context);

  @override
  List<BookModel> get booksList {
    _$booksListAtom.reportRead();
    return super.booksList;
  }

  @override
  set booksList(List<BookModel> value) {
    _$booksListAtom.reportWrite(value, super.booksList, () {
      super.booksList = value;
    });
  }

  late final _$favoriteBooksListAtom =
      Atom(name: '_BooksStore.favoriteBooksList', context: context);

  @override
  List<BookModel> get favoriteBooksList {
    _$favoriteBooksListAtom.reportRead();
    return super.favoriteBooksList;
  }

  @override
  set favoriteBooksList(List<BookModel> value) {
    _$favoriteBooksListAtom.reportWrite(value, super.favoriteBooksList, () {
      super.favoriteBooksList = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_BooksStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isFavoriteLoadingAtom =
      Atom(name: '_BooksStore.isFavoriteLoading', context: context);

  @override
  bool get isFavoriteLoading {
    _$isFavoriteLoadingAtom.reportRead();
    return super.isFavoriteLoading;
  }

  @override
  set isFavoriteLoading(bool value) {
    _$isFavoriteLoadingAtom.reportWrite(value, super.isFavoriteLoading, () {
      super.isFavoriteLoading = value;
    });
  }

  late final _$loadDataFromApiAsyncAction =
      AsyncAction('_BooksStore.loadDataFromApi', context: context);

  @override
  Future<void> loadDataFromApi() {
    return _$loadDataFromApiAsyncAction.run(() => super.loadDataFromApi());
  }

  late final _$loadDataFromDatabaseAsyncAction =
      AsyncAction('_BooksStore.loadDataFromDatabase', context: context);

  @override
  Future<void> loadDataFromDatabase() {
    return _$loadDataFromDatabaseAsyncAction
        .run(() => super.loadDataFromDatabase());
  }

  late final _$addFavoriteBookAsyncAction =
      AsyncAction('_BooksStore.addFavoriteBook', context: context);

  @override
  Future<void> addFavoriteBook(BookModel book) {
    return _$addFavoriteBookAsyncAction.run(() => super.addFavoriteBook(book));
  }

  late final _$deleteFavoriteBookAsyncAction =
      AsyncAction('_BooksStore.deleteFavoriteBook', context: context);

  @override
  Future<void> deleteFavoriteBook(BookModel book) {
    return _$deleteFavoriteBookAsyncAction
        .run(() => super.deleteFavoriteBook(book));
  }

  @override
  String toString() {
    return '''
booksList: ${booksList},
favoriteBooksList: ${favoriteBooksList},
isLoading: ${isLoading},
isFavoriteLoading: ${isFavoriteLoading}
    ''';
  }
}
