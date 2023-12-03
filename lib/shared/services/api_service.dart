import 'package:ebook_reader/shared/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final ApiService instance = ApiService._init();
  ApiService._init();

  Future<List<BookModel>> fetchData() async {
    var url = Uri.parse('https://escribo.com/books.json');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
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
