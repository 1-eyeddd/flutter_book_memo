import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/edit_memo/edit_memo_view_model.dart';
import 'package:provider/provider.dart';

class EditMemoScreen extends StatelessWidget {
  final String bookId;
  final String memo;
  final String memoId;
  final String title;
  EditMemoScreen({
    Key key,
    @required this.bookId,
    this.memoId,
    this.memo,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO:viewに書きたい
    final _textController = TextEditingController();
    _textController.text = memo;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade300,
        title: Text('メモを編集'),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown.shade300,
                    onPrimary: Colors.white,
                  ),
                  child: const Text('メモを更新する'),
                  onPressed: () =>
                      Provider.of<EditMemoViewModel>(context, listen: false)
                          .onPressdEditMemo(
                    context: context,
                    bookId: bookId,
                    newMemo: _textController.text,
                    memoId: memoId,
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
