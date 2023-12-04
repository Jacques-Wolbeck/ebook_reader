import 'package:ebook_reader/views/widgets/app_title.dart';
import 'package:ebook_reader/views/widgets/home/books_grid.dart';
import 'package:ebook_reader/views/widgets/home/books_tab_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          centerTitle: true,
          title: const AppTitle(),
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PreferredSize(
                  preferredSize: const Size.fromHeight(40.0),
                  child: BooksTabBar.tabBar(context),
                ),
              ),
              Expanded(
                child: _tabBarView(context),
              )
            ],
          )),
    );
  }

  Widget _tabBarView(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Estante de Livros',
                style: Theme.of(context).textTheme.titleLarge!.merge(TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
              ),
            ),
            const Expanded(child: BooksGrid())
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Livros Favoritos',
                style: Theme.of(context).textTheme.titleLarge!.merge(TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
