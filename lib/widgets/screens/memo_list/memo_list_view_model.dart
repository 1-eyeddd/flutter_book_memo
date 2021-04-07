import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/books/book_dao.dart';
import 'package:flutter_portfolio/models/dao/memos/memo_dao.dart';
import 'package:flutter_portfolio/models/entity/memo.dart';
import 'package:flutter_portfolio/widgets/screens/add_memo/add_memo_screen.dart';
import 'package:flutter_portfolio/widgets/screens/memo_detail/memo_detail_screen.dart';

class MemoListViewModel extends ChangeNotifier {
  List<Memo> _memoList = <Memo>[];

  List<Memo> get memoList => _memoList;

  //メモの状態を監視
  void memoListListener({
    @required String bookId,
  }) {
    MemoDao.memosListener(bookId: bookId).listen((snapshot) {
      final memoList = snapshot.docs.map((document) {
        final data = document.data();
        print(data);
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
      _memoList = memoList;
      notifyListeners();
    });
  }

  //本を削除
  void onPressdDeleteBook({
    @required BuildContext context,
    @required String bookId,
  }) {
    BookDao.deleteBook(
      bookId: bookId,
    );
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  //メモをタップ
  void onTapMemo({
    @required BuildContext context,
    @required Memo memo,
    @required String title,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoDetailScreen(
          bookId: memo.bookId,
          memoId: memo.memoId,
          memo: memo.memo,
          title: title,
        ),
      ),
    );
  }

  // 追加ボタンをタップ
  void onTapFloatingActionButtonMemo({
    @required BuildContext context,
    @required String bookId,
    @required String title,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMemoScreen(
          bookId: bookId,
          title: title,
        ),
        fullscreenDialog: true,
      ),
    );
  }
}
