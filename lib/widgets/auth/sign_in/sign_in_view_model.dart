import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';
import 'package:flutter_portfolio/widgets/auth/sign_up/sign_up_screen.dart';

enum SignInTextFieldValidateType {
  email,
  password,
}

class SignInViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _signInErrorString = '';

  String get signInErrorString => _signInErrorString;

  final formKey = new GlobalKey<FormState>();

  //サインイン
  void onPressedSignIn({
    @required BuildContext context,
  }) async {
    final signInErrorType = await UserService.signIn(
      email: emailController.text,
      password: passwordController.text,
    );
    switch (signInErrorType) {
      case SignInErrorType.unFoundemail:
        _signInErrorString = 'このメールアドレスは登録されていません。';
        notifyListeners();
        return;
      case SignInErrorType.invalidPassword:
        _signInErrorString = 'パスワードが間違っています。';
        notifyListeners();
        return;
      case SignInErrorType.none:
        _signInErrorString = '';
        emailController.text = '';
        passwordController.text = '';
        notifyListeners();
        return;
    }
  }

  //新規登録画面に遷移
  void onPressedSignUpScreen({
    @required BuildContext context,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  // テキストフィールドのvalidatorテキスト
  String createValidatorText({
    @required String inputText,
    @required SignInTextFieldValidateType type,
  }) {
    if (type == SignInTextFieldValidateType.email) {
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
