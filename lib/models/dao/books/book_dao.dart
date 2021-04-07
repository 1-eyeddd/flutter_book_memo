import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BookDao {
  // 本棚で表示する本を取得
  static Stream<QuerySnapshot> booksListener() {
    return FirebaseFirestore.instance.collection('books').snapshots();
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
      'imageUrl': imageUrl,
    });
  }

  //本を削除
  static Future<void> deleteBook({
    @required String bookId,
  }) async {
    await FirebaseFirestore.instance.collection('books').doc(bookId).delete();
  }
}
