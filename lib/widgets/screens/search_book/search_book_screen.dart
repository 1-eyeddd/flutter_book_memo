import 'package:flutter_portfolio/widgets/screens/search_book/search_book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBookScreen extends StatefulWidget {
  SearchBookScreen({Key key}) : super(key: key);
  @override
  _SearchBookScreenState createState() => _SearchBookScreenState();
}

class _SearchBookScreenState extends State<SearchBookScreen> {
  Icon icon = Icon(Icons.search);
  Widget searchWidget = Text('本を検索する');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchWidget,
        actions: [
          IconButton(
            icon: icon,
            onPressed: () {
              setState(
                () {
                  if (this.icon.icon == Icons.search) {
                    this.icon = Icon(Icons.cancel);
                    this.searchWidget = TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (searchText) =>
                          Provider.of<SearchBookViewModel>(context)
                              .searchBooks(searchText),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else {
                    setState(
                      () {
                        this.icon = Icon(Icons.search);
                        this.searchWidget = Text('本を検索する');
                      },
                    );
                  }
                },
              );
            },
          )
        ],
      ),
      body: Consumer<SearchBookViewModel>(
        builder: (
          BuildContext context,
          SearchBookViewModel value,
          Widget child,
        ) {
          final bookList = value.bookList;
          return ListView(
            children: List.generate(
              bookList.length,
              (index) {
                return Card(
                  elevation: 2,
                  child: ListTile(
                    onTap: () =>
                        Provider.of<SearchBookViewModel>(context, listen: false)
                            .onTapBookDetail(
                                context: context, bookDetail: bookList[index]),
                    leading: Image.network(bookList[index].imageUrl),
                    title: Text(bookList[index].title),
                    subtitle: Text(bookList[index].authors),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
