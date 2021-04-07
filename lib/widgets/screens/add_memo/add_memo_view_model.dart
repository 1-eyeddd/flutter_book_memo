import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/memos/memo_dao.dart';
import 'package:flutter_portfolio/util/local_notification.dart';

class AddMemoViewModel extends ChangeNotifier {
  //追加ボタンをタップ
  void onPressedAddMemo({
    @required BuildContext context,
    @required String bookId,
    @required String memo,
    @required String title,
  }) async {
    await MemoDao.addMemo(
      bookId: bookId,
      memo: memo,
    );
    await _scheduleAlarm(
      memo: memo,
      title: title,
    );
    Navigator.of(context).pop();
  }

  Future<void> _scheduleAlarm({
    @required String memo,
    @required String title,
  }) {
    return LocalNotification.scheduleAlarm(
      memo: memo,
      title: title,
    );
  }
}
