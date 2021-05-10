import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/book_detail/book_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_portfolio/models/entity/book.dart';

class SearchBookViewModel extends ChangeNotifier {
  String results = '';

  List<Book> _bookList = List<Book>();

  List<Book> get bookList => _bookList;

  Future searchBooks(String searchText) async {
    final String uri =
        'https://www.googleapis.com/books/v1/volumes?q=' + searchText;
    http.get(uri).then((res) {
      final resJson = json.decode(res.body);
      final booksMap = resJson['items'];
      _bookList = booksMap.map<Book>((map) => Book.formMap(map)).toList();
      results = res.body;
      _bookList = bookList;
    });
  }

  void onTapBookDetail({
    @required BuildContext context,
    @required Book bookDetail,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailScreen(bookDetail: bookDetail),
      ),
    );
  }
}
