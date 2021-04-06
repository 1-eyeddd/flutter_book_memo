import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/books/book_dao.dart';
import 'package:flutter_portfolio/models/entity/book.dart';
import 'package:flutter_portfolio/widgets/screens/add_book/add_book_screen.dart';
import 'package:flutter_portfolio/widgets/screens/memo_list/memo_list_screen.dart';

class HomeViewModel extends ChangeNotifier {
  // 画面の状態
  // その画面で用いる情報の情報の状態管理（State）
  // ex: 本棚で表示される本のリストつまりList<Book>
  List<Book> _books = <Book>[];

  List<Book> get books => _books;

  // 本の情報を監視
  void bookListener() {
    BookDao.booksListener().listen((snapshot) {
      final books = snapshot.docs.map((document) {
        final data = document.data();
        print(data);
        final title = data['title'] as String ?? '';
        final bookId = data['bookId'] as String ?? '';
        final imageUrl = data['imageUrl'] as String ?? '';
        final book = Book(
          bookId: bookId,
          title: title,
          imageUrl: imageUrl,
        );
        return book;
      }).toList();
      _books = books;
      notifyListeners();
    });
  }

// 画像をタップ
  void onTapImage({
    @required BuildContext context,
    @required Book book,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoListScreen(
          bookId: book.bookId,
          title: book.title,
        ),
      ),
    );
  }

  // 追加ボタンをタップ
  void onTapFloatingActionButton({
    @required BuildContext context,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookScreen(),
        fullscreenDialog: true,
      ),
    );
  }
}
