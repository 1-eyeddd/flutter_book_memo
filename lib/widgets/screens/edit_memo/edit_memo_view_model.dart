import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/memos/memo_dao.dart';

class EditMemoViewModel extends ChangeNotifier {
  // 更新ボタンをタップ
  void onPressdEditMemo({
    @required BuildContext context,
    @required String bookId,
    @required String memoId,
    @required String newMemo,
  }) {
    MemoDao.editMemo(
      memoId: memoId,
      bookId: bookId,
      newMemo: newMemo,
    );
    //メモ一覧に戻るため
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
