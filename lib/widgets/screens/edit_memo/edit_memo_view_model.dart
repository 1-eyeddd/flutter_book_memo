import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/memos/memo_dao.dart';
import 'package:flutter_portfolio/util/local_notification.dart';

class EditMemoViewModel extends ChangeNotifier {
  final textController = TextEditingController();

  // 更新ボタンをタップ
  void onPressdEditMemo({
    @required BuildContext context,
    @required String bookId,
    @required String memoId,
    @required String title,
  }) async {
    await MemoDao.editMemo(
      memoId: memoId,
      bookId: bookId,
      newMemo: textController.text,
    );
    await LocalNotification.scheduleAlarm(
      memo: textController.text,
      title: title,
    );
    //メモ一覧に戻るため
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
