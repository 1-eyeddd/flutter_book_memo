import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_portfolio/models/entity/book.dart';

// 本棚で表示する本を取得
abstract class BookDao {
  static Future<List<Book>> getAllBooks() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection("books").get();
    final books = querySnapshot.docs.map((document) {
      final data = document.data();
      print(data);
      final title = data['title'] as String ?? '';
      final bookId = data['bookId'] as String ?? '';
      final imageUrl = data['imageUrl'] as String ?? '';
      final book = Book(
        bookId: bookId,
        title: title,
        imageUrl: imageUrl,
      );
      return book;
    }).toList();
    return books;
  }

  //本を追加
  static Future<void> addBook({
    @required String title,
    @required String imageUrl,
  }) async {
    final documentReference =
        FirebaseFirestore.instance.collection('books').doc();
    await documentReference.set({
      'bookId': documentReference.id,
      'title': title,
      'imageurl': imageUrl,
    });
  }

  //本を削除
  static Future<void> deleteBook({
    @required String bookId,
  }) async {
    await FirebaseFirestore.instance.collection('books').doc(bookId).delete();
  }
}
