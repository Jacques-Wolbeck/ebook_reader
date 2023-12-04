import 'package:dio/dio.dart';
import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:flutter/material.dart';

class ApiService {
  static final ApiService instance = ApiService._init();
  ApiService._init();
  final _dio = Dio();

  Future<List<BookModel>> fetchData() async {
    try {
      final response = await _dio.get('https://escribo.com/books.json');
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return List<BookModel>.from(jsonResponse
            .map((value) => BookModel.fromJson(value as Map<String, dynamic>)));
      }
      return [];
    } catch (error) {
      debugPrint('Error accessing Api: $error');
      throw Exception(error);
    }
  }
}
