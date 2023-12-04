import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:ebook_reader/shared/stores/books/books_store.dart';
import 'package:ebook_reader/views/widgets/app_progress_indicator.dart';
import 'package:ebook_reader/views/widgets/home/books_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BooksGrid extends StatefulWidget {
  final TextEditingController searchController;
  final bool isFavoriteTab;
  const BooksGrid(
      {super.key, required this.searchController, this.isFavoriteTab = false});

  @override
  State<BooksGrid> createState() => _BooksGridState();
}

class _BooksGridState extends State<BooksGrid> {
  final _store = BooksStore();
  final _scrollController = ScrollController();
  List<BookModel> dataList = [];

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
        dataList = _store.booksList;
        if (widget.isFavoriteTab) {
          dataList = _store.favoriteBooksList;
        }
        if (widget.searchController.text.isNotEmpty) {
          dataList = _searchData(dataList);
        }
        if (dataList.isEmpty) {
          return const Center(child: Text('Sem livros disponíveis'));
        }
        return _booksGridView(dataList);
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
            color: Colors.red,
            iconSize: 35,
            onPressed: () async {
              if (book.isFavorite) {
                book.isFavorite = false;
                await _store.deleteFavoriteBook(book);
              } else {
                book.isFavorite = true;
                await _store.addFavoriteBook(book);
              }
              setState(() {});
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
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: AppProgressIndicator());
            },
            errorBuilder: ((context, error, stackTrace) {
              return const Center(child: Icon(Icons.error));
            }),
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

  List<BookModel> _searchData(List<BookModel> booksList) {
    final List<BookModel> searchResult = [];
    for (var book in booksList) {
      if (book.title
          .toLowerCase()
          .contains(widget.searchController.text.toLowerCase())) {
        searchResult.add(book);
      }
    }
    return searchResult;
  }
}
