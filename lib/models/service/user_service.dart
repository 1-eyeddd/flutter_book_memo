import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class UserService {
  //サインアップ
  static Future<UserCredential> signUp({
    @required String email,
    @required String password,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  //サインイン
  static Future<void> signIn({
    @required String email,
    @required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //サインアウト
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //Authからユーザー情報を取得
  static User getUserInfo() {
    return FirebaseAuth.instance.currentUser;
  }

  //ログインチェック
  static Stream<User> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
