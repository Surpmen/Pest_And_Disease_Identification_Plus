import 'package:flutter/material.dart';
import 'camera.dart';
import 'q_and_a_page.dart';
import 'my_page.dart';
import 'consult_page.dart';
import 'HomePage.dart';

//底部导航栏
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}
class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;// 当前子项索引
  final PageController _pageController = PageController(initialPage: 0);// 配合PageView使用
  //配置路由
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),         // app主页
    ConsultPage(),      // 资讯页面
    CustomCameraPage(), // 相机页面
    QAndAPage(),        // 问答页面
    MyPage(),           // 我的页面
  ];

  void _onTabTapped(int index) {
    print(index);
    if (index == 2) {
      // 如果点击的是相机页面，跳转到相机页面
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CustomCameraPage()),
      );
      return;
    }

    setState(() {
      _currentIndex = index;
      // 因为_widgetOptions个数为4，底部导航子项为5，所以在index大于2时值要减1
      _pageController.jumpToPage(index < 2 ? index : index-1);// 页面跳转
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 根据Index展示页面
      // body: _widgetOptions.elementAt(Index),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          // 去掉相机页面后index值为0至3，而不是0至4
          setState(() {
            // _currentIndex = index;
            // 当前导航跳过 相机 子项，
            _currentIndex = index < 2 ? index : index+1;
          });
        },
        // 将 CustomCameraPage() 替换为一个空的占位符
        // children: [
        //   // 将 _pages 数组中前两个元素（即 HomePage() 和 ConsultPage()）展开，用逗号连接起来作为新数组的前两个元素。
        //   ..._pages.sublist(0, 2),
        //   // 创建一个大小为零的空白组件，用于占位，即将 CustomCameraPage() 替换为一个空的占位符。
        //   // SizedBox.shrink(),
        //   // 将 _pages 数组中第三个元素（即 CustomCameraPage()）之后的所有元素展开，用逗号连接起来作为新数组的后面元素。
        //   ..._pages.sublist(2),
        // ],
        children: _widgetOptions,
      ),
      // 底部导航栏部分
      bottomNavigationBar: BottomNavigationBar(
        //查看源码其实发现，BottomNavigationBarType type, 默认情况下，item小于三个 type = fixed，大于三个type = shifting;文字在shifting模式下默认不显示，fixed模式下默认显示
        type: BottomNavigationBarType.fixed,//解决文字不显示问题,item大于三个的时候文字不显示。
        backgroundColor: Colors.grey[300], // 底部导航栏的整体背景
        //选中效果
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        // 设置文字大小
        selectedFontSize: 18,
        unselectedFontSize: 18,
        currentIndex: _currentIndex,//当前页面索引
        onTap: _onTabTapped,//onTap为点击事件，当用户点击底部导航栏项目时，onTap回调函数会更新所选的索引
        items: [//导航子项集
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),        // 未选中时展示的图标
            activeIcon: Icon(Icons.home_outlined),  // 选中时展示的图标
            // activeIcon: Image.asset('images/tabbar_chat_hl.png', height: 32, width: 32,),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat_outlined),
            label: '资讯',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera_outlined),
            label: '识别',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_outlined),
            activeIcon: Icon(Icons.question_answer_outlined),
            label: '问答',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_outline_rounded),
            label: '我的',
          ),
        ],
      ),
    );
  }

}