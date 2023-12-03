import 'package:flutter/material.dart';

class BooksTabBar {
  static PreferredSize tabBar(BuildContext context) {
    return PreferredSize(
      preferredSize: _tabs(context).preferredSize,
      child: Material(
        //color: Theme.of(context).colorScheme.primaryContainer,
        child: _tabs(context),
      ),
    );
  }

  static TabBar _tabs(BuildContext context) {
    return TabBar(
      indicatorWeight: 4.0,
      indicatorColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Theme.of(context).colorScheme.primaryContainer,
      tabs: const <Widget>[
        Tooltip(
          message: "Livros",
          child: Tab(
            text: "Livros",
            icon: Icon(
              Icons.auto_stories,
              //size: 30.0,
            ),
            iconMargin: EdgeInsets.only(bottom: 2.0),
          ),
        ),
        Tooltip(
          message: "Favoritos",
          child: Tab(
            text: "Favoritos",
            icon: Icon(
              Icons.bookmarks,
              //size: 30.0,
            ),
            iconMargin: EdgeInsets.only(bottom: 2.0),
          ),
        )
      ],
    );
  }
}
