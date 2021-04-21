import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/sign_up/sign_up_view_model.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);
  @override
  _SignUpScreenScreenState createState() => _SignUpScreenScreenState();
}

class _SignUpScreenScreenState extends State<SignUpScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void didPop() {
    Provider.of<SignUpViewModel>(context, listen: false).resetTextField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.blueGrey,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              "アカウントを作成する",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24.0,
              ),
            ),
          ),
          Container(
            child: Image.asset(
              'images/sign_up.png',
              height: 200,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                controller:
                    Provider.of<SignUpViewModel>(context).nameController,
                decoration: InputDecoration(
                  hintText: "プロフィール名",
                  prefixIcon: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.lightBlue,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Form(
            key: Provider.of<SignUpViewModel>(context, listen: false)
                .emailFormkey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  controller:
                      Provider.of<SignUpViewModel>(context).emailController,
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
                      Provider.of<SignUpViewModel>(context, listen: false)
                          .createValidatorText(
                    inputText: text,
                    type: SignUpTextFieldValidateType.email,
                  ),
                  onSaved: (value) {
                    Provider.of<SignUpViewModel>(context).emailController.text =
                        value;
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Form(
            key: Provider.of<SignUpViewModel>(context, listen: false)
                .passwordFormkey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  controller:
                      Provider.of<SignUpViewModel>(context).passwordController,
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
                      Provider.of<SignUpViewModel>(context, listen: false)
                          .createValidatorText(
                    inputText: text,
                    type: SignUpTextFieldValidateType.password,
                  ),
                  onSaved: (value) {
                    Provider.of<SignUpViewModel>(context)
                        .passwordController
                        .text = value;
                  },
                ),
              ),
            ),
          ),
          Consumer<SignUpViewModel>(
            builder:
                (BuildContext context, SignUpViewModel value, Widget child) {
              if (value.signUpErrorString.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Center(
                    child: Text(value.signUpErrorString),
                  ),
                );
              }
              return SizedBox(height: 25);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.lightBlue,
              ),
              child: FlatButton(
                minWidth: 310,
                child: Text(
                  "新規登録",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                onPressed: () {
                  Provider.of<SignUpViewModel>(
                    context,
                    listen: false,
                  ).onPressedSignUp(
                    context: context,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
