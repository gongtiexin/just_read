import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'bookList.dart';

// 书库
class Library extends StatefulWidget {
  @override
  LibraryState createState() => LibraryState();
}

class LibraryState extends State<Library> {
  var _bookList = <dynamic>[];

  void _handleSearchInputSubmitted(String text) async {
    setState(() {
      _bookList = <dynamic>[];
    });

    var url = 'http://api.zhuishushenqi.com/book/fuzzy-search?query=$text';
    var httpClient = new HttpClient();
    var result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var json = await response.transform(Utf8Decoder()).join();
        var data = jsonDecode(json);
        result = data['books'];
      } else {
        print('Error getting IP address:\nHttp status ${response.statusCode}');
      }
    } catch (exception) {
      print('Failed getting IP address');
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      _bookList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchInput(handleSubmitted: _handleSearchInputSubmitted),
        Expanded(child: BookList(bookList: _bookList))
      ],
    );
  }
}

// 搜索框
class SearchInput extends StatelessWidget {
  SearchInput({Key key, @required this.handleSubmitted}) : super(key: key);
  final ValueChanged<String> handleSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        decoration:
            InputDecoration(icon: Icon(Icons.search), hintText: '请输入一个搜索词'),
        onSubmitted: (text) {
          handleSubmitted(text);
        },
      ),
    );
  }
}
