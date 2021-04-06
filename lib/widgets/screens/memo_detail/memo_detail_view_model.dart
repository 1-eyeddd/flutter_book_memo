import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/memos/memo_dao.dart';
import 'package:flutter_portfolio/models/entity/memo.dart';
import 'package:flutter_portfolio/widgets/screens/edit_memo/edit_memo_screen.dart';

class MemoDetailViewModel extends ChangeNotifier {
  Memo _memo;

  Memo get memo => _memo;

  //メモ詳細を取得
  void memosListenr({
    @required String bookId,
    @required String memoId,
  }) {
    MemoDao.memoListener(
      bookId: bookId,
      memoId: memoId,
    ).listen(
      (documentSnapshot) {
        final data = documentSnapshot.data();

        final bookIdData = data['bookId'] as String ?? '';
        final memoIdData = data['memoId'] as String ?? '';
        final memoData = data['memo'] as String ?? '';
        final createdAtData = data['createdAt'] as Timestamp;

        final memo = Memo(
          bookId: bookIdData,
          memoId: memoIdData,
          memo: memoData,
          createdAt: createdAtData,
        );
        _memo = memo;
        notifyListeners();
      },
    );
  }

  //編集画面へ
  void onTapEditMemoScreen({
    @required BuildContext context,
    @required String bookId,
    @required String memoId,
    @required String title,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMemoScreen(
          bookId: bookId,
          memo: _memo.memo,
          memoId: memoId,
          title: title,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  //削除
  void onPressDeleteMemo({
    @required BuildContext context,
  }) {
    MemoDao.deleteMemo(
      memoId: _memo.memoId,
      bookId: _memo.bookId,
    );
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
