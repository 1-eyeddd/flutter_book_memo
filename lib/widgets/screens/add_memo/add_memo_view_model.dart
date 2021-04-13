import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/memos/memo_dao.dart';
import 'package:flutter_portfolio/util/local_notification.dart';

class AddMemoViewModel extends ChangeNotifier {
  final textController = TextEditingController();

  //タップしてメモを追加
  void onPressedAddMemo({
    @required BuildContext context,
    @required String bookId,
    @required String title,
  }) async {
    await MemoDao.addMemo(
      bookId: bookId,
      memo: textController.text,
    );
    await _scheduleAlarm(
      memo: textController.text,
      title: title,
    );
    textController.text = '';
    Navigator.of(context).pop();
  }

  //追加したメモが通知されるようスケジューリング
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
