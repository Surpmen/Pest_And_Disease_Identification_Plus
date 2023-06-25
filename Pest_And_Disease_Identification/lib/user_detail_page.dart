import 'package:flutter/material.dart';
//用户详细信息界面
class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _userName, _account, _address, _phone, _email, _occupation;
  late int _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('用户详细信息')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: '用户名'),
              onSaved: (value) => _userName = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '账号'),
              onSaved: (value) => _account = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '地址'),
              onSaved: (value) => _address = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '电话'),
              onSaved: (value) => _phone = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '邮箱'),
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '职业'),
              onSaved: (value) => _occupation = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '年龄'),
              onSaved: (value) => _age = int.parse(value!),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
  void _submitForm() {
    _formKey.currentState!.save();
    // 保存数据的逻辑
  }
}