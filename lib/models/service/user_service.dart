import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

enum SignInErrorType { unFoundemail, invalidPassword, none }
enum SignUpErrorType { alreadyEmail, none }

abstract class UserService {
  //サインアップ
  static Future<Tuple2<UserCredential, SignUpErrorType>> signUp({
    @required String email,
    @required String password,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    SignUpErrorType signUpErrorType;
    UserCredential userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      signUpErrorType = SignUpErrorType.none;
    } catch (error) {
      if (error.toString().contains(
          'The email address is already in use by another account.')) {
        signUpErrorType = SignUpErrorType.alreadyEmail;
      }
    }
    return Tuple2<UserCredential, SignUpErrorType>(
        userCredential, signUpErrorType);
  }

  //サインイン
  static Future<SignInErrorType> signIn({
    @required String email,
    @required String password,
  }) async {
    SignInErrorType signInErrorType;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      signInErrorType = SignInErrorType.none;
    } catch (error) {
      print(error);

      if (error.toString().contains(
          'There is no user record corresponding to this identifier. The user may have been deleted.')) {
        print(error);
        signInErrorType = SignInErrorType.unFoundemail;
      }
      if (error.toString().contains(
          'The password is invalid or the user does not have a password.')) {
        print(error);
        signInErrorType = SignInErrorType.invalidPassword;
      }
    }
    return signInErrorType;
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
