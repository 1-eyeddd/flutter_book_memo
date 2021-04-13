import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';

class SignUpViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // void onChangedEmail({
  //   @required String email,
  // }) {
  //   emailController.text = email;
  // }

  // void onChangedPassword({
  //   @required String password,
  // }) {
  //   passwordController.text = password;
  // }

  //新規登録ボタンで登録
  void onPressedSignUp({
    @required BuildContext context,
    // @required String email,
    // @required String password,
  }) async {
    await UserService.signUp(
      email: emailController.text,
      password: passwordController.text,
    );
    // TODO* come
    Navigator.of(context).pop();
    // //ホーム画面に遷移
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => HomeScreen(),
    //   ),
    // );
  }
}
