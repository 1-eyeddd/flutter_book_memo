import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';

// 本ごとのメモ一覧を取得
abstract class MemoDao {
  static Stream<QuerySnapshot> memosListener({
    @required String bookId,
  }) {
    return FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .collection('bookMemos')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

//メモの取得
  static Stream<DocumentSnapshot> memoListener({
    @required String bookId,
    @required String memoId,
  }) {
    return FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .collection('bookMemos')
        .doc(memoId)
        .snapshots();
  }

  //メモを追加
  static Future<void> addMemo({
    @required String bookId,
    @required String memo,
  }) async {
    final user = UserService.getUserInfo().uid;
    final documentReference = FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .collection('bookMemos')
        .doc();
    await documentReference.set({
      'memo': memo,
      'createdAt': Timestamp.now(),
      'bookId': bookId,
      'memoId': documentReference.id,
      'userId': user,
    });
  }

  //メモを削除
  static Future<void> deleteMemo({
    @required String memoId,
    @required String bookId,
  }) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .collection('bookMemos')
        .doc(memoId)
        .delete();
  }

  //メモを変更
  static Future<void> editMemo({
    @required String memoId,
    @required String bookId,
    @required String newMemo,
  }) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .collection('bookMemos')
        .doc(memoId)
        .update({'memo': newMemo, 'createdAt': Timestamp.now()});
  }
}
