import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/books/book_dao.dart';
import 'package:flutter_portfolio/models/entity/book.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';
import 'package:flutter_portfolio/widgets/screens/add_book/add_book_screen.dart';
import 'package:flutter_portfolio/widgets/screens/memo_list/memo_list_screen.dart';
import 'package:flutter_portfolio/widgets/screens/my_page/my_page_screen.dart';

class HomeViewModel extends ChangeNotifier {
  List<Book> _books = <Book>[];

  List<Book> get books => _books;

  // 本の情報を監視
  void bookListener() {
    final user = UserService.getUserInfo().uid;
    BookDao.booksListener(
      userId: user,
    ).listen((snapshot) {
      final books = snapshot.docs.map((document) {
        final data = document.data();
        print(data);
        final title = data['title'] as String ?? '';
        final bookId = data['bookId'] as String ?? '';
        final imageUrl = data['imageUrl'] as String ?? '';
        final book = Book(
          userId: user,
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

// 本の画像をタップしてメモ一覧へ
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

  // 本追加画面へ遷移
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

  //マイページへ遷移
  void onPressdMyPage({
    @required BuildContext context,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyPageScreen(),
      ),
    );
  }
}
