import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_portfolio/models/entity/memo.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../../main.dart';

// 本ごとのメモ一覧を取得
abstract class MemoDao extends ChangeNotifier {
  static Future<List<Memo>> getBookMemos({
    @required String bookId,
  }) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .collection('bookMemos')
        .orderBy('createdAt', descending: true)
        .get();
    final memoList = querySnapshot.docs.map((document) {
      final data = document.data();

      final bookId = data['bookId'] as String ?? '';
      final memoId = data['memoId'] as String ?? '';
      final memo = data['memo'] as String ?? '';
      final createdAt = data['createdAt'] as Timestamp;

      final memos = Memo(
        bookId: bookId,
        memoId: memoId,
        memo: memo,
        createdAt: createdAt,
      );
      return memos;
    }).toList();
    return memoList;
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

//24時間後にメモの通知（テスト用に5秒）
  static Future<void> scheduleAlarm({
    @required String memo,
    @required String title,
  }) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Detroit'));
    var scheduleNotificationDateTime =
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));
    var iosChannelSpecifics = IOSNotificationDetails(
      sound: 'my_sound.aiff',
    );
    var platformChannelSpecifics = NotificationDetails(
      iOS: iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, title, memo, scheduleNotificationDateTime, platformChannelSpecifics,
        payload: 'Test Payload',
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
