import 'package:flutter/material.dart';
import 'package:flutter_portfolio/util/local_notification.dart';
import 'package:flutter_portfolio/widgets/screens/add_book/add_book_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/add_memo/add_memo_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/edit_memo/edit_memo_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_portfolio/widgets/screens/home/home_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/memo_detail/memo_detail_view_model.dart';
import 'package:flutter_portfolio/widgets/screens/memo_list/memo_list_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebaseの初期設定
  await Firebase.initializeApp();
  // 通知の初期設定
  await LocalNotification.initialize();
  runApp(MyApp());
}

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
