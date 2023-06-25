import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LoginForm.dart';
import 'RegisterForm.dart';

//logo页面
class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  LogoPageState createState() => LogoPageState();
}
class LogoPageState extends State<LogoPage> {

  @override
  Widget build(BuildContext context) {
    // 显示通知栏
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(""),
      // ),
      body: Container(
        decoration: BoxDecoration(
          // 使用图片作为背景装饰
          image: DecorationImage(
            image: AssetImage('images/软件背景图.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/logo.png',height: 600,width: 500,),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(child: Text("登录"),
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 22,)),//字体大小
                      // fixedSize: MaterialStateProperty.all(Size(50, 20)),//按钮大小,受minimumSize限制
                      minimumSize: MaterialStateProperty.all(Size(120, 60)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),//字体颜色
                      backgroundColor: MaterialStateProperty.all(Colors.green),//按钮背景颜色
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginForm()),
                      );
                    },
                  ),
                  ElevatedButton(child: Text("注册"),
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 22,)),//字体大小
                      fixedSize: MaterialStateProperty.all(Size(50, 20)),//按钮大小
                      minimumSize: MaterialStateProperty.all(Size(120, 60)),
                      foregroundColor: MaterialStateProperty.all(Colors.green),//字体颜色
                      backgroundColor: MaterialStateProperty.all(Colors.white),//按钮背景颜色
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterForm(),
                        ),
                      );
                    },
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }

}