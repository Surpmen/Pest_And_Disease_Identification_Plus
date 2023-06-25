import 'package:flutter/material.dart';
//我的界面
import 'user_detail_page.dart';
import 'my_recognize.dart';
import 'my_answers.dart';
import 'my_start.dart';
import 'my_publish.dart';
import 'my_comment.dart';
import 'setting.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人中心')),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            title: Text('病虫害杀手'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserDetailPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('我的识别'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRecognizePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('我的问答'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAnswersPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('我的收藏'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyStartPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.publish),
            title: Text('我的发布'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPublishPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.comment),
            title: Text('我的评论'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCommentPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}