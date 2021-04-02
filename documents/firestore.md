# Firestore設計

## books

```dart
{
  bookId: String,
  bookName: String,
  imageUrl: String,
}
```
パス: `/books/{bookId}`

## bookMemos

```dart
{
  memoId: String,
  bookId: String,
  memo: String,
  createdAt: TimeStamp,
}
```
パス: `/books/{bookId}/bookMemos/{bookMemoId}`

