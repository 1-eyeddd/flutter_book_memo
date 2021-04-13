import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/users/user_dao.dart';
import 'package:flutter_portfolio/models/entity/users.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';

class MyPageViewModel extends ChangeNotifier {
  String _email = '';

  String get email => _email;

  //サインアウトする
  Future<void> onPressedSignOut({
    @required BuildContext context,
  }) async {
    await FirebaseAuth.instance.signOut();
    //ログイン画面に戻るためpop
    Navigator.of(context).pop();
  }

  // ユーザー情報をauthから取得する
  void currentUserInfoListener() {
    var user = UserService.getUserInfo();
    if (user != null) {
      _email = user.email;
    }
  }

  Users _users;

  Users get users => _users;

  //ユーザー情報をfirestoreから取得
  void userNameListener() {
    final user = UserService.getUserInfo().uid;
    UserDao.userListener(userId: user).listen(
      (documentSnapshot) {
        final data = documentSnapshot.data();
        final userNameData = data['userName'] as String ?? '';
        final users = Users(
          userId: user,
          userName: userNameData,
        );
        _users = users;
      },
    );
  }
}
