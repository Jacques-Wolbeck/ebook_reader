import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:ebook_reader/shared/stores/books/books_store.dart';
import 'package:ebook_reader/views/widgets/app_progress_indicator.dart';
import 'package:ebook_reader/views/widgets/home/books_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BooksGrid extends StatefulWidget {
  final bool isFavoriteTab;
  const BooksGrid({super.key, this.isFavoriteTab = false});

  @override
  State<BooksGrid> createState() => _BooksGridState();
}

class _BooksGridState extends State<BooksGrid> {
  final _store = BooksStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _store.loadDataFromApi();
    _store.loadDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_store.isLoading || _store.isFavoriteLoading) {
        return const Center(
          child: AppProgressIndicator(),
        );
      } else {
        if (widget.isFavoriteTab) {
          if (_store.favoriteBooksList.isEmpty) {
            return const Center(child: Text('Sem livros favoritos'));
          } else {
            return _booksGridView(_store.favoriteBooksList);
          }
        } else {
          if (_store.booksList.isEmpty) {
            return const Center(child: Text('Sem livros disponíveis'));
          } else {
            return _booksGridView(_store.booksList);
          }
        }
      }
    });
  }

  Widget _booksGridView(List<BookModel> booksList) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      radius: const Radius.circular(8.0),
      child: GridView.builder(
          controller: _scrollController,
          itemCount: booksList.length,
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .65,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0),
          itemBuilder: (context, index) {
            var book = booksList[index];
            if (widget.isFavoriteTab) {
              return _booksGridTile(book);
            }
            if (_store.favoriteBooksList
                .any((element) => element.id == book.id)) {
              book.isFavorite = true;
            }
            return _booksGridTile(book);
          }),
    );
  }

  Widget _booksGridTile(BookModel book) {
    return GridTile(
      header: GridTileBar(
        title: const Text(''),
        trailing: IconButton(
            alignment: Alignment.bottomCenter,
            color: Colors.red,
            iconSize: 35,
            onPressed: () {
              setState(() {});
              if (book.isFavorite) {
                book.isFavorite = false;
                _store.deleteFavoriteBook(book);
              } else {
                book.isFavorite = true;
                _store.addFavoriteBook(book);
              }
            },
            icon: book.isFavorite
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_outline_outlined)),
      ),
      footer: GridTileBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          book.title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
        subtitle: Text(
          book.author,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      child: Stack(
        children: [
          Image.network(
            book.coverUrl,
            fit: BoxFit.fill,
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0)),
                      ),
                      builder: (context) {
                        return BooksBottomSheet(
                          book: book,
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
