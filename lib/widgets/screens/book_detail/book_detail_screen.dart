import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/entity/book.dart';
import 'package:flutter_portfolio/widgets/screens/book_detail/book_detail_view_model.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatelessWidget {
  final Book bookDetail;
  BookDetailScreen({
    Key key,
    @required this.bookDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookDetail.title),
        actions: <Widget>[
          TextButton(
            child: Text('追加'),
            onPressed: () =>
                Provider.of<BookDetailViewModel>(context, listen: false)
                    .onPressedAddBook(
              context: context,
              bookDetail: bookDetail,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Image.network(bookDetail.imageUrl),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  '著者 ' + bookDetail.authors,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  '出版社: ' + bookDetail.authors,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(bookDetail.descritpion),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
