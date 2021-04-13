import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_memo_view_model.dart';

class AddMemoScreen extends StatelessWidget {
  final String bookId;
  final String title;
  AddMemoScreen({Key key, @required this.bookId, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: コントローラーをViewModelにかく
    final _textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'メモを追加',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 14.0,
                right: 14,
                left: 14,
              ),
              child: Container(
                height: 450,
                child: TextField(
                  maxLength: 600,
                  maxLines: 20,
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'メモしてみましょう',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Text(
              '24時間後にメモがリマインドされます！',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueGrey.shade400,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: new ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                  ),
                  child: const Text('メモを追加する'),
                  onPressed: () => Provider.of<AddMemoViewModel>(
                    context,
                    listen: false,
                  ).onPressedAddMemo(
                    context: context,
                    bookId: bookId,
                    memo: _textController.text,
                    title: title,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
