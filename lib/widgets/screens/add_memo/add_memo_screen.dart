import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_memo_view_model.dart';

class AddMemoScreen extends StatefulWidget {
  final String bookId;
  final String title;
  AddMemoScreen({
    Key key,
    @required this.bookId,
    this.title,
  }) : super(key: key);

  @override
  _AddMemoScreenState createState() => _AddMemoScreenState();
}

class _AddMemoScreenState extends State<AddMemoScreen> {
  @override
  Widget build(BuildContext context) {
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
                  controller:
                      Provider.of<AddMemoViewModel>(context).textController,
                  decoration: InputDecoration(
                    hintText: 'メモしてみましょう',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '24時間後にメモをリマインドする',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey.shade400,
                  ),
                ),
                Switch(
                  value: Provider.of<AddMemoViewModel>(context, listen: false)
                      .switchControl,
                  onChanged: (bool value) {
                    setState(() {
                      Provider.of<AddMemoViewModel>(context, listen: false)
                          .toggleSwitch(value);
                    });
                  },
                )
              ],
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
                    bookId: widget.bookId,
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
