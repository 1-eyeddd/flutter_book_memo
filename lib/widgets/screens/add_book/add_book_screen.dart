import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/add_book/add_book_view_model.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatelessWidget {
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
              key:
                  Provider.of<AddBookViewModel>(context, listen: false).formkey,
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
                      onPressed: () =>
                          Provider.of<AddBookViewModel>(context, listen: false)
                              .onPressdAddBook(
                        context: context,
                      ),
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
