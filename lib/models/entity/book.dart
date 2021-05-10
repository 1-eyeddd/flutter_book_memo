import 'package:flutter/material.dart';

class Book {
  final String userId;
  final String bookId;
  final String title;
  final String imageUrl;

  const Book({
    @required this.userId,
    @required this.bookId,
    @required this.title,
    @required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      userId: json['userId'],
      bookId: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }
}

class Search {
  String id;
  String title;
  String authors;
  String descritpion;
  String editor;
  String urlImage;

  Search(this.id, this.title, this.authors, this.descritpion, this.editor,
      this.urlImage);

  Search.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['volumeInfo']['title'];
    this.authors = (map['volumeInfo']['authors'] == null)
        ? ''
        : map['volumeInfo']['authors'].toString();
    this.descritpion = (map['volumeInfo']['description'] == null)
        ? ''
        : map['volumeInfo']['description'].toString();
    this.editor = (map['volumeInfo']['publisher'] == null)
        ? ''
        : map['volumeInfo']['publisher'].toString();
    try {
      this.urlImage =
          (map['volumeInfo']['imageLinks']['smallThumbnail'] == null)
              ? ''
              : map['volumeInfo']['imageLinks']['smallThumbnail'].toString();
    } catch (err) {
      this.urlImage = '';
    }
  }
}
