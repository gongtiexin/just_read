import 'package:flutter/material.dart';
import 'dart:convert';
import 'store.dart';
import 'bookView.dart';

// 单本书
class Book extends StatelessWidget {
  const Book(
      {this.id, this.cover, this.title, this.author, this.cat, this.isAdd});
  final String id;
  final String cover;
  final String title;
  final String author;
  final String cat;
  final bool isAdd;

  void add() {
    var _bookList = <dynamic>[];
    store.read().then((value) {
      _bookList = jsonDecode(value);
      _bookList.add({
        '_id': id,
        'cover': cover,
        'title': title,
        'author': author,
        'cat': cat
      });
      store.write(jsonEncode(_bookList));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.network(
          Uri.decodeComponent(cover).replaceFirst('\/agent\/', ''),
          width: 70.0,
          height: 100.0,
        ),
        title: Text(title),
        subtitle: Row(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Text(author),
            ),
            Text(cat),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            add();
          },
        ),
        contentPadding: EdgeInsets.all(16.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookView(id: id)),
          );
        });
  }
}
