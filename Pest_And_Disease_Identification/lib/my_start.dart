import 'package:flutter/material.dart';
//我的收藏界面
class MyStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的收藏',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyFavoritesPage(),
    );
  }
}
class MyFavoritesPage extends StatefulWidget {
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  final List<String> _categories = [
    '全部', '文章', '资讯', '图片', '视频', '链接', '文件',
  ];
  String _selectedCategory = '全部';
  final List<Map<String, dynamic>> _favorites = [
    {
      'type': '文章',
      'title': '病虫害防治方法大全',
      'content': '在这篇文章中，我们将详细介绍各种农业病虫害的防治方法，以帮助农民们更好地保护农作物。',
      'image': 'images/fanzhi.jpg',
      'author': '云南大学',
      'date': '2023-06-01',
    },
    {
      'type': '资讯',
      'title': '病虫害防治新技术',
      'content': '最近，科学家们研发出了一种新型的病虫害防治技术，对于农业生产具有重要意义。',
      'image': 'images/nwejishu.jpg',
      'author': '马金来',
      'date': '2023-06-10',
    },
    {
      'type': '图片',
      'title': '病虫害识别指南',
      'content': '这是一份病虫害识别指南，通过图片可以帮助农民们更快地识别出病虫害。',
      'image': 'images/liucheng.jpg',
      'author': '谢时田',
      'date': '2023-06-13',
    },
    {
      'type': '视频',
      'title': '病虫害防治实践教程',
      'content': '这是一部病虫害防治实践教程视频，通过观看视频，农民们可以学习到实用的防治技巧。',
      'image': 'images/vedio.png',
      'author': '康彦伟',
      'date': '2023-06-14',
    },
    {
      'type': '链接',
      'title': '病虫害防治专家讲座',
      'content': '这是一个病虫害防治专家讲座的链接，农民们可以在线收听这场讲座，了解更多防治知识。',
      'image': 'images/jiangzuo.jpg',
      'author': '云南农业大学',
      'date': '2023-06-15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收藏'),
      ),
      body: Column(
        children: [
          // 1. 搜索框
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: '搜索',
                hintText: '输入关键词搜索您收藏记录',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // 2. 横向文字导航栏
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: _selectedCategory == category
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // 3. 收藏记录列表
          Expanded(
            child: ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final item = _favorites[index];
                if (_selectedCategory != '全部' &&
                    _selectedCategory != item['type']) {
                  return const SizedBox.shrink();
                }

                return ListTile(
                  leading: Image.asset(item['image'], width: 50, height: 50),
                  title: Text(
                    item['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['content']),
                      Text(
                        '作者：${item['author']}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        '收藏日期：${item['date']}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: () {
                    // 点击收藏记录，跳转到对应页面
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('查看详情'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '类型：${item['type']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(item['content']),
                                const SizedBox(height: 10),
                                Text('作者：${item['author']}'),
                                const SizedBox(height: 10),
                                Text('收藏日期：${item['date']}'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('关闭'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}