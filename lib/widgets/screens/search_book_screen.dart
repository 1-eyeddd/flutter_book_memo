import 'dart:convert';
import 'package:flutter_portfolio/widgets/screens/view_book.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/entity/book.dart';

class SearchBooksScreen extends StatefulWidget {
  @override
  _SearchBooksScreentate createState() => _SearchBooksScreentate();
}

class _SearchBooksScreentate extends State<SearchBooksScreen> {
  Icon icon = Icon(Icons.search);
  Widget searchWidget = Text('本を検索する');
  String results = '';

  List<Search> books = List<Search>();

  @override
  void initState() {
    searchBooks('');
    super.initState();
  }

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
                      onSubmitted: (searchText) => searchBooks(searchText),
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
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: ((BuildContext context, int index) {
          return Card(
            elevation: 2,
            child: ListTile(
              onTap: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (_) => ViewBook(books[index]));
                Navigator.push(context, route);
              },
              leading: Image.network(books[index].urlImage),
              title: Text(books[index].title),
              subtitle: Text(books[index].authors),
            ),
          );
        }),
      ),
    );
  }

  Future searchBooks(String search) async {
    try {
      final String uri =
          'https://www.googleapis.com/books/v1/volumes?q=' + search;
      http.get(uri).then((res) {
        final resJson = json.decode(res.body);
        final booksMap = resJson['items'];
        books = booksMap.map<Search>((map) => Search.fromMap(map)).toList();
        setState(() {
          results = res.body;
          books = books;
        });
      });
    } catch (error) {
      setState(() {
        results = 'No books found.';
      });
    }
  }
}
