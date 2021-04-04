import 'package:flutter/material.dart';

class Book {
  final String bookId;
  final String title;
  final String imageUrl;

  const Book({
    @required this.bookId,
    @required this.title,
    @required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }
}
