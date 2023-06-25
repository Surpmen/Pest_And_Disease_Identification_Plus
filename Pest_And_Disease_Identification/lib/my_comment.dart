import 'package:flutter/material.dart';
//我的评论界面
class MyCommentPage extends StatefulWidget {
  @override
  _MyCommentPageState createState() => _MyCommentPageState();
}
class _MyCommentPageState extends State<MyCommentPage> {
  // 模拟的评论记录数据
  final List<Comment> _comments = [
    Comment(
      avatarUrl: 'images/avatar.png',
      username: '马金来',
      date: '2022-01-01',
      imageUrl: 'images/dixigua.png',
      title: '如何预防病虫害',
      content: '这是一篇非常有帮助的文章，谢谢分享，会转发加关注的！',
      views: 1234,
      likes: 10,
      comments: 2,
      hasLiked: false,
      hasCommented: false,
      hasToComment: false,
      followUpComment: '',
    ),
    Comment(
      avatarUrl: 'images/user_avatar.png',
      username: '谢时田',
      date: '2022-02-14',
      imageUrl: 'images/fanzhi2.jpg',
      title: '病虫害防治的常见方法',
      content: '这篇文章有很详细的介绍，学到了不少新知识，值得推荐呢',
      views: 5678,
      likes: 20,
      comments: 1,
      hasLiked: true,
      hasCommented: true,
      hasToComment: false,
      followUpComment: '我觉得还可以加入一些化学方法。',
    ),
    Comment(
      avatarUrl: 'images/avartar2.jpg',
      username: '康彦伟',
      date: '2022-03-08',
      imageUrl: 'images/noyai2.jpg',
      title: '农药的使用注意事项',
      content: '非常实用的知识，值得收藏！',
      views: 9101,
      likes: 30,
      comments: 0,
      hasLiked: true,
      hasCommented: false,
      hasToComment: true,
      followUpComment: '',
    ),
    Comment(
      avatarUrl: 'images/avatar1.jpg',
      username: '龚伊鸿杰',
      date: '2022-04-22',
      imageUrl: 'images/youji.jpg',
      title: '有机农业的优点和缺点',
      content: '很有启发性的文章，值得一看！',
      views: 1213,
      likes: 5,
      comments: 0,
      hasLiked: false,
      hasCommented: false,
      hasToComment: false,
      followUpComment: '',
    ),
    Comment(
      avatarUrl: 'images/avartar4.jpg',
      username: '神农之眼',
      date: '2022-05-10',
      imageUrl: 'images/xiangrig1.jpg',
      title: '生物防治的前景',
      content: '非常感谢作者的分享，让我对生物防治有了更深入的了解！',
      views: 1415,
      likes: 15,
      comments: 3,
      hasLiked: true,
      hasCommented: true,
      hasToComment: false,
      followUpComment: '我觉得生物防治还可以结合其他方法来实现。',
    ),
    Comment(
      avatarUrl: 'images/avartar3.jpg',
      username: '神农之眼',
      date: '2022-06-18',
      imageUrl: 'images/mihoutao1.jpg',
      title: '农作物疫病的鉴别方法',
      content: '非常实用的资讯，让我对农作物疫病的鉴别有了更深入的了解！',
      views: 1617,
      likes: 25,
      comments: 1,
      hasLiked: true,
      hasCommented: false,
      hasToComment: false,
      followUpComment: '我觉得可以加入一些实例来帮助理解。',
    ),
  ];
  // 当前选中的按钮索引
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的评论'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 打开搜索页面
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTabBar(),
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return _buildCommentItem(_comments[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
  // 构建横向文字按钮导航栏
  Widget _buildTabBar() {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabBarItem('全部', _comments.length),
          _buildTabBarItem('已评论', _comments.where((c) => c.hasCommented).length),
          _buildTabBarItem('待评论', _comments.where((c) => c.hasToComment).length),
          _buildTabBarItem('可追评', _comments.where((c) => c.hasCommented && c.hasToComment).length),
        ],
      ),
    );
  }
  // 构建横向文字按钮导航栏中的单个按钮
  Widget _buildTabBarItem(String title, int count) {
    bool isSelected = _selectedIndex == count - 1;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = count - 1;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: isSelected ? const TextStyle(fontWeight: FontWeight.bold) : null,
          ),
          const SizedBox(height: 2),
          Text(
            '$count',
            style: isSelected ? const TextStyle(fontWeight: FontWeight.bold) : null,
          ),
        ],
      ),
    );
  }
  // 构建单条评论记录的组件
  Widget _buildCommentItem(Comment comment) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Row(
      children: [
      CircleAvatar(
      radius: 20,
        backgroundImage: NetworkImage(comment.avatarUrl),
      ),
      const SizedBox(width: 12),
      Text(
        comment.username,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const Spacer(),
      Text(comment.date, style: TextStyle(color: Colors.grey[600])),
      ],
    ),
    const SizedBox(height: 12),
    GestureDetector(
    onTap: () {
    // TODO: 打开评论对应的文章或图片
    },
    child: AspectRatio(
    aspectRatio: 16 / 9,
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    image: DecorationImage(
    image: NetworkImage(comment.imageUrl),
    fit: BoxFit.cover,
    ),
    ),
    ),
    ),
    ),
    const SizedBox(height: 12),
    Text(
    comment.title,
    style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 8),
    Text(comment.content),
    const SizedBox(height: 12),
    Row(
    children: [
    Text(
    '${comment.views}浏览 · ${comment.likes}赞 · ${comment.comments}评论',
    style: TextStyle(color: Colors.grey[600]),
    ),
    const Spacer(),
    IconButton(
    icon: const Icon(Icons.thumb_up),
    color: comment.hasLiked ? Colors.blue : Colors.grey,
    onPressed: () {
    setState(() {
    comment.hasLiked = !comment.hasLiked;
    comment.likes += comment.hasLiked ? 1 : -1;
    });
    },
    ),
    IconButton(
    icon: const Icon(Icons.mode_comment),
    color: comment.hasCommented ? Colors.blue : Colors.grey,
    onPressed:
        () {
      setState(() {
        comment.hasCommented = true;
        comment.comments++;
        comment.hasToComment = true;
      });
// TODO: 打开评论编辑页面，将comment作为参数传递
    },
    ),
      IconButton(
        icon: const Icon(Icons.share),
        onPressed: () {
// TODO: 打开分享对话框
        },
      ),
      PopupMenuButton(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text('编辑'),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text('删除'),
          ),
          const PopupMenuItem(
            value: 3,
            child: Text('转发'),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case 1:
// TODO: 打开评论编辑页面，将comment作为参数传递
              break;
            case 2:
              setState(() {
                _comments.remove(comment);
              });
              break;
            case 3:
// TODO: 打开评论转发页面，将comment作为参数传递
              break;
          }
        },
      ),
    ],
    ),
          const SizedBox(height: 12),
          if (comment.hasToComment)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '追评',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.followUpComment,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// 评论记录类
class Comment {
  final String avatarUrl; // 用户头像
  final String username; // 用户名
  final String date; // 发表日期
  final String imageUrl; // 关联图片地址
  final String title; // 关联文章标题
  final String content; // 评论内容
  int views; // 浏览量
  int likes; // 点赞数
  int comments; // 评论数
  bool hasLiked; // 是否已点赞
  bool hasCommented; // 是否已评论
  bool hasToComment; // 是否可追评
  String followUpComment; // 追评内容

  Comment({
    required this.avatarUrl,
    required this.username,
    required this.date,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.views,
    required this.likes,
    required this.comments,
    required this.hasLiked,
    required this.hasCommented,
    required this.hasToComment,
    required this.followUpComment,
  });
}