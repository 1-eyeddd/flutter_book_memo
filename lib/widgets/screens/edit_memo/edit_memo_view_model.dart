import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/memos/memo_dao.dart';

class EditMemoViewModel extends ChangeNotifier {
  final textController = TextEditingController();

  // 更新ボタンをタップ
  void onPressdEditMemo({
    @required BuildContext context,
    @required String bookId,
    @required String memoId,
  }) {
    MemoDao.editMemo(
      memoId: memoId,
      bookId: bookId,
      newMemo: textController.text,
    );
    //メモ一覧に戻るため
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
