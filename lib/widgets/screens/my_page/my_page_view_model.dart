import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/login/login_screen.dart';

class MyPageViewModel extends ChangeNotifier {
  //ログイン画面へ
  void onPressedLoginScreen({
    @required BuildContext context,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
