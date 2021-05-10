import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/add_book_detail/add_book_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_portfolio/models/entity/book.dart';

class SearchBookViewModel extends ChangeNotifier {
  String results = '';

  List<Book> _bookList = <Book>[];

  List<Book> get bookList => _bookList;

  //GoogleBooksAPI
  Future searchBooks(String text) async {
    final String uri = 'https://www.googleapis.com/books/v1/volumes?q=' + text;
    http.get(uri).then((res) {
      final resJson = json.decode(res.body);
      final booksMap = resJson['items'];
      _bookList = booksMap.map<Book>((map) => Book.formMap(map)).toList();
      results = res.body;
      _bookList = bookList;
    });
  }

  //本の詳細ページへ
  void onTapBookDetail({
    @required BuildContext context,
    @required Book bookDetail,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookDetailScreen(bookDetail: bookDetail),
      ),
    );
  }
}
