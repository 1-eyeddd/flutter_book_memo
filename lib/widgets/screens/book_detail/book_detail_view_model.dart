import 'package:flutter/material.dart';
import 'package:flutter_portfolio/models/dao/books/book_dao.dart';
import 'package:flutter_portfolio/models/entity/book.dart';
import 'package:flutter_portfolio/models/service/user_service.dart';

class BookDetailViewModel extends ChangeNotifier {
  void onPressedAddBook({
    @required BuildContext context,
    @required Book bookDetail,
  }) {
    final user = UserService.getUserInfo().uid;
    {
      BookDao.addBook(
        userId: user,
        title: bookDetail.title,
        imageUrl: bookDetail.imageUrl,
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}
