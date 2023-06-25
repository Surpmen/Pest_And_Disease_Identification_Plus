import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginForm.dart';

//注册页面
class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}


class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _passwordsMatch = true;//密码是否匹配
  bool _isObscure1 = true;//是否显示密码
  bool _isObscure2 = true;//是否显示密码
  var _eyeColor1 = Colors.grey;//眼睛图标颜色
  var _eyeColor2 = Colors.grey;//眼睛图标颜色

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,//输入框抵住键盘 内容不随键盘滚动,防止屏幕溢出
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),//左右边缘：20像素,上下边缘：50像素
              child: TextFormField(
                decoration: InputDecoration(labelText: '手机号'),
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入手机号';
                  }
                  if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                    return '请输入正确的手机号格式（11位数字）';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),//左右边缘：20像素,上下边缘：50像素
              child: TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: '昵称（选填）'),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return '请输入昵称';
                //   }
                //   return null;
                // },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),//左右边缘：20像素,上下边缘：50像素
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: '密码',
                  suffixIcon: IconButton(//输入框右边
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _eyeColor1,
                    ),
                    onPressed: () {
                      // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
                      setState(() {
                        _isObscure1 = !_isObscure1;
                        _eyeColor1 = (_isObscure1 ? Colors.grey : Colors.green);
                      });
                    },
                  ),
                ),
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isObscure1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入密码';
                  }
                  // 定义正则表达式，匹配包含大小写字母和特殊符号的至少8个字符的密码
                  if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                    return '密码需要包含英文字母大小写、特殊符号且最少为8个字符';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),//左右边缘：20像素,上下边缘：50像素
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: '确认密码',
                  errorText: _passwordsMatch ? null : '两次密码输入不匹配',
                  suffixIcon: IconButton(//输入框右边
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _eyeColor2,
                    ),
                    onPressed: () {
                      // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
                      setState(() {
                        _isObscure2 = !_isObscure2;
                        _eyeColor2 = (_isObscure2 ? Colors.grey : Colors.green);
                      });
                    },
                  ),
                ),
                controller: _rePasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isObscure2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请确认密码';
                  }
                  return null;
                },
                //实时响应文本框内容的更改，判断两次密码输入是否相同
                onChanged: (value) {
                  if (value != _passwordController.text.trim()) {
                    setState(() {
                      _passwordsMatch = false;
                    });
                  } else {
                    setState(() {
                      _passwordsMatch = true;
                    });
                  }
                },
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
                    if (_formKey.currentState!.validate()) {
                      // TODO: Perform registration action
                      if(_passwordController.text == _rePasswordController.text){
                        _Register();
                      }
                    }
                  },
                  child: const Text('注册'),
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
                      MaterialPageRoute(builder: (context) => LoginForm()),
                    );
                  },
                  child: const Text('已有账号？去登录'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //校验两次密码是否相同
  void _checkPassword(){
    String _password = _passwordController.text.trim();
    String _rePassword = _rePasswordController.text.trim();
    if(_password == _rePassword){

    }
  }
  //注册方法
  void _Register() {
    String _phone=_phoneController.text.trim();
    String _name=_nameController.text.isNotEmpty || _nameController.text != ''
        ? _nameController.text.trim() : ("用户"+_phoneController.text.trim());
    String _password=_passwordController.text.trim();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("您的账号信息"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("手机号："+_phone),
              Text("昵称："+_name),
              Text("密码："+_password),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("确定"),
              onPressed: () {
                // 执行操作
                save(_phone, _name, _password);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginForm()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
//暂时用shared_preferences暂时存储注册的账户和密码
save(String phone, String name, String password) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('phone', phone);//存数据
  await prefs.setString('name', name);//存数据
  await prefs.setString('password', password);//存数据
}
