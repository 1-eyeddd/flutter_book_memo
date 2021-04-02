import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/memos/memo_dao.dart';
import 'package:intl/intl.dart';

import '../../models/entity/memo.dart';
import 'edit_memo_screen.dart';

class MemoDetailScreen extends StatelessWidget {
  final String bookId;
  final String memoId;
  final String memo;
  final String title;
  MemoDetailScreen(
      {Key key, @required this.memoId, this.bookId, this.memo, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ詳細'),
        backgroundColor: Colors.brown.shade300,
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMemoScreen(
                                    bookId: bookId,
                                    memoId: memoId,
                                    memo: memo,
                                    title: title),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.delete, color: Colors.redAccent),
                          title: Text('削除'),
                          onTap: () async {
                            var result = await showDialog<int>(
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
                                      onPressed: () async {
                                        await MemoDao.deleteMemo(
                                            memoId: memoId, bookId: bookId);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            print('dialog result: $result');
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('books')
            .doc(bookId)
            .collection('bookMemos')
            .doc(memoId)
            .snapshots(),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: MemoDao.getMemo(bookId: bookId, memoId: memoId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Memo memo = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          memo.memo,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Center(
                        child: Text(
                          (DateFormat('yyyy年MM月dd日 HH:mm')).format(
                            memo.createdAt.toDate(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        },
      ),
    );
  }
}
