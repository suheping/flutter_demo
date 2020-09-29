import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/provider/file_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:orientation/orientation.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

class SignDemoPage extends StatefulWidget {
  SignDemoPage({Key key}) : super(key: key);

  @override
  _SignDemoPageState createState() => _SignDemoPageState();
}

class _SignDemoPageState extends State<SignDemoPage> {
  SignatureController _controller = SignatureController(
    // 画笔颜色
    penColor: Colors.red,
    // 画笔宽度
    penStrokeWidth: 5,
    // 最终图片的背景色
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    // 进入页面，强制转为横屏
    OrientationPlugin.forceOrientation(DeviceOrientation.landscapeLeft);
  }

  @override
  void dispose() {
    super.dispose();
    // 离开页面，强制转为竖屏
    OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手写签名'),
        actions: [
          InkWell(
            onTap: () async {
              // 手写完成，去保存
              await saveImg(context);
            },
            child: Container(
              width: 60,
              alignment: Alignment.center,
              child: Text(
                '确定',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _controller.clear();
            },
            child: Container(
              width: 60,
              alignment: Alignment.center,
              child: Text(
                '清空',
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Signature(
          controller: _controller,
          // 画布背景色
          backgroundColor: Colors.white,
          // 画布的宽度，取整的屏幕的宽度
          width: MediaQuery.of(context).size.width,
          // 画布的高度，取整个屏幕的高度
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }

  // 保存手写签名
  saveImg(BuildContext context) async {
    if (_controller.isNotEmpty) {
      // 转为bytes
      var data = await _controller.toPngBytes();

      // // 跳转页面展示该图片
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (BuildContext context) {
      //   return Scaffold(
      //     appBar: AppBar(),
      //     body: Center(
      //       child: Container(
      //         color: Colors.grey,
      //         child: Image.memory(data),
      //       ),
      //     ),
      //   );
      // }));

      // 保存图片到本地
      var result = await ImageGallerySaver.saveImage(data, name: 'sign');
      // 先把filePath置为空
      Provider.of<FileProvider>(context, listen: false).setFilePath('');
      if (result != '') {
        // 保存成功返回的是uri： file:///storage/emulated/0/flutter_demo/sign.jpg
        // 需要转为path
        String fileUri = result;
        Provider.of<FileProvider>(context, listen: false)
            .setFilePath(path.fromUri(fileUri));
        Fluttertoast.showToast(msg: '保存成功', backgroundColor: Colors.grey);
        setState(() {
          OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
        });
        Application.router.navigateTo(context, '/home', clearStack: true);
      } else {
        Fluttertoast.showToast(msg: '保存失败', backgroundColor: Colors.grey);
      }
    }
  }
}
