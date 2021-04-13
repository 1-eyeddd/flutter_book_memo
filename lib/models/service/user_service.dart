import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class UserService {
  //サインアップ
  static Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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
}
