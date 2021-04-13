import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/my_page/my_page_view_model.dart';
import 'package:provider/provider.dart';

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("マイページ"),
      ),
      body: ListView(
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
                    "プロフィール",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Email",
              style: TextStyle(color: Colors.deepOrange, fontSize: 15.0),
            ),
            subtitle: Text(
              "seisyuu43@gmail.com",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Divider(),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 100, left: 100, top: 20),
              child: new ElevatedButton(
                child: const Text('ログアウト'),
                onPressed: () => Provider.of<MyPageViewModel>(
                  context,
                  listen: false,
                ).onPressedLoginScreen(
                  context: context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
