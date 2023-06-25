import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pest_and_disease_identification/Result.dart';

import 'camera.dart';

//结果显示页面
class Result extends StatefulWidget {
  final String resultId;
  Result({super.key, required this.resultId});

  @override
  ResultState createState() => ResultState();
}
class ResultState extends State<Result> {
  String _resultId = "";// 用于接收传过来的病虫害id
  String _jsonData = "";
  // String name = '';// 病虫害的名称
  // String yname = '';// 病虫害的别名
  // String description = '';// 病虫害的描述
  // String cycle = '';// 病虫害的发病周期
  // String style = '';// 病虫害的特点
  // List<String> images = [''];// 病虫害的图片
  // String way = '';// 病虫害的防治方法
  // List<String> images = thumbs.split(',');
  int _currentPageIndex = 0;// 图片导航
  Pest pest = Pest();// 声明数据模型
  // 病虫害内容展示，使用可展开组件
  List<Pest1> p = [];

  @override
  void initState() {
    super.initState();
    _resultId = widget.resultId;// 接收id值
    get();
  }

  // HTTP GET 请求
  Future<void> get() async {
    String url = 'http://app.sinoverse.cn:9090/api/cloud.jsp?t=bch_show&id='+_resultId;
    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // jsonDecode函数将JSON数据解码为一个Map对象
      Map<String, dynamic> jsonMap = json.decode(response.body.toString());
      setState(() {
        // _jsonData = response.body.toString();
        _jsonData = 'success';
        pest.name = jsonMap['list'][0]['name'];// 病虫害的名称
        pest.yname = jsonMap['list'][0]['yname'];// 病虫害的别名
        pest.description = jsonMap['list'][0]['description'];// 病虫害的描述
        pest.cycle = jsonMap['list'][0]['cycle'];// 病虫害的发病周期
        pest.style = jsonMap['list'][0]['style'];// 病虫害的特点
        String thumbs = jsonMap['list'][0]['thumbs'].trim();// 病虫害的图片
        // 由于返回的图片是一个字符串，所以需要转为列表
        pest.images = thumbs.split(',');
        pest.images.removeLast();// 删除列表最后的空元素
        // for (var image in pest.images) {
        //   print(image);
        // }
        pest.way = jsonMap['list'][0]['way'];// 病虫害的防治方法
        // 可展开组件的列表
        p = [
          Pest1(title: '描述', detail: pest.description),
          Pest1(title: '发病周期', detail: pest.cycle),
          Pest1(title: '防治方法', detail: pest.way),
          Pest1(title: '特点', detail: pest.style),
        ];
      });
    } else {
      setState(() {
        _jsonData = 'Failed to load data';
      });
      // print('Request failed with status: ${response.statusCode}.');
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  // 自定义的一个可展开的组件
  Widget ExpandableItem(Pest1 pest){
    return //可展开组件
      ExpansionPanelList(
        // expansionCallback: , //点击时的回调，会返回对应点击的index和当前isExpanded的值
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            pest.isExpand = !pest.isExpand;
          });
          },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(pest.title),
              );
            },
            body: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(pest.detail,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            canTapOnHeader: true,
            isExpanded: pest.isExpand,
          ),
        ],
      );
  }
  // ExpansionPanel PestItem(String title, String pest){
  //   return ExpansionPanel(
  //     headerBuilder: (BuildContext context, bool isExpanded) {
  //       return ListTile(
  //         title: Text(title),
  //       );
  //     },
  //     body: Container(
  //       padding: EdgeInsets.all(10.0),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.green),
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       child: Text(pest,
  //         style: TextStyle(
  //           fontSize: 20,
  //         ),
  //       ),
  //     ),
  //     canTapOnHeader: true,
  //     isExpanded: _isExpand,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("预测结果"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomCameraPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),//允许滚动到达边缘时弹回
        child: Column(
          children: [
            //图片展示部分
            Container(
              height: 300,
              child: PageView.builder(
                //参数[index]是当前滑动到的图片角标索引 从0开始
                onPageChanged: (index) {
                  //滑动时，对应切换选择高亮的标签
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemCount: pest.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "http://app.sinoverse.cn:9090/api/${pest.images[index]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            //图片导航
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < pest.images.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                      i == _currentPageIndex ? Colors.blue : Colors.grey,
                    ),
                  ),
              ],
            ),
            Text(pest.name,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("别名："+pest.yname,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10),
            //特征描述部分
            //输出可展开组件列表
            Column(
              children: p.map((pest) => ExpandableItem(pest)).toList(),
            ),
          ],
        ),
      ),
    );
  }

}

// 构建数据模型，定义一个病虫害类，其属性包含各种特征描述
class Pest {
  String name = '';// 病虫害的名称
  String yname = '';// 病虫害的别名
  String description = '';// 病虫害的描述
  String cycle = '';// 病虫害的发病周期
  String style = '';// 病虫害的特点
  List<String> images = [''];// 病虫害的图片
  String way = '';// 病虫害的防治方法
  // List<String> images = thumbs.split(',');

  // Pest({
  //   required this.name,
  //   required this.yname,
  //   required this.description,
  //   required this.cycle,
  //   required this.style,
  //   required this.images,
  //   required this.way
  // });
}

// 病虫害的特征，用于一个可展开的组件
class Pest1 {
  late String title;// 特征名称
  late String detail;// 特征描述
  bool isExpand = false;// 展开状态

  Pest1({required this.title, required this.detail});
}