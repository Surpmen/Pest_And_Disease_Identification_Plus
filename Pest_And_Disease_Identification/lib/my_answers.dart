import 'package:flutter/material.dart';
//我的问答界面
class MyAnswersPage extends StatefulWidget {
  @override
  _MyAnswersPageState createState() => _MyAnswersPageState();
}

class _MyAnswersPageState extends State<MyAnswersPage> {
  final TextEditingController _searchController = TextEditingController();

  //用于存储用户问答记录的数据列表 //创建一个文本编辑器控制器
  final List<Map<String, String>> _answersData = [
    {
      'question': '如何防治玉米螟？',
      'answer': '生物防治、化学防治、物理防治。具体方法可以参考农业专家的建议。',
      'image': 'images/question1.jpeg',
    },
    {
      'question': '稻瘟病如何治疗？',
      'answer': '种病抗性育种、化学防治、物理防治。具体方法可以参考农业专家的建议。',
      'image': 'images/daowen.jpg',
    },
    {
      'question': '苹果黑星病怎么办？',
      'answer': '生物防治、化学防治、物理防治。具体方法可以参考农业专家的建议。',
      'image': 'images/pingguo.png',
    },
    {
      'question': '柑桔黄龙病该如何防治？',
      'answer': '生物防治、化学防治、物理防治。具体方法可以参考农业专家的建议。',
      'image': 'images/jvzi.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的问答'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(), //添加搜索栏
          _buildAnswersList(), //添加问答记录列表
        ],
      ),
    );
  }
  //构建搜索栏
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: '搜索您的历史问题',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
  //构建问答记录列表
  Widget _buildAnswersList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _answersData.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildAnswerItem(index);
        },
      ),
    );
  }
  //构建问答记录列表中的每一项
  Widget _buildAnswerItem(int index) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _answersData[index]['question'] ?? '', //显示用户提出的问题
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent, //突出显示问题文本
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 150.0,
            width: double.infinity,
            child: Image.network(
              _answersData[index]['image'] ?? '', //显示用户上传的图片
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            _answersData[index]['answer'] ?? '', //显示对应的回答
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54, //突出显示回答文本
            ),
          ),
        ],
      ),
    );
  }
}