import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/sign_up/sign_up_screen.dart';

class LoginViewModel extends ChangeNotifier {
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
