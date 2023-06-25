import 'package:flutter/material.dart';
//我的识别界面
class MyRecognizePage extends StatefulWidget {
  @override
  _MyRecognizePageState createState() => _MyRecognizePageState();
}
class _MyRecognizePageState extends State<MyRecognizePage> {
  final TextEditingController _searchController = TextEditingController(); //创建一个文本编辑器控制器
  //用于存储用户识别记录的数据列表，这里只包含了4条记录
  final List<Map<String, String>> _recognizeData = [
    {
      'name': '玉米',
      'type': '玉米螟',
      'method': '生物防治、化学防治、物理防治。具体方法可以参考农业专家的建议。',
      'image': 'images/question1.jpeg'
    },
    {
      'name': '稻',
      'type': '稻瘟病',
      'method': '种病抗性育种、化学防治、物理防治。具体方法可以参考农业专家的建议。',
      'image': 'images/daowen.jpg'
    },
    {
      'name': '苹果',
      'type': '黑星病',
      'method': '生物防治、化学防治、物理防治。具体方法可以参考农业专家的建议。',
      'image': 'images/pingguo.png'
    },
    {
      'name': '柑桔',
      'type': '黄龙病',
      'method': '生物防治、化学防治、物理防治。具体方法可以参考农业专家的建议。',
      'image': 'images/jvzi.jpeg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的识别'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(), //添加搜索栏
          _buildRecognizeList(), //添加识别记录列表
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
          hintText: '搜索您的识别记录',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  //构建识别记录列表
  Widget _buildRecognizeList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _recognizeData.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRecognizeItem(index);
        },
      ),
    );
  }

  //构建识别记录列表中的每一项
  Widget _buildRecognizeItem(int index) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_recognizeData[index]['name']} - ${_recognizeData[index]['type']}', //显示病虫害名称和种类
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent, //突出显示病虫害名称和种类
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 150.0,
            width: double.infinity,
            child: Image.network(
              _recognizeData[index]['image'] ?? '', //显示病虫害图片
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            _recognizeData[index]['method'] ?? '', //显示防治方法
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}