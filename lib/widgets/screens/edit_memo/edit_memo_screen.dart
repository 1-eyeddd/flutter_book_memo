import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/edit_memo/edit_memo_view_model.dart';
import 'package:provider/provider.dart';

class EditMemoScreen extends StatefulWidget {
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
  _EditMemoScreenState createState() => _EditMemoScreenState();
}

class _EditMemoScreenState extends State<EditMemoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<EditMemoViewModel>(context, listen: false).textController.text =
        widget.memo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                child: TextFormField(
                  maxLength: 600,
                  maxLines: 20,
                  controller:
                      Provider.of<EditMemoViewModel>(context).textController,
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
                    onPrimary: Colors.white,
                  ),
                  child: const Text('メモを更新する'),
                  onPressed: () =>
                      Provider.of<EditMemoViewModel>(context, listen: false)
                          .onPressdEditMemo(
                    context: context,
                    bookId: widget.bookId,
                    memoId: widget.memoId,
                    title: widget.title,
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
