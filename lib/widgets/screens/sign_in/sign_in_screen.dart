import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/sign_in/sign_in_view_model.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Center(
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
          Container(
            child: Image.asset('images/login_page.png'),
            height: 250,
          ),
          Form(
            key: Provider.of<SignInViewModel>(context, listen: false)
                .emailFormkey,
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
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Form(
            key: Provider.of<SignInViewModel>(context, listen: false)
                .passwordFormkey,
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
                child: Center(
                  child: Text(value.signInErrorString),
                ),
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
                minWidth: 310,
                child: Text(
                  "ログイン",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                onPressed: () => Provider.of<SignInViewModel>(
                  context,
                  listen: false,
                ).onPressedSignIn(
                  context: context,
                ),
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
