import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).bookListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本棚'),
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () =>
              Provider.of<HomeViewModel>(context, listen: false).onPressdMyPage(
            context: context,
          ),
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (BuildContext context, HomeViewModel value, Widget child) {
          // ViewModelのstateにアクセス
          final books = value.books;
          if (books.isEmpty)
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
                        'まだ本は登録されていません。',
                        style: TextStyle(
                            fontSize: 17, color: Colors.blueGrey.shade200),
                      ),
                    )
                  ],
                ),
              ),
            );
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
                    onTap: () =>
                        Provider.of<HomeViewModel>(context, listen: false)
                            .onTapImage(
                      context: context,
                      book: books[index],
                    ),
                    child: Image.network(books[index].imageUrl),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<HomeViewModel>(context, listen: false)
            .onTapFloatingActionButton(context: context),
        child: Icon(Icons.add),
      ),
    );
  }
}

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.brown.shade300,
//         title: Text('本棚'),
//       ),
//       body: StreamBuilder(
//           stream: BookDao.booksListener(),
//           builder: (context, snapshot) {
//             return FutureBuilder(
//               future: BookDao.getAllBooks(),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   List<Book> books = snapshot.data;
//                   return Container(
//                     child: GridView.count(
//                       padding: EdgeInsets.all(15.0),
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 10.0,
//                       mainAxisSpacing: 10.0,
//                       childAspectRatio: 0.7,
//                       shrinkWrap: true,
//                       children: List.generate(
//                         books.length,
//                         (index) {
//                           return InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => MemoListScreen(
//                                       bookId: books[index].bookId,
//                                       title: books[index].title),
//                                 ),
//                               );
//                             },
//                             child: Image.network(books[index].imageUrl),
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 } else {
//                   return CircularProgressIndicator();
//                 }
//               },
//             );
//           }),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.brown.shade200,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddBookScreen(),
//               fullscreenDialog: true,
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
