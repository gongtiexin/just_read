import 'package:flutter/material.dart';
import 'book.dart';

// 书籍列表
class BookList extends StatelessWidget {
  BookList({Key key, @required this.bookList}) : super(key: key);
  final bookList;

  Widget _buildBookList() {
    return ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: bookList.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _buildRow(bookList[i]);
        });
  }

  Widget _buildRow(Map<String, dynamic> book) {
    return Book(
      id: book['_id'],
      title: book['title'],
      author: book['author'],
      cat: book['cat'],
      cover: book['cover'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBookList(),
    );
  }
}
