import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPageViewModel extends ChangeNotifier {
  //サインアウトする
  Future<void> onPressedSignOut({
    @required BuildContext context,
  }) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  //ユーザー情報取得する
  // static void currentUserInfoListener() {
  //   var user = firebase.auth().currentUser;
  //   var String email;

  //   if (user != null) {
  //     email = user.email;
  //   }
  // }
}
