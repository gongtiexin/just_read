import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'chapterList.dart';

class BookView extends StatefulWidget {
  const BookView({Key key, @required this.id}) : super(key: key);
  final String id;

  BookViewState createState() => BookViewState();
}

class BookViewState extends State<BookView> {
  var _chapterList = <dynamic>[];
  Map<String, dynamic> _chapter = {'cpContent': '...', 'title': '...'};

  void _getChapterList() async {
    var id = widget.id;
    var url = 'http://api.zhuishushenqi.com/atoc/$id?view=chapters';
    var httpClient = new HttpClient();
    var result = <dynamic>[];
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var json = await response.transform(Utf8Decoder()).join();
        var data = jsonDecode(json);
        result = data['chapters'];
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

    if(result.isNotEmpty){
    _getChapter(result[0]['id']);
    }

    setState(() {
      _chapterList = result;
    });
  }

  void _getChapter(id) async {
    var url =
        'http://chapterup.zhuishushenqi.com/chapter/http://vip.zhuishushenqi.com/chapter/$id';
    var httpClient = new HttpClient();
    var result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var json = await response.transform(Utf8Decoder()).join();
        var data = jsonDecode(json);
        result = data['chapter'];
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
      _chapter = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getChapterList();
    return Scaffold(
      appBar: AppBar(
        title: Text(_chapter['title']),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped!
          },
          child: Text(_chapter['cpContent']),
        ),
      ),
      endDrawer: ChapterList(
        chapterList: _chapterList,
        handleChapterTap: _getChapter,
      ),
    );
  }
}
