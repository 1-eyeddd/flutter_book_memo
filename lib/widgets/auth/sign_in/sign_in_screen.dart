import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/auth/sign_in/sign_in_view_model.dart';
import 'package:flutter_portfolio/widgets/auth/sign_up/sign_up_view_model.dart';

import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailFormkey = GlobalKey<FormState>();
  final _passwordFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "Welcome!",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Image.asset('images/login_page.png'),
          ),
          Form(
            key: _emailFormkey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  controller:
                      Provider.of<SignInViewModel>(context).emailController,
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.email,
                        color: Colors.lightBlue,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  ),
                  validator: (text) =>
                      Provider.of<SignInViewModel>(context, listen: false)
                          .createValidatorText(
                    inputText: text,
                    type: SignInTextFieldValidateType.email,
                  ),
                  onSaved: (value) {
                    Provider.of<SignInViewModel>(context).emailController.text =
                        value;
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _passwordFormkey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  controller:
                      Provider.of<SignInViewModel>(context).passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Colors.lightBlue,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  ),
                  obscureText: true,
                  validator: (text) =>
                      Provider.of<SignInViewModel>(context, listen: false)
                          .createValidatorText(
                    inputText: text,
                    type: SignInTextFieldValidateType.password,
                  ),
                  onSaved: (value) {
                    Provider.of<SignInViewModel>(context)
                        .passwordController
                        .text = value;
                  },
                ),
              ),
            ),
          ),
          Consumer<SignInViewModel>(builder:
              (BuildContext context, SignInViewModel value, Widget child) {
            if (value.signInErrorString.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Text(value.signInErrorString),
              );
            }
            return SizedBox(
              height: 25,
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.lightBlue),
              child: FlatButton(
                child: Text(
                  "ログイン",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                onPressed: () {
                  final isEmailValue = _emailFormkey.currentState.validate();
                  final isPasswordValue =
                      _passwordFormkey.currentState.validate();
                  if (isEmailValue && isPasswordValue) {
                    Provider.of<SignInViewModel>(
                      context,
                      listen: false,
                    ).onPressedSignIn(
                      context: context,
                    );
                  } else {
                    setState(
                      () {},
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "アカウントをお持ちでなければ ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
              TextButton(
                onPressed: () => Provider.of<SignInViewModel>(
                  context,
                  listen: false,
                ).onPressedSignUpScreen(
                  context: context,
                ),
                child: Text(
                  "新規登録",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
