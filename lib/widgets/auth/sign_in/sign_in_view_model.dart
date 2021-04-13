import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';
import 'package:flutter_portfolio/widgets/auth/sign_up/sign_up_screen.dart';

class SignInViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //サインイン
  void onPressedSignIn({
    @required BuildContext context,
  }) async {
    await UserService.signIn(
      email: emailController.text,
      password: passwordController.text,
    );
    emailController.text = '';
    passwordController.text = '';
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
}
