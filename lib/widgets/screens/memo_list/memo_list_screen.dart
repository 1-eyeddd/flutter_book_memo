import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/memo_list/memo_list_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MemoListScreen extends StatefulWidget {
  final String bookId;
  final String title;
  MemoListScreen({
    Key key,
    @required this.bookId,
    this.title,
  }) : super(key: key);

  @override
  _MemoListScreenState createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MemoListViewModel>(context, listen: false).memoListListener(
      bookId: widget.bookId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('確認'),
                    content: Text('この本を本当に削除しますか？'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(0),
                      ),
                      TextButton(
                        child: Text('OK'),
                        onPressed: () => Provider.of<MemoListViewModel>(
                          context,
                          listen: false,
                        ).onPressdDeleteBook(
                          context: context,
                          bookId: widget.bookId,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<MemoListViewModel>(
        builder: (
          BuildContext context,
          MemoListViewModel value,
          Widget child,
        ) {
          final memoList = value.memoList;
          if (memoList.isEmpty)
            return Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.auto_stories,
                      size: 160,
                      color: Colors.blueGrey.shade100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'まだメモがありません',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey.shade200,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: List.generate(
                  memoList.length,
                  (index) {
                    return InkWell(
                      onTap: () =>
                          Provider.of<MemoListViewModel>(context, listen: false)
                              .onTapMemo(
                        context: context,
                        memo: memoList[index],
                        title: widget.title,
                      ),
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
                                      (DateFormat('yyyy年MM月dd日 HH:mm')).format(
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
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<MemoListViewModel>(context, listen: false)
            .onTapFloatingActionButtonMemo(
          context: context,
          bookId: widget.bookId,
          title: widget.title,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
