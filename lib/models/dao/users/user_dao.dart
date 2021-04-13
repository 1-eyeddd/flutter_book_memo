import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class UserDao {
  //ユーザーをfirestoreに追加
  static Future<void> addUser({
    @required String userName,
    @required String uid,
  }) async {
    final documentReference =
        FirebaseFirestore.instance.collection('users').doc(uid);
    await documentReference.set(
      {
        'userId': uid,
        'userName': userName,
      },
    );
  }

  //ユーザー情報をfirestoreから取得
  static Stream<DocumentSnapshot> userListener({
    @required String userId,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();
  }
}
