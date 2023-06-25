import 'package:flutter/material.dart';

//资讯页面
class ConsultPage extends StatefulWidget {
  @override
  _ConsultPageState createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  // 定义搜索框的控制器
  final TextEditingController _searchController = TextEditingController();
  // 定义当前选中的导航栏索引
  int _selectedIndex = 0;
  // 定义资讯内容的列表数据
  final List<Map<String, dynamic>> _newsList = [
    {
      "title": "农作物病虫害防治知识大全",
      "subtitle": "这里有农作物病虫害防治的全部知识",
      "image": "images/news1.jpg",
    },
    {
      "title": "农业政策最新动态",
      "subtitle": "这里有最新的农业政策动态",
      "image": "images/news2.jpg",
    },
    {
      "title": "果树栽培技巧分享",
      "subtitle": "这里有果树栽培技巧的分享",
      "image": "images/news3.jpg",
    },
    {
      "title": "蔬菜种植有妙招",
      "subtitle": "这里有蔬菜种植的妙招",
      "image": "images/news4.jpg",
    },
  ];

  // 生成资讯内容的列表项
  Widget _buildNewsItem(Map<String, dynamic> news) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            news['image'],
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news['title'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  news['subtitle'],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        centerTitle: true,
        title: Text("农作物病虫害防治资讯"),
        // 在AppBar中添加一个搜索框
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 在顶部添加一个搜索框
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "搜索病虫害/问答/文章",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // 添加一个横向的文字导航栏
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      ["推荐", "植保水肥", "农业政策", "果树", "蔬菜"][index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: index == _selectedIndex
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: index == _selectedIndex
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          // 添加资讯内容列表
          Expanded(
            child: ListView.builder(
              itemCount: _newsList.length,
              itemBuilder: (BuildContext context, int index) {
                // 只显示当前导航栏索引对应的资讯内容
                if (_selectedIndex == 0 || index % 4 == _selectedIndex - 1) {
                  return _buildNewsItem(_newsList[index]);
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}