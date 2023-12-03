import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:ebook_reader/utils/arguments/views_arguments.dart';
import 'package:ebook_reader/views/widgets/app_progress_indicator.dart';
import 'package:ebook_reader/views/widgets/buttons.dart/default_button.dart';
import 'package:flutter/material.dart';

class BooksBottomSheet extends StatefulWidget {
  final BookModel book;
  const BooksBottomSheet({super.key, required this.book});

  @override
  State<BooksBottomSheet> createState() => _BooksBottomSheetState();
}

class _BooksBottomSheetState extends State<BooksBottomSheet> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultButton(
                  title: 'Ler',
                  icon: Icons.book_outlined,
                  onPressed: () => Navigator.pushNamed(context, '/book_view',
                      arguments: BookViewArguments(book: widget.book))),
              DefaultButton(
                  title: 'Favoritos',
                  icon: Icons.bookmark_add_outlined,
                  onPressed: () => null),
            ],
          )
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
}
