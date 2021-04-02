import 'package:flutter/material.dart';

import '../../models/dao/books/book_dao.dart';

class AddBookScreen extends StatefulWidget {
  AddBookScreen({Key key}) : super(key: key);

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formkey = GlobalKey<FormState>();
  var autoValidate = false;

  @override
  Widget build(BuildContext context) {
    var _textController = TextEditingController();
    var _urlController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade300,
        title: Text('本を追加'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: '本のタイトル',
                        border: OutlineInputBorder(),
                        filled: true,
                        errorStyle: TextStyle(fontSize: 15),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '本の名前を入力してください';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    child: TextFormField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        hintText: '本の写真のURL',
                        border: OutlineInputBorder(),
                        filled: true,
                        errorStyle: TextStyle(fontSize: 15),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '本の写真のURLを入力してください';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        final isValue = _formkey.currentState.validate();
                        if (isValue) {
                          await BookDao.addBook(
                              title: _textController.text,
                              imageUrl: _urlController.text);
                          Navigator.pop(context);
                        } else {
                          setState(
                            () {
                              autoValidate = true;
                            },
                          );
                        }
                      },
                      child: Text(
                        '追加する',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
