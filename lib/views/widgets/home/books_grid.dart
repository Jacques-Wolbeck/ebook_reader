import 'dart:async';

import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:ebook_reader/shared/services/api_service.dart';
import 'package:ebook_reader/views/widgets/app_progress_indicator.dart';
import 'package:ebook_reader/views/widgets/home/books_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BooksGrid extends StatefulWidget {
  const BooksGrid({super.key});

  @override
  State<BooksGrid> createState() => _BooksGridState();
}

class _BooksGridState extends State<BooksGrid> {
  final _scrollController = ScrollController();
  final _streamController = StreamController<List<dynamic>>();
  late final List<dynamic> dataList;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  _loadData() async {
    dataList = await ApiService.instance.fetchData();
    _streamController.add(dataList);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os dados'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: AppProgressIndicator(),
            );
          } else {
            final booksList = snapshot.data as List<BookModel>;
            if (booksList.isEmpty) {
              return const Center(child: Text('Sem livros disponíveis'));
            } else {
              return _booksGridView(booksList, screenSize);
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
