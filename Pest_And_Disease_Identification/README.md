# pest_and_disease_identification

## 项目文件目录介绍
```
├── android 
├── lib
│     ├── main.dart                   主启动类
│     ├── BottomNavigation.dart       底部导航栏部分
│     ├── camera.dart                 自定义相机页面
│     ├── Result.dart                 结果展示页面
│     ├── LoginForm.dart              登录页面
│     ├── RegisterForm.dart           注册页面
│     ├── LogoPage.dart               logo页面
│     ├── HomePage.dart               主页面（包含资讯和拍照识别按钮）
│     ├── my_page.dart                我的页面
│     ├── consult_page.dart           资讯页面
│     ├── q_and_a_page.dart           问答页面
│     ├── user_detail_page.dart       个人详细信息页面
│     ├── my_isolate_interface.dart   内包含使用自定义插件的接口
├── my_predict_plugin     # 封装有pytroch进行模型推理的插件
│     ├── android         # 安卓的原生代码，包括pytroch的java推理代码
│     ├── assets          # 资源文件夹，安卓原生代码所需要的资源文件夹，这里放模型pt文件
│     ├── example         # my_predict_plugin插件使用的简单flutter例子
│     ├── lib             # my_predict_plugin的flutter插件的method channel调用原生Android代码的dart封装
│     │    ├── my_predict_plugin.dart
│     │    ├── my_predict_plugin_method_channel.dart
│     │    └── my_predict_plugin_platform_interface.dart   
│     ├── pubspec.yaml    # my_predict_plugin插件所需要的配置文件
│     └── ...             # 其他文件  
└── ...                   # 其他文件  
```