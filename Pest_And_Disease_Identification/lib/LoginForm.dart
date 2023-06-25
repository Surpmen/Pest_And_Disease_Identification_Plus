import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomNavigation.dart';
import 'LogoPage.dart';
import 'RegisterForm.dart';
import 'camera.dart';

// 定义一个表单部件,继承StatefulWidget
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

// 创建相应的状态类。此类保存与表单相关的数据。
class LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  // 创建一个全局键，用于唯一标识表单小组件并允许验证表单
  final _formKey = GlobalKey<FormState>();// GlobalKey 唯一标识了这个表单 Form

  var _isObscure = true;
  var _eyeColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    // 使用上面创建的_formKey构建表单小部件。
    return Scaffold(
      resizeToAvoidBottomInset: false,//输入框抵住键盘 内容不随键盘滚动,防止屏幕溢出
      appBar: AppBar(
        title: Text('登录'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogoPage()),
            );
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  // color: Colors.grey,
                  child: ClipRect(
                    child: Image.asset('images/logo.png',fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),//左右边缘：20像素,上下边缘：50像素
              child: TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person), //输入框左边
                  labelText: '账号',
                  labelStyle: TextStyle(
                    fontSize: 16, // 设置标签文字大小为16
                    fontWeight: FontWeight.bold, // 设置标签文字为粗体
                  ),
                  hintText: '请输入账号',
                ),
                keyboardType: TextInputType.name,//输入的类型
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入账号';
                  }
                  return null;
                },
                // onSaved: (v) => _email = v!,//当表单校验通过后执行一些操作
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,//是否是密码
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '密码',
                  labelStyle: TextStyle(
                    fontSize: 16, // 设置标签文字大小为16
                    fontWeight: FontWeight.bold, // 设置标签文字为粗体
                  ),
                  hintText: '请输入密码',
                  prefixIcon: Icon(Icons.lock), //输入框左边
                  suffixIcon: IconButton(//输入框右边
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _eyeColor,
                    ),
                    onPressed: () {
                      // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
                      setState(() {
                        _isObscure = !_isObscure;
                        _eyeColor = (_isObscure ? Colors.grey : Colors.green);
                      });
                    },
                    // onSaved: (v) => _email = v!,//当表单校验通过后执行一些操作
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,//输入的类型
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("忘记密码",
                style: TextStyle(color: Colors.blue[400]),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    // 设置圆角
                    shape: MaterialStateProperty.all(
                        StadiumBorder(side: BorderSide(style: BorderStyle.none))),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 22,)),//字体大小
                    // fixedSize: MaterialStateProperty.all(Size(50, 20)),//按钮大小,受minimumSize限制
                    minimumSize: MaterialStateProperty.all(Size(300, 60)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),//字体颜色
                    backgroundColor: MaterialStateProperty.all(Colors.green),//按钮背景颜色
                  ),
                  onPressed: () {
                    // 如果表单有效，则验证返回 true，否则返回 false。
                    if (_formKey.currentState!.validate()) {
                      // 如果表单有效则执行_login进行登录
                      _login(context);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Processing Data')),
                      // );
                    }
                  },
                  child: const Text('登录'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    // 设置圆角
                    shape: MaterialStateProperty.all(
                        StadiumBorder(side: BorderSide(style: BorderStyle.none))),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 22,)),//字体大小
                    // fixedSize: MaterialStateProperty.all(Size(50, 20)),//按钮大小,受minimumSize限制
                    minimumSize: MaterialStateProperty.all(Size(300, 60)),
                    foregroundColor: MaterialStateProperty.all(Colors.green),//字体颜色
                    backgroundColor: MaterialStateProperty.all(Colors.white),//按钮背景颜色
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterForm()),
                    );
                  },
                  child: const Text('没有账号？去注册'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 定义两个文本编辑器控件
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
// 获取文本框中的账号和密码并进行身份验证
Future<void> _login(BuildContext context) async {
  //trim() 方法来去掉账号和密码两端的空格
  String phone = _phoneController.text.trim();
  String password = _passwordController.text.trim();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //加载登录动画
  SmartDialog.showLoading(
      animationType: SmartAnimationType.scale,
      builder: (_) => LoadingRotateImage()
  );
  await Future.delayed(Duration(seconds: 2));//延迟2秒
  SmartDialog.dismiss();
  //显示登录信息弹窗
  SmartDialog.showToast('',builder: (context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),//下边距
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      height: 50, width: 180,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        // 进行身份验证
        phone == prefs.getString('phone') && password == prefs.getString('password') ? "登录成功" : "账号或密码错误",
        style: TextStyle(color: Colors.white,fontSize: 20),),
    );
  });
  await Future.delayed(Duration(seconds: 2));//延迟2秒
  SmartDialog.dismiss();
  //账号和密码匹配则进行路由跳转
  if (phone == prefs.getString('phone') && password == prefs.getString('password')) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigation()),
    );
  }
}

//旋转的加载图标
class LoadingRotateImage extends StatefulWidget {
  @override
  _LoadingRotateImageState createState() => _LoadingRotateImageState();
}

class _LoadingRotateImageState extends State<LoadingRotateImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //RotationTransition Widget可以将其子Widget围绕中心点旋转一定角度。
        RotationTransition(
          //将AnimationController与RotationTransition Widget的turns属性进行绑定，以便将旋转动画应用于图像。
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: Image.asset(
            'images/加载.png',
            height: 80,
            width: 80,
            color: Colors.greenAccent,
          ),
        ),
        //Flutter的Positioned Widget来定位图标。让图标位于图像中心
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Icon(Icons.eco,color: Colors.green,size: 50,),
        ),
      ],
    );
  }

  //在dispose()方法中，我们释放了AnimationController以避免内存泄漏。
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}