import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/add_book/add_book_view_model.dart';
import 'package:provider/provider.dart';

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
    final _textController = TextEditingController();
    final _urlController = TextEditingController();
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
                      validator: (text) =>
                          Provider.of<AddBookViewModel>(context, listen: false)
                              .createValidatorText(
                        inputText: text,
                        type: AddBookTextFieldValidateType.title,
                      ),
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
                      validator: (text) =>
                          Provider.of<AddBookViewModel>(context, listen: false)
                              .createValidatorText(
                        inputText: text,
                        type: AddBookTextFieldValidateType.imageUrl,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        final isValue = _formkey.currentState.validate();
                        if (isValue) {
                          Provider.of<AddBookViewModel>(context, listen: false)
                              .onPressdAddBook(
                            context: context,
                            title: _textController.text,
                            imageUrl: _urlController.text,
                          );
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
