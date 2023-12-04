import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseController {
  static final DatabaseController dbInstance = DatabaseController._init();
  DatabaseController._init();

  Future<Database> get database async {
    return await initDb();
  }

  Future<Database> initDb() async {
    try {
      String path = join(await getDatabasesPath(), 'epub_reader.db');
      return await openDatabase(path, onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE favorites (id INTEGER PRIMARY KEY, title TEXT, author TEXT, cover_url TEXT, download_url TEXT, is_favorite INTEGER)');
      }, version: 1);
    } catch (error) {
      debugPrint('Error create table: $error');
      throw Exception(error);
    }
  }

  Future<void> insert(BookModel book) async {
    try {
      final db = await database;
      await db.insert('favorites', book.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (error) {
      debugPrint('Error inserting: $error');
      throw Exception(error);
    }
  }

  Future<void> delete(BookModel book) async {
    try {
      final db = await database;
      await db.delete(
        'favorites',
        where: 'id = ?',
        whereArgs: [book.id],
      );
    } catch (error) {
      debugPrint('Error deleting: $error');
      throw Exception(error);
    }
  }

  Future<List<BookModel>> getAllfavorites() async {
    try {
      final db = await database;
      final response = await db.query('favorites');
      return response.isEmpty
          ? []
          : List<BookModel>.from(
              response.map((value) => BookModel.fromJson(value)));
    } catch (error) {
      debugPrint('Error loading: $error');
      throw Exception(error);
    }
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
