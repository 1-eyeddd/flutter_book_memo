import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/users/user_dao.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';

class SignUpViewModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //新規登録ボタンで登録
  void onPressedSignUp({
    @required BuildContext context,
  }) async {
    final userCredential = await UserService.signUp(
      email: emailController.text,
      password: passwordController.text,
    );
    await UserDao.addUser(
      userName: nameController.text,
      uid: userCredential.user.uid,
    );

    //AuthCheckに戻り、認証済みか確認する
    Navigator.of(context).pop();
  }
}
