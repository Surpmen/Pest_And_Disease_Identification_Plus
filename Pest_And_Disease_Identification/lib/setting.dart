import 'package:flutter/material.dart';
//设置界面
// 通知设置类
class NotificationSetting {
  bool isEnabled;
  TimeOfDay startTime;//开始时间
  TimeOfDay endTime;//结束时间
  NotificationSetting({
    this.isEnabled = false,
    this.startTime = const TimeOfDay(hour: 8, minute: 0),
    this.endTime = const TimeOfDay(hour: 20, minute: 0),
  });
}
// 声音设置类
class SoundSetting {
  bool isEnabled;
  double volume;

  SoundSetting({
    this.isEnabled = true,
    this.volume = 0.5,
  });
}
// 语言设置类
class LanguageSetting {
  String selectedLanguage;
  LanguageSetting({
    this.selectedLanguage = '中文',
  });
  // 可选语言列表
  List<String> get languages => ['中文', 'English', 'Español', 'Français'];
}
// 显示设置页面
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}
class _SettingPageState extends State<SettingPage> {
  // 初始化通知设置、声音设置和语言设置
  NotificationSetting notificationSetting = NotificationSetting();
  SoundSetting soundSetting = SoundSetting();
  LanguageSetting languageSetting = LanguageSetting();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的设置'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 通知设置
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('通知'),
                  subtitle: const Text('打开或关闭通知'),
                  trailing: Switch(
                    value: notificationSetting.isEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationSetting.isEnabled = value;
                      });
                    },
                  ),
                ),
                if (notificationSetting.isEnabled)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '通知时间',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('开始时间'),
                            GestureDetector(
                              child: Text(
                                notificationSetting.startTime.format(context),
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () async {
                                TimeOfDay? startTime = await showTimePicker(
                                  context: context,
                                  initialTime: notificationSetting.startTime,
                                );
                                setState(() {
                                  notificationSetting.startTime = startTime!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('结束时间'),
                            GestureDetector(
                              child: Text(
                                notificationSetting.endTime.format(context),
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () async {
                                TimeOfDay? endTime = await showTimePicker(
                                  context: context,
                                  initialTime: notificationSetting.endTime,
                                );
                                setState(() {
                                  notificationSetting.endTime = endTime!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // 声音设置
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.volume_up),
                  title: const Text('声音'),
                  subtitle: const Text('打开或关闭声音'),
                  trailing: Switch(
                    value: soundSetting.isEnabled,
                    onChanged: (value) {
                      setState(() {
                        soundSetting.isEnabled = value;
                      });
                    },
                  ),
                ),
                if (soundSetting.isEnabled)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '音量',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Slider(
                          value: soundSetting.volume,
                          onChanged: (value) {
                            setState(() {
                              soundSetting.volume = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // 语言设置
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('语言'),
                  subtitle: const Text('选择应用的语言'),
                  trailing: DropdownButton<String>(
                    value: languageSetting.selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        languageSetting.selectedLanguage = value!;
                      });
                    },
                    items: languageSetting.languages
                        .map<DropdownMenuItem<String>>((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // 清除缓存
          Card(
            child: ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('清除缓存'),
              subtitle: const Text('清除应用缓存'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // TODO: 实现清除缓存功能
              },
            ),
          ),
          const SizedBox(height: 16.0),
          // 关于我们
          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('关于我们'),
              subtitle: const Text('了解应用的相关信息'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // TODO: 打开关于我们页面
              },
            ),
          ),
        ],
      ),
    );
  }
}