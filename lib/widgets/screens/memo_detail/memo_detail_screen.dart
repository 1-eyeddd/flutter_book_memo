import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'memo_detail_view_model.dart';

class MemoDetailScreen extends StatefulWidget {
  final String bookId;
  final String memoId;
  final String memo;
  final String title;
  MemoDetailScreen({
    Key key,
    @required this.memoId,
    this.bookId,
    this.memo,
    this.title,
  }) : super(key: key);

  @override
  _MemoDetailScreenState createState() => _MemoDetailScreenState();
}

class _MemoDetailScreenState extends State<MemoDetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MemoDetailViewModel>(context, listen: false).memosListener(
      bookId: widget.bookId,
      memoId: widget.memoId,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ詳細'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.edit, color: Colors.blueAccent),
                          title: Text('編集'),
                          onTap: () => Provider.of<MemoDetailViewModel>(context,
                                  listen: false)
                              .onTapEditMemoScreen(
                            context: context,
                            title: widget.title,
                            bookId: widget.bookId,
                            memoId: widget.memoId,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.delete, color: Colors.redAccent),
                          title: Text('削除'),
                          onTap: () async {
                            await showDialog<int>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('確認'),
                                  content: Text('削除してもよろしいですか？'),
                                  actions: <Widget>[
                                    TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(0)),
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () =>
                                          Provider.of<MemoDetailViewModel>(
                                                  context,
                                                  listen: false)
                                              .onPressDeleteMemo(
                                        context: context,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<MemoDetailViewModel>(
        builder: (
          BuildContext context,
          MemoDetailViewModel value,
          Widget child,
        ) {
          final memo = value.memo;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    (memo?.memo) ?? '',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Center(
                  child: Text(
                    (DateFormat('yyyy年MM月dd日 HH:mm')).format(
                      memo?.createdAt?.toDate() ?? DateTime.now(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
