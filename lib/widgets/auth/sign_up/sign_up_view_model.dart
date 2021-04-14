import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/users/user_dao.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';
import 'package:tuple/tuple.dart';

enum SignUpTextFieldValidateType {
  email,
  password,
}

class SignUpViewModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _signUpErrorString = '';

  String get signUpErrorString => _signUpErrorString;

  //新規登録ボタンで登録
  void onPressedSignUp({
    @required BuildContext context,
  }) async {
    final tuple = await UserService.signUp(
      email: emailController.text,
      password: passwordController.text,
    );
    final userCredential = tuple.item1;
    final signUpErrorType = tuple.item2;
    switch (signUpErrorType) {
      case SignUpErrorType.alreadyEmail:
        _signUpErrorString = 'このメールアドレスは既に登録されています。';
        notifyListeners();
        return;
      case SignUpErrorType.none:
        _signUpErrorString = '';
        emailController.text = '';
        passwordController.text = '';
        await UserDao.addUser(
          userName: nameController.text,
          uid: userCredential.user.uid,
        );
        notifyListeners();
        //AuthCheckに戻り、認証済みか確認する
        Navigator.of(context).pop();
        return;
    }
  }

  // テキストフィールドのvalidatorテキスト
  String createValidatorText({
    @required String inputText,
    @required SignUpTextFieldValidateType type,
  }) {
    if (type == SignUpTextFieldValidateType.email) {
      if (inputText.isEmpty) {
        return 'メールアドレスを入力してください';
      } else if (!EmailValidator.validate(inputText)) {
        return "正しいメールアドレスを入力してください";
      }
      return null;
    } else {
      if (inputText.isEmpty) {
        return 'パスワードを入力してください';
      } else if (inputText.length < 6) {
        return 'パスワードは６文字以上で入力して下さい';
      }
      return null;
    }
  }
}
