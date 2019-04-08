import 'package:flutter/material.dart';

// 书籍列表
class ChapterList extends StatelessWidget {
  ChapterList(
      {Key key, @required this.chapterList, @required this.handleChapterTap})
      : super(key: key);
  final chapterList;
  final handleChapterTap;

  Widget _buildChapterList() {
    return ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: chapterList.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _buildRow(chapterList[i]);
        });
  }

  Widget _buildRow(Map<String, dynamic> chapter) {
    return ListTile(
      title: Text(chapter["title"]),
      onTap: () {
        handleChapterTap(chapter["id"]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildChapterList(),
    );
  }
}
