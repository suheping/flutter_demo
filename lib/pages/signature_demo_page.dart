import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/provider/file_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:orientation/orientation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:path/path.dart' show join;
import 'package:permission_handler/permission_handler.dart';

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
    // var permission =
    //     PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    // print("permission status is " + permission.toString());
    // PermissionHandler().requestPermissions(<PermissionGroup>[
    //   PermissionGroup.storage, // 在这里添加需要的权限
    // ]);
    // var permission = Permission.storage.status;
    // Permission.storage.request();
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

      var imagePath = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      try {
        Provider.of<FileProvider>(context, listen: false).setFilePath('');
        await File(imagePath).writeAsBytes(data);
        Provider.of<FileProvider>(context, listen: false)
            .setFilePath(imagePath);
        Fluttertoast.showToast(msg: '保存成功', backgroundColor: Colors.grey);
        Application.router.navigateTo(context, '/home', clearStack: true);
      } catch (e) {
        Fluttertoast.showToast(msg: '保存失败', backgroundColor: Colors.grey);
      }
    }
  }
}
