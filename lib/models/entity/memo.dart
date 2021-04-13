import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Memo {
  final String bookId;
  final String memoId;
  final String memo;
  final String userId;
  final Timestamp createdAt;

  const Memo({
    @required this.bookId,
    @required this.memoId,
    @required this.memo,
    @required this.userId,
    @required this.createdAt,
  });
}
