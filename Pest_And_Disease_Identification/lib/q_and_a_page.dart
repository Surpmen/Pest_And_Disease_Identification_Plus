import 'package:flutter/material.dart';
//问答界面
String imagePath = 'assets/images/user_avatar.png';
String imagePath1 = 'assets/images/avatar.png';
class QAndAPage extends StatefulWidget {
  @override
  _QAndAPageState createState() => _QAndAPageState();
}

class _QAndAPageState extends State<QAndAPage> {
  TextEditingController _textEditingController = TextEditingController();
  List<ChatMessage> _chatMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('农业病虫防治'),
      ),
      body: Column(
        children: [
          _buildQuestionList(),
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (BuildContext context, int index) {
                return _chatMessages[index];
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }
//热门提问问题
  Widget _buildQuestionList() {
    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildQuestionCard('病虫害防治？', 'assets/images/question1.jpeg'),
          _buildQuestionCard('果树病虫害防治？', 'assets/images/question2.png'),
          _buildQuestionCard('蔬菜病虫害防治？', 'assets/images/question3.jpg'),
          _buildQuestionCard('正确农药使用？', 'assets/images/question.jpeg'),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionPage(title, imagePath),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 60.0,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: '请输入您遇到的农业相关问题',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          FloatingActionButton(
            onPressed: () {
              if (_textEditingController.text.isNotEmpty) {
                _addChatMessage(
                  ChatMessage(
                    message: _textEditingController.text,
                    isUser: true,
                  ),
                );
                _textEditingController.clear();
                _addChatMessage(
                  ChatMessage(
                    message: '神农之眼是基于深度学习的农作物病虫害防治系统，可以有高效解决农作物病虫害问题，如何该回答不能解决您的问题请转人工服务',
                    isUser: false,
                  ),
                );
              }
            },
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
  void _addChatMessage(ChatMessage message) {
    setState(() {
      _chatMessages.add(message);
    });
  }
}
class ChatMessage extends StatelessWidget {
  final String message;
  final bool isUser;

  ChatMessage({required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isUser
              ? Container(
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 20, // 指定头像半径，使其成为圆形
            ),
          )
              : SizedBox(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: isUser ? Colors.blueGrey : Colors.grey[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                message,
                style: TextStyle(color: isUser ? Colors.white : Colors.black),
              ),
            ),
          ),
          !isUser
              ? Container(
            margin: EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(imagePath1),
              radius: 20, // 指定头像半径，使其成为圆形
            ),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final String title;
  final String imagePath;

  QuestionPage(this.title, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 200.0,
            ),
            SizedBox(height: 16.0),
            _buildQuestionText('什么是病虫害？'),
            _buildAnswerText(
                '病虫害是指农作物生长发育过程中受到病菌、病毒、真菌、细菌、昆虫、螨类、线虫、鸟类、啮齿类等有害生物的危害，造成生长发育异常、减产甚至死亡的现象。'),
            _buildQuestionText('如何预防病虫害？'),
            _buildAnswerText(
                '预防病虫害的方法主要包括以下几个方面：\n1. 选择抗病虫害品种；\n2. 加强田间管理，保持良好的生态环境；\n3. 合理施肥，增强作物的抗病虫害能力；\n4. 使用生物农药和微生物制剂等绿色防治手段；\n5. 应用化学农药，但要按照使用规定使用，避免滥用。'),
            _buildQuestionText('什么是病虫害防治技术？'),
            _buildAnswerText(
                '病虫害防治技术是指针对特定病虫害采用一系列的防治措施，从而达到减轻或者消除病虫害危害的目的。主要包括生物防治、物理防治、化学防治、遗传防治等手段。'),
            _buildQuestionText('化学农药的使用有哪些注意事项？'),
            _buildAnswerText(
                '使用化学农药时需要注意以下几点：\n1. 选择适用的农药，并按照使用说明使用；\n2. 应在适宜的天气条件下施药；\n3. 防护措施要做好，避免直接接触农药；\n4. 避免滥用，防止残留；\n5. 按照规定的时间和方法进行药后处理。'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionText(String question) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        question,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAnswerText(String answer) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        answer,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}