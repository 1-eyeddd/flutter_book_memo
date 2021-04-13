import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_portfolio/widgets/auth/sign_in/sign_in_screen.dart';
import 'package:flutter_portfolio/widgets/screens/home/home_screen.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.hasData) {
          // 認証済み
          return HomeScreen();
        } else {
          // ログイン画面へ変更
          return SignInScreen();
        }
      },
    );
  }
}
