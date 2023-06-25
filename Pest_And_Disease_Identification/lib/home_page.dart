// // 导入所需的库
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// //首页
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   File? _image;
//   final picker = ImagePicker();
//
//   // 拍照或从相册选择照片
//   Future getImage({required bool fromCamera}) async {
//     final pickedFile = await picker.getImage(
//         source: fromCamera ? ImageSource.camera : ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//         // 在这里调用图片识别API，获取结果并显示在文本框中
//       } else {
//         print('未选择图片');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('农作物病虫害防治App'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // 显示上传图片部分
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.4,
//               color: Colors.grey[200],
//               child: _image == null
//                   ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Icon(
//                     Icons.camera_alt,
//                     color: Colors.green,
//                     size: 100.0,
//                   ),
//                   Text(
//                     '识虫断病',
//                     style: TextStyle(color: Colors.green, fontSize: 24),
//                   ),
//                 ],
//               )
//                   : Image.file(_image!),
//             ),
//             // 上传图片按钮
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton.icon(
//                   onPressed: () => getImage(fromCamera: true),
//                   icon: Icon(Icons.camera_alt, color: Colors.green),
//                   label: const Text(
//                     '拍照上传',
//                     style: TextStyle(color: Colors.green),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 TextButton.icon(
//                   onPressed: () => getImage(fromCamera: false),
//                   icon: Icon(Icons.photo, color: Colors.green),
//                   label: const Text(
//                     '相册上传',
//                     style: TextStyle(color: Colors.green),
//                   ),
//                 ),
//               ],
//             ),
//             // 识别结果部分
//             Container(
//               padding: EdgeInsets.all(15.0),
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     '识别结果',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       color: Colors.green,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     padding: EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.green),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: const Text(
//                       '基于深度学习的农作物病虫害防治系统，可以有效地解决传统农作物病虫害防治方法存在的问题，实现智能化、绿色、高效的防治效果。该系统的设计和实现需要考虑多个方面，包括数据采集、图像处理和分析、模型训练、智能化防治系统等。未来，随着深度学习算法的不断发展和应用，农作物病虫害防治系统将会得到更广泛的应用。', // 这里显示实际的识别结果
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }