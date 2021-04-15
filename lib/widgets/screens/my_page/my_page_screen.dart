import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/my_page/my_page_view_model.dart';
import 'package:provider/provider.dart';

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MyPageViewModel>(context, listen: false)
        .currentUserInfoListener();
    Provider.of<MyPageViewModel>(context, listen: false).userNameListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("マイページ"),
      ),
      body: Consumer<MyPageViewModel>(
        builder: (BuildContext context, MyPageViewModel value, Widget child) {
          final email = value.email;
          final users = value.users;
          return users == null
              ? Container()
              : ListView(
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_circle_rounded,
                            size: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              users.userName ?? '',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "email",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      subtitle: Text(
                        email,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 100,
                          left: 100,
                          top: 20,
                        ),
                        child: new ElevatedButton(
                          child: const Text('ログアウト'),
                          onPressed: () => Provider.of<MyPageViewModel>(
                            context,
                            listen: false,
                          ).onPressedSignOut(
                            context: context,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
