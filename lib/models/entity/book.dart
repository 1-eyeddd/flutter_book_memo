import 'package:flutter/material.dart';

class Book {
  String id;
  String userId;
  String bookId;
  String title;
  String authors;
  String descritpion;
  String editor;
  String imageUrl;

  Book({
    this.id,
    @required this.userId,
    @required this.bookId,
    @required this.title,
    this.authors,
    this.descritpion,
    this.editor,
    @required this.imageUrl,
  });

  Book.formMap(Map<String, dynamic> map) {
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
      this.imageUrl =
          (map['volumeInfo']['imageLinks']['smallThumbnail'] == null)
              ? ''
              : map['volumeInfo']['imageLinks']['smallThumbnail'].toString();
    } catch (err) {
      this.imageUrl = '';
    }
  }
}
