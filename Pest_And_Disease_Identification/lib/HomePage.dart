import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'camera.dart';

//首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [
    Post("农作物知识百科", "有关农作物的知识科普", "马金来", "2023-05-09", "images/image1.jpg"),
    Post("神农之眼", "一款由云南大学师生研发的病虫害防治系统", "谢时田", "2023-05-08", "images/image2.png"),
    Post("旱地水稻技术", "云南农业大学研发的旱地水稻新技术", "坤坤", "2023-05-07", "images/image3.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        centerTitle: true,
        title: Text('农作物病虫害防治App'),
      ),
      //滚动翻转页面功能
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 拍照识别部分
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      // 设置圆角
                      shape: MaterialStateProperty.all(
                          StadiumBorder(side: BorderSide(style: BorderStyle.none))),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 22,)),//字体大小
                      // fixedSize: MaterialStateProperty.all(Size(50, 20)),//按钮大小,受minimumSize限制
                      minimumSize: MaterialStateProperty.all(Size(150, 150)),
                      foregroundColor: MaterialStateProperty.all(Colors.green),//字体颜色
                      backgroundColor: MaterialStateProperty.all(Colors.white),//按钮背景颜色
                    ),
                    onPressed: () {
                      Navigator.push(//点击摄像机按钮后跳转到照片上传界面
                        context,
                        MaterialPageRoute(builder: (context) => CustomCameraPage()),
                      );
                    },
                    child: const Icon(Icons.camera_alt,
                      color: Colors.green,
                      size: 100.0,
                    ),
                  ),
                  Text(
                    '识虫断病',
                    style: TextStyle(color: Colors.green, fontSize: 24),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              child: Image.asset("images/专家解答.png"),
            ),
            Container(// 精选问答部分
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              child: Text("精选资讯",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: posts.map(
                        (posts) => Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.asset(posts.imagePath),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(posts.title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5.0),
                                        Text(posts.description, style: TextStyle(fontSize: 14.0)),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(posts.author + " | " + posts.date, style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.thumb_up),
                                                  onPressed: () {},
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.comment),
                                                  onPressed: () {},
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.bookmark),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),// 设置子部件之间的垂直距离为8.0
                          ],
                        )
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Post {// 定义一个帖子类别类
  final String title;//文章标题
  final String description;//详细描述
  final String author;//对应作者
  final String date;//文章日期
  final String imagePath;//图片路径
  Post(this.title, this.description, this.author, this.date, this.imagePath);
}