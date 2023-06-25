import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'TestPage.dart';
import 'BottomNavigation.dart';
import 'LogoPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pest And Disease Identification',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LogoPage(),
      /*
      navigatorObservers 属性是一个列表，用于添加一个 NavigatorObserver，
      该观察器将在 Flutter 应用程序的导航器栈中推送和弹出路由时接收通知。
      这里使用的是 FlutterSmartDialog 中提供的 FlutterSmartDialog.observer，
      它是一个自定义的 NavigatorObserver，用于在弹出和关闭对话框时进行处理。
       */
      navigatorObservers: [FlutterSmartDialog.observer],
      // 在应用程序中构建顶层 Widget
      builder: FlutterSmartDialog.init(),
    );
  }
}

