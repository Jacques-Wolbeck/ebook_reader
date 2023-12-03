import 'package:ebook_reader/utils/arguments/views_arguments.dart';
import 'package:ebook_reader/utils/custom/custom_page_route.dart';
import 'package:ebook_reader/views/book_view.dart';
import 'package:ebook_reader/views/home_view.dart';
import 'package:flutter/material.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/book_view':
      final args = settings.arguments as BookViewArguments;
      return CustomPageRoute(
          child: BookView(
        book: args.book,
      ));
    case '/home_view':
      return CustomPageRoute(child: const HomeView());
    default:
      return CustomPageRoute(child: const HomeView());
  }
}
