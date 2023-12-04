import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:ebook_reader/shared/stores/books/books_store.dart';
import 'package:ebook_reader/views/widgets/app_progress_indicator.dart';
import 'package:ebook_reader/views/widgets/home/books_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BooksGrid extends StatefulWidget {
  const BooksGrid({super.key});

  @override
  State<BooksGrid> createState() => _BooksGridState();
}

class _BooksGridState extends State<BooksGrid> {
  final _store = BooksStore();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _store.loadData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Observer(builder: (_) {
      if (_store.isLoading) {
        return const Center(
          child: AppProgressIndicator(),
        );
      } else {
        if (_store.booksList.isEmpty) {
          return const Center(child: Text('Sem livros disponíveis'));
        } else {
          return _booksGridView(_store.booksList, screenSize);
        }
      }
    });
  }

  Widget _booksGridView(List<BookModel> booksList, Size screenSize) {
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
            return GridTile(
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
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
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
          }),
    );
  }
}
