import 'dart:convert';
import 'package:flutter/material.dart';
import 'bookList.dart';
import 'store.dart';

// 书架
class Bookshelf extends StatefulWidget {
  @override
  BookshelfState createState() => BookshelfState();
}

class BookshelfState extends State<Bookshelf> {
  var _bookList = <dynamic>[];

  void readBookListFromDisk() {
    store.read().then((value) {
      setState(() {
        _bookList = jsonDecode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    readBookListFromDisk();
    return BookList(bookList: _bookList);
  }
}
