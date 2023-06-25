import 'package:flutter/material.dart';
//我的发布界面
// 发布类型的枚举
enum PublishType {
  all, // 全部
  article, // 文章
  info, // 资讯
  image, // 图片
  video, // 视频
  message, // 留言
  visitor, // 访客
}
// 发布记录的数据结构
class Publish {
  final String avatarUrl; // 用户头像
  final String name; // 用户名称
  final DateTime date; // 发布日期
  final PublishType type; // 发布类型
  final String imageUrl; // 农业病虫防治图片
  final String title; // 文章或资讯的标题
  final String content; // 具体农业病虫害防治资讯或文章的文本
  final int views; // 浏览次数
  final int likes; // 点赞数
  final int comments; // 评论数
  final int shares; // 转发数
  final List<String> likeUsers; // 点赞用户列表
  Publish({
    required this.avatarUrl,
    required this.name,
    required this.date,
    required this.type,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.views,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.likeUsers,
  });
}

final List<Publish> publishList = [
  Publish(
    avatarUrl: 'images/avatar.png',
    name: '病虫害杀手',
    date: DateTime(2022, 6, 1),
    type: PublishType.article,
    imageUrl: 'images/pinguo1.jpg',
    title: '如何防治苹果白粉病',
    content: '苹果白粉病是苹果树上的一种病害，主要危害苹果树的叶片，导致叶片枯萎、凋谢。防治方法：在苹果花前期和花后期喷洒50%多硫磷钙可湿性粉剂，每亩用水量40-50公斤。',
    views: 100,
    likes: 50,
    comments: 20,
    shares: 10,
    likeUsers: ['User2', 'User3', 'User4', 'User5'],
  ),
  Publish(
    avatarUrl: 'images/avatar.png',
    name: '病虫害杀手',
    date: DateTime(2022, 6, 2),
    type: PublishType.info,
    imageUrl: 'images/yvmi.jpg',
    title: '玉米螟防治',
    content: '玉米螟是危害玉米的一种害虫，喜欢在玉米花粉期产卵，导致玉米产量下降。防治方法：在玉米花粉期喷洒敌百虫乳油，每亩用水量40-50公斤。',
    views: 200,
    likes: 80,
    comments: 30,
    shares: 15,
    likeUsers: ['User1', 'User3', 'User5', 'User7'],
  ),
  Publish(
    avatarUrl: 'images/avatar.png',
    name: '病虫害杀手',
    date: DateTime(2022, 6, 3),
    type: PublishType.image,
    imageUrl: 'images/yachong.jpg',
    title: '蚜虫防治',
    content: '蚜虫是危害农作物的一种害虫，吸食植物汁液，导致植物生长不良。防治方法：在蚜虫大量出现时喷洒乙醇、丁醇等有机溶剂，或使用杀虫剂进行防治。',
    views: 300,
    likes: 120,
    comments: 40,
    shares: 20,
    likeUsers: ['User2', 'User4', 'User6', 'User8'],
  ),
  Publish(
    avatarUrl: 'images/avatar.png',
    name: '病虫害杀手',
    date: DateTime(2022, 6, 4),
    type: PublishType.video,
    imageUrl: 'images/fanqie.jpg',
    title: '番茄斑点病防治',
    content: '番茄斑点病是危害番茄的一种病害，主要危害番茄的叶片和果实，导致果实品质下降。防治方法：在番茄生长期间喷洒腐霉灵等杀菌剂进行防治。',
    views: 400,
    likes: 160,
    comments: 50,
    shares: 25,
    likeUsers: ['User1', 'User3', 'User5', 'User7', 'User9'],
  ),
  Publish(
    avatarUrl: 'images/avatar.png',
    name: '病虫害杀手',
    date: DateTime(2022, 6, 5),
    type: PublishType.article,
    imageUrl: 'images/nongya.jpeg',
    title: '如何选择合适的农药',
    content: '农药是农业生产中必不可少的工具，如何选择合适的农药是每个农民都需要掌握的技能。本文介绍了几种常见的农药及其使用方法。',
    views: 500,
    likes: 200,
    comments: 60,
    shares: 30,
    likeUsers: ['User2', 'User4', 'User6', 'User8', 'User10'],
  ),
];

class MyPublishPage extends StatefulWidget {
  @override
  _MyPublishPageState createState() => _MyPublishPageState();
}

class _MyPublishPageState extends State<MyPublishPage> {
  PublishType _selectedType = PublishType.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('我的发布'),
    ),
    body: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // 搜索框
    Padding(
    padding: EdgeInsets.all(16.0),
    child: TextField(
    decoration: InputDecoration(
    hintText: '搜索我的发布记录',
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
    ),
    ),
    ),
    ),
    // 导航栏
    Container(
    height: 40.0,
    child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
    _buildNavItem(PublishType.all),
    _buildNavItem(PublishType.article),
    _buildNavItem(PublishType.info),
    _buildNavItem(PublishType.image),
    _buildNavItem(PublishType.video),
    _buildNavItem(PublishType.message),
    _buildNavItem(PublishType.visitor),
    ],
    ),
    ),
    // 发布记录列表
    Expanded(
    child: ListView.builder(
    itemCount: publishList.length,
    itemBuilder: (BuildContext context, int index) {
    final publish = publishList[index];
    if (_selectedType != PublishType.all &&
    publish.type != _selectedType) {
    return SizedBox.shrink(); // 如果类型不符合要求，则不显示
    }
    return Container(
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 2,
    blurRadius: 5,
    offset: Offset(0, 3),
    ),
    ],
    borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // 用户头像和名称
    Row(
    children: [
    CircleAvatar(
    backgroundImage: NetworkImage(publish.avatarUrl),
    ),
    SizedBox(width: 8.0),
    Text(publish.name),
    SizedBox(width: 8.0),
    Text(
    publish.date.toString(),
    style: TextStyle(color: Colors.grey),
    ),
    ],
    ),
    SizedBox(height: 16.0),
    // 农业病虫防治图片
    if (publish.imageUrl.isNotEmpty)
    Image.network(publish.imageUrl),
    SizedBox(height: 16.0),
    // 文章或资讯的标题
    if (publish.title.isNotEmpty)
    Text(
    publish.title,
    style: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 8.0),
    // 具体农业病虫害防治资讯或文章的文本
    if (publish.content.isNotEmpty)
    Text(
    publish.content,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    ),
    SizedBox(height: 16.0),
    // 浏览次数、点赞数、评论数、转发数
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text('${publish.views} 浏览'),
    Row(
    children: [
    Icon(Icons.thumb_up),
    SizedBox(width: 4.0),
    Text(publish.likes.toString()),
    SizedBox(width: 16.0),
    Icon(Icons.comment),
    SizedBox(width: 4.0),
    Text(publish.comments.toString()),
    SizedBox(width: 16.0),
    Icon(Icons.share),
    SizedBox(width: 4.0),
    Text(publish.shares.toString()),
    ],
    ),
    ],
    ),
    SizedBox(height: 16.0),
    // 点赞用户列表
    if (publish.likeUsers.isNotEmpty)
    Row(
    children: [
    for (var user in publish.likeUsers.take(3))
    CircleAvatar(
    backgroundImage: NetworkImage(
    'images/user_avatar.png?text=$user'),
    ),
    SizedBox(width: 8.0),
    Text('等${publish.likeUsers.length}人觉得很赞'),
    ],
    ),
    ],
    ),
    );
    },
    ),
    ),
    ],
    ),
    );
  }

// 导航栏中单个选项的构建方法
  Widget _buildNavItem(PublishType type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2.0,
              color: _selectedType == type
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
            ),
          ),
        ),
        child: Center(
          child: Text(
            _getTypeName(type),
            style: TextStyle(
              color: _selectedType == type
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
// 发布类型枚举值对应的名称
  String _getTypeName(PublishType type) {
    switch (type) {
      case PublishType.all:
        return '全部';
      case PublishType.article:
        return '文章';
      case PublishType.info:
        return '资讯';
      case PublishType.image:
        return '图片';
      case PublishType.video:
        return '视频';
      case PublishType.message:
        return '留言';
      case PublishType.visitor:
        return '访客';
      default:
        return '';
    }
  }
}

