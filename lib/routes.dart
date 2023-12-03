import 'package:ebook_reader/utils/custom/custom_page_route.dart';
import 'package:ebook_reader/views/home_view.dart';
import 'package:flutter/material.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/home_view':
      return CustomPageRoute(child: const HomeView());
    default:
      return CustomPageRoute(child: const HomeView());
  }
}
