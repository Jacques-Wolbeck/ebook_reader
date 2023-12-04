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

  late final _$loadDataAsyncAction =
      AsyncAction('_BooksStore.loadData', context: context);

  @override
  Future<void> loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  @override
  String toString() {
    return '''
booksList: ${booksList},
isLoading: ${isLoading}
    ''';
  }
}
