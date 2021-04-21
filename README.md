# book_memo_app

## 概要
書籍管理アプリ。<br>
ユーザーごと本情報を取得。<br>
本ごとにメモをすることが可能。<br>
忘れやすいタイミングでメモがリマインドされます。<br>

## 使用技術
* Dart 2.12.2
* FVM
  * Flutter 1.22.4
* Firebase

## Demo
<img src="https://user-images.githubusercontent.com/79823463/115172629-a11c7200-a100-11eb-99e6-19e7efb9e559.png" width="200px"> <img src="https://user-images.githubusercontent.com/79823463/115181242-6e7b7500-a112-11eb-95d0-b086f5a37a82.png" width="200px"> <img src="https://user-images.githubusercontent.com/79823463/115172651-ada0ca80-a100-11eb-9684-94e3024bef68.png" width="200px"> <img src="https://user-images.githubusercontent.com/79823463/115172675-b4c7d880-a100-11eb-971b-81f9dda32a54.png" width="200px"> <img src="https://user-images.githubusercontent.com/79823463/115174202-c65eaf80-a103-11eb-9d7e-f45484eb2e37.png" width="200px"> <img src="https://user-images.githubusercontent.com/79823463/115172734-d032e380-a100-11eb-8175-cf7af1fc145f.png" width="200px"> <img src="https://user-images.githubusercontent.com/79823463/115172718-cad59900-a100-11eb-955b-9cacc44f68b1.png" width="200px"> <img src="https://user-images.githubusercontent.com/79823463/115173978-55b79300-a103-11eb-98f0-98f8d5607625.png" width="200px">

## ファイル構成
<pre>
├── main.dart
├── models
│   ├── dao
│   │   ├── books
│   │   │   └── book_dao.dart
│   │   ├── memos
│   │   │   └── memo_dao.dart
│   │   └── users
│   │       └── user_dao.dart
│   ├── entity
│   │   ├── book.dart
│   │   ├── memo.dart
│   │   └── users.dart
│   └── service
│       └── user_service.dart
├── util
│   └── local_notification.dart
└── widgets
    ├── auth
    │   └── auth_check.dart
    └── screens
        ├── add_book
        │   ├── add_book_screen.dart
        │   └── add_book_view_model.dart
        ├── add_memo
        │   ├── add_memo_screen.dart
        │   └── add_memo_view_model.dart
        ├── edit_memo
        │   ├── edit_memo_screen.dart
        │   └── edit_memo_view_model.dart
        ├── home
        │   ├── home_screen.dart
        │   └── home_view_model.dart
        ├── memo_detail
        │   ├── memo_detail_screen.dart
        │   └── memo_detail_view_model.dart
        ├── memo_list
        │   ├── memo_list_screen.dart
        │   └── memo_list_view_model.dart
        ├── my_page
        │   ├── my_page_screen.dart
        │   └── my_page_view_model.dart
        ├── sign_in
        │   ├── sign_in_screen.dart
        │   └── sign_in_view_model.dart
        └── sign_up
            ├── sign_up_screen.dart
            └── sign_up_view_model.dart
</pre>

## Architecture
状態管理として、Provider ＋ ChangeNotifierを使用。<br>1つのScreenに対し、1つのViewModelを作成し、UIとロジックを切り離すようにしました。<br>
<br>
<img width="996" alt="archi" src="https://user-images.githubusercontent.com/79823463/115174015-6962f980-a103-11eb-8359-2328b60f11ca.png">
