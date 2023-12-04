import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:ebook_reader/shared/stores/vocsy_epub/vocsy_epub_store.dart';
import 'package:ebook_reader/views/widgets/app_progress_indicator.dart';
import 'package:ebook_reader/views/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class BooksBottomSheet extends StatefulWidget {
  final BookModel book;
  const BooksBottomSheet({super.key, required this.book});

  @override
  State<BooksBottomSheet> createState() => _BooksBottomSheetState();
}

class _BooksBottomSheetState extends State<BooksBottomSheet> {
  final _store = VocsyEpubStore();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Divider(
                thickness: 4.0,
                indent: MediaQuery.of(context).size.width * 0.4,
                endIndent: MediaQuery.of(context).size.width * 0.4,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [_bookInformation(context)],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bookInformation(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(flex: 3, child: _getCoverImage()),
              const SizedBox(width: 16.0),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book.title.toUpperCase(),
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .merge(const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person_outline),
                        const SizedBox(width: 8.0),
                        Expanded(child: Text(widget.book.author)),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              )
            ],
          ),
          const Divider(),
          Observer(builder: (_) {
            return DefaultButton(
                title: _store.isLoading ? 'Carregando...' : 'Ler',
                leading: _store.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AppProgressIndicator(),
                      )
                    : const Icon(Icons.library_books_outlined),
                onPressed: () {
                  if (_store.filePath == "") {
                    _store.download(widget.book).then((_) => _accessEpub());
                  } else {
                    _accessEpub();
                  }
                });
          })
        ],
      ),
    );
  }

  Widget _getCoverImage() {
    return Image.network(
      widget.book.coverUrl,
      height: 220,
      width: 150,
      fit: BoxFit.fill,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const SizedBox(
          height: 220,
          width: 150,
          child: Center(child: AppProgressIndicator()),
        );
      },
      errorBuilder: ((context, error, stackTrace) {
        return const Icon(Icons.error);
      }),
    );
  }

  void _accessEpub() {
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "book",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: false,
    );

    VocsyEpub.open(
      _store.filePath,
    );
  }
}
