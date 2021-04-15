import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/books/book_dao.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';

enum AddBookTextFieldValidateType {
  imageUrl,
  title,
}

class AddBookViewModel extends ChangeNotifier {
  final textController = TextEditingController();
  final urlController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  //タップして本が追加される
  //エラーがなければ
  void onPressdAddBook({
    @required BuildContext context,
  }) {
    final user = UserService.getUserInfo().uid;
    final isValue = formkey.currentState.validate();
    {
      if (isValue) {
        BookDao.addBook(
          userId: user,
          title: textController.text,
          imageUrl: urlController.text,
        );
        textController.text = "";
        urlController.text = "";
        Navigator.of(context).pop();
      }
    }
  }

  // テキストフィールドのvalidatorテキスト
  String createValidatorText({
    @required String inputText,
    @required AddBookTextFieldValidateType type,
  }) {
    if (inputText.isEmpty) {
      switch (type) {
        case AddBookTextFieldValidateType.title:
          return '本の名前を入力してください';
        case AddBookTextFieldValidateType.imageUrl:
          return '本の写真のURLを入力してください';
      }
    }
    return null;
  }
}
