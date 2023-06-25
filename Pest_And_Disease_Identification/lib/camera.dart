import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'BottomNavigation.dart';
import 'LoginForm.dart';
import 'Result.dart';
import 'my_isolate_interface.dart';
//拍照识别页面
class CustomCameraPage extends StatefulWidget {
  const CustomCameraPage({super.key});
  @override
  _CustomCameraPageState createState() => _CustomCameraPageState();
}
///**注意**： File 图片文件，初始时不能为空值，否则报错，因此将其初始化为一个固定文件，后期需要优化处理
File _imageFile=File("");// 图片文件
String _imagepath="";// 存储图片路径
String _resultId="";

class _CustomCameraPageState extends State<CustomCameraPage> {
  CameraController? _cameraController;  // 初始化控制器
  List<CameraDescription>? _cameras;    // 可用的相机列表
  int _selectedCameraIndex = 0;         // 相机列表下标
  bool _isFlashOn = false;              // 闪光灯控制

  @override
  void initState() {
    super.initState();
    // 隐藏通知栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _initCamera();  // 初始化相机
  }

  // 初始化CameraController，以使用相机预览和拍照
  Future<void> _initCamera() async {
    // 获取访问限权
    await Permission.camera.request();
    // 获取可用的相机列表
    _cameras = await availableCameras();
    // 创建CameraController，ResolutionPreset.high为相机分辨率
    _cameraController = CameraController(_cameras![_selectedCameraIndex], ResolutionPreset.high);
    // 初始化相机控制器
    _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});// 更新界面
    });
  }

  @override
  void dispose() {
    // 销毁控制器，释放相机资源
    _cameraController?.dispose();
    // 显示通知栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 确保相机已经初始化后才去展示 CameraPreview，否则显示加载页面
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            //退出当前页面并进入新的页面
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => BottomNavigation(),),
            // );
          },
        ),
        backgroundColor: Colors.black,
        actions: [
          // 闪光灯控制按钮
          IconButton(
            icon: _isFlashOn ? Icon(Icons.flash_on, color: Colors.white, size: 30) : Icon(Icons.flash_off, color: Colors.white, size: 30),
            onPressed: _toggleFlash,
          ),
        ],
      ),
      body: Container(
        // 设置背景颜色
        color: Colors.black,
        // 设置全屏显示
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // 相机展示部分
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.75,
                    child: CameraPreview(_cameraController!), // 展示相机预览帧流
                ),
                // 中间的虚线框
                _buildTransparentBox(),
              ],
            ),
            _buildControlBar(), // 底部相机功能部分
          ],
        ),
      ),
    );
  }

  Widget _buildTransparentBox() {
    return Center(
      // 外层虚线框
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
        ),
        // 虚线框中的内容
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
              child: Text(
                "请调整好拍照距离将病虫害关键部位处于识别框",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 底部相机功能部分
  Widget _buildControlBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.photo_library, color: Colors.grey, size: 50),
              onPressed: _pickImageFromGallery,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt, color: Colors.grey, size: 50),
              onPressed: _takePicture,
            ),
            IconButton(
              icon: Icon(Icons.switch_camera, color: Colors.grey, size: 50),
              onPressed: _switchCamera,
            ),
          ],
        ),
      ),
    );
  }

  // 拍照功能
  void _takePicture() async {
    try {
      final file = await _cameraController?.takePicture();
      // print('Picture saved to $file');
      print(file?.path);
      if (file != null) {
        _imageFile = File(file.path);
        print(_imageFile.path);
        _imagepath=_imageFile.path.toString();
        //退出当前页面并进入新的页面
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewScreen(imagePath: _imagepath,),
          ),
        );
      } else {
        print('没有拍照成功');
      }
    } catch (e) {
      print(e);
    }
  }

  // 从相册中选中图片的功能
  void _pickImageFromGallery() async {
    final picker = ImagePicker(); // 实例化
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); //设置图片文件的来源为相册
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      print(_imageFile.path);
      _imagepath=_imageFile.path.toString();
      //退出当前页面并进入新的页面
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(imagePath: _imagepath,),
        ),
      );
    } else {
      print('没有选择图片');
    }
  }

  // 闪光灯控制功能
  void _toggleFlash() {
    if (_cameraController!.value.flashMode == FlashMode.off) {
      _cameraController!.setFlashMode(FlashMode.torch);
    } else {
      _cameraController!.setFlashMode(FlashMode.off);
    }
    // 更新闪光灯状态
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  // 旋转摄像头功能
  void _switchCamera() {
    // print('相机列表长度');
    // print(_cameras!.length);// 2
    _selectedCameraIndex = _selectedCameraIndex < _cameras!.length - 1 ? _selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = _cameras![_selectedCameraIndex];
    _cameraController = CameraController(selectedCamera, ResolutionPreset.high);

    _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }
}
Future<String> _predictImage() async {
  if (_imageFile != null) {
    String resultId="";
    /********  该处是调用推理函数runInference才UI进程中获取结果   ******/
    resultId=await runInference(_imagepath);
    /********  *****************************************   ******/
    return resultId;
  } else {
    throw Exception('No image selected.');
    return "No image selected.";
  }
}
class PreviewScreen extends StatelessWidget {
  final String imagePath;

  PreviewScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomCameraPage()),
            );
          },
        ),
        title: Text('上传图片'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              String result = await _predictImage();
              print(result);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Result(resultId: result,),
                  ),
                );
              },
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}