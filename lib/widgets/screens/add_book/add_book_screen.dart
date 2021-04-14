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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本を追加'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15.0,
                      left: 15.0,
                    ),
                    child: Container(
                      height: 100,
                      child: TextFormField(
                        controller: Provider.of<AddBookViewModel>(context)
                            .textController,
                        decoration: InputDecoration(
                          hintText: '本のタイトル',
                          border: OutlineInputBorder(),
                          filled: true,
                          errorStyle: TextStyle(fontSize: 15),
                        ),
                        validator: (text) => Provider.of<AddBookViewModel>(
                                context,
                                listen: false)
                            .createValidatorText(
                          inputText: text,
                          type: AddBookTextFieldValidateType.title,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15.0,
                      left: 15.0,
                    ),
                    child: Container(
                      height: 100,
                      child: TextFormField(
                        controller: Provider.of<AddBookViewModel>(context)
                            .urlController,
                        decoration: InputDecoration(
                          hintText: '本の写真のURL',
                          border: OutlineInputBorder(),
                          filled: true,
                          errorStyle: TextStyle(fontSize: 15),
                        ),
                        validator: (text) => Provider.of<AddBookViewModel>(
                                context,
                                listen: false)
                            .createValidatorText(
                          inputText: text,
                          type: AddBookTextFieldValidateType.imageUrl,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      // TODO: ViewModelにかく
                      onPressed: () {
                        final isValue = _formkey.currentState.validate();
                        if (isValue) {
                          Provider.of<AddBookViewModel>(context, listen: false)
                              .onPressdAddBook(
                            context: context,
                          );
                        } else {
                          // TODO 使わない
                          setState(
                            () {},
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
