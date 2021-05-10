import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/screens/search_book/search_book_view_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_portfolio/util/local_notification.dart';
import 'package:flutter_portfolio/widgets/auth/auth_check.dart';
import 'package:flutter_portfolio/widgets/screens/home/home_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/add_book/add_book_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/add_memo/add_memo_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/sign_in/sign_in_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/sign_up/sign_up_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/edit_memo/edit_memo_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/memo_detail/memo_detail_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/memo_list/memo_list_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/my_page/my_page_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebaseの初期設定
  await Firebase.initializeApp();
  // 通知の初期設定
  await LocalNotification.initialize();
  runApp(MyApp());
}

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
        ChangeNotifierProvider<MemoListViewModel>(
            create: (_) => MemoListViewModel()),
        ChangeNotifierProvider<MemoDetailViewModel>(
            create: (_) => MemoDetailViewModel()),
        ChangeNotifierProvider<EditMemoViewModel>(
            create: (_) => EditMemoViewModel()),
        ChangeNotifierProvider<AddMemoViewModel>(
            create: (_) => AddMemoViewModel()),
        ChangeNotifierProvider<AddBookViewModel>(
            create: (_) => AddBookViewModel()),
        ChangeNotifierProvider<MyPageViewModel>(
            create: (_) => MyPageViewModel()),
        ChangeNotifierProvider<SignInViewModel>(
            create: (_) => SignInViewModel()),
        ChangeNotifierProvider<SignUpViewModel>(
            create: (_) => SignUpViewModel()),
        ChangeNotifierProvider<SearchBookViewModel>(
            create: (_) => SearchBookViewModel()),
      ],
      child: MaterialApp(
        navigatorObservers: <NavigatorObserver>[routeObserver],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //ログインされているかチェック
        home: AuthCheck(),
      ),
    );
  }
}
