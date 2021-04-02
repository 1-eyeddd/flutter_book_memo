import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/memos/memo_dao.dart';
import 'package:flutter_portfolio/models/entity/memo.dart';
import 'package:flutter_portfolio/widgets/screens/add_memo_screen.dart';
import 'package:flutter_portfolio/widgets/screens/memo_detail_screen.dart';
import 'package:intl/intl.dart';

class MemoListScreen extends StatefulWidget {
  final String bookId;
  final String title;
  MemoListScreen({Key key, @required this.bookId, this.title})
      : super(key: key);

  @override
  _MemoListScreenState createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title), backgroundColor: Colors.brown.shade300),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('books')
            .doc(widget.bookId)
            .collection('bookMemos')
            .snapshots(),
        builder: (context, snapshot) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(7.5),
              child: FutureBuilder(
                future: MemoDao.getBookMemos(bookId: widget.bookId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: const Text('Loading...'));
                  List<Memo> memoList = snapshot.data;
                  if (memoList.isEmpty)
                    return Padding(
                      padding: const EdgeInsets.only(top: 150.0),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.auto_stories,
                                size: 160, color: Colors.blueGrey.shade100),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'まだメモがありません',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.blueGrey.shade200),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  return ListView.builder(
                    itemCount: memoList.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemoDetailScreen(
                                  memoId: memoList[index].memoId,
                                  bookId: memoList[index].bookId,
                                  memo: memoList[index].memo,
                                  title: widget.title),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Wrap(
                                    children: [
                                      Text(
                                        memoList[index].memo,
                                        overflow: TextOverflow.fade,
                                        maxLines: 3,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        (DateFormat('yyyy年MM月dd日 HH:mm'))
                                            .format(
                                          memoList[index].createdAt.toDate(),
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade200,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddMemoScreen(title: widget.title, bookId: widget.bookId),
              fullscreenDialog: true,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
