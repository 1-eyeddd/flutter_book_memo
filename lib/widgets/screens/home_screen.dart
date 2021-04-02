import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/entity/book.dart';
import 'package:flutter_portfolio/widgets/screens/memo_list_screen.dart';
import 'package:flutter_portfolio/widgets/screens/add_book_screen.dart';
import 'package:flutter_portfolio/models/dao/books/book_dao.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade300,
        title: Text('本棚'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder: (context, snapshot) {
            return FutureBuilder(
              future: BookDao.getAllBooks(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Book> books = snapshot.data;
                  return Container(
                    child: GridView.count(
                      padding: EdgeInsets.all(15.0),
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7,
                      shrinkWrap: true,
                      children: List.generate(
                        books.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemoListScreen(
                                      bookId: books[index].bookId,
                                      title: books[index].title),
                                ),
                              );
                            },
                            child: Image.network(books[index].imageUrl),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade200,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
