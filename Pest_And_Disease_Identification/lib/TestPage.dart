// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'camera.dart';
// import 'q_and_a_page.dart';
// import 'my_page.dart';
// import 'consult_page.dart';
// import 'HomePage.dart';
//
// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController(initialPage: 0);
//
//   final List<Widget> _pages = [
//     HomePage(),
//     ConsultPage(),
//     QAndAPage(),
//     MyPage(),
//   ];
//
//   void _onTabTapped(int index) {
//     print(index);
//     if (index == 2) {
//       // 如果点击的是相机页面，跳转到相机页面
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => CustomCameraPage()),
//       );
//       return;
//     }
//
//     setState(() {
//       _currentIndex = index;
//       // 当前导航跳过 相机 子项，
//       _pageController.jumpToPage(index < 2 ? index : index-1);// 页面跳转
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           // 去掉相机页面后index值为0至3，而不是0至4
//           setState(() {
//             // _currentIndex = index;
//             // 当前导航跳过 相机 子项，
//             _currentIndex = index < 2 ? index : index+1;
//           });
//         },
//         // 将 CustomCameraPage() 替换为一个空的占位符
//         // children: [
//         //   // 将 _pages 数组中前两个元素（即 HomePage() 和 ConsultPage()）展开，用逗号连接起来作为新数组的前两个元素。
//         //   ..._pages.sublist(0, 2),
//         //   // 创建一个大小为零的空白组件，用于占位，即将 CustomCameraPage() 替换为一个空的占位符。
//         //   // SizedBox.shrink(),
//         //   // 将 _pages 数组中第三个元素（即 CustomCameraPage()）之后的所有元素展开，用逗号连接起来作为新数组的后面元素。
//         //   ..._pages.sublist(2),
//         // ],
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,//解决文字不显示问题,item大于三个的时候文字不显示。
//         //选中效果
//         selectedItemColor: Colors.green,
//         unselectedItemColor: Colors.black,
//
//         // 当前导航跳过 相机 子项，
//         // currentIndex: _currentIndex < 2 ? _currentIndex : _currentIndex+1,
//         currentIndex: _currentIndex,
//         onTap: _onTabTapped,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '首页',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.article),
//             label: '资讯',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.camera),
//             label: '相机',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.question_answer),
//             label: '问答',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: '我的',
//           ),
//         ],
//       ),
//     );
//   }
// }