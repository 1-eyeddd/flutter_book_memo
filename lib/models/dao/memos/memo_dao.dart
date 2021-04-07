import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/entity/memo.dart';

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

  //メモを表示
  static Future<Memo> getMemo({
    @required String bookId,
    @required String memoId,
  }) async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .collection('bookMemos')
        .doc(memoId)
        .get();

    final data = documentSnapshot.data();

    final bookIdData = data['bookId'] as String ?? '';
    final memoIdData = data['memoId'] as String ?? '';
    final memoData = data['memo'] as String ?? '';
    final createdAtData = data['createdAt'] as Timestamp;

    final memos = Memo(
      bookId: bookIdData,
      memoId: memoIdData,
      memo: memoData,
      createdAt: createdAtData,
    );
    return memos;
  }

  //メモを追加
  static Future<void> addMemo({
    @required String bookId,
    @required String memo,
  }) async {
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
