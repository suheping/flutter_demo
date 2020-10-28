import 'dart:convert' as convert;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/counter_provider.dart';
import 'package:flutter_demo/provider/file_provider.dart';
import 'package:flutter_demo/provider/refresh_provider.dart';
import 'package:flutter_demo/provider/sdf_provider.dart';
import 'package:flutter_demo/provider/camera_provider.dart';
import 'package:flutter_demo/provider/web_view_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:flutter_demo/routers/routers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter工具集合'),
      ),
      body: Container(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                // 路由跳转
                Application.router.navigateTo(context, '/provider');
              },
              child: Text(
                  // provider状态管理get方法
                  'provider状态管理(${Provider.of<CounterProvider>(context).count})'),
            ),
            Divider(),
            // 手写签名，保存到本地
            // 显示本地图片
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () {
                    Application.router.navigateTo(context, '/sign');
                  },
                  child: Text('手写签名'),
                ),
                RaisedButton(
                  onPressed: () async {
                    String filePath =
                        Provider.of<FileProvider>(context, listen: false)
                            .filePath;
                    if (filePath != '') {
                      // 展示本地图片
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(),
                          body: Center(
                            child: Container(
                              color: Colors.grey,
                              child: Image.file(File(filePath)),
                            ),
                          ),
                        );
                      }));
                    } else {
                      // 吐司提示
                      Fluttertoast.showToast(
                          msg: '暂无签名图片', backgroundColor: Colors.grey);
                    }
                  },
                  child: Text('显示手写签名'),
                )
              ],
            ),
            Divider(),
            RaisedButton(
              onPressed: () async {
                // 先获取持久化中的数据
                await Provider.of<SDFProvider>(context, listen: false)
                    .getName();
                // 跳转到持久化demo页面
                Application.router.navigateTo(context, '/sdf');
              },
              child: Text('持久化'),
            ),
            Divider(),
            RaisedButton(
              onPressed: () {
                Provider.of<RefreshProvider>(context, listen: false).getData();
                Application.router.navigateTo(context, '/refresh');
              },
              child: Text('easyRefresh演示'),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () async {
                    final cameras = await availableCameras();
                    print(cameras);
                    final firstCamera = cameras.first;
                    Provider.of<CameraProvider>(context, listen: false)
                        .setCameraDesc(firstCamera);
                    Provider.of<CameraProvider>(context, listen: false)
                        .setIsRecording(false);
                    Application.router.navigateTo(context, '/camera');
                  },
                  child: Text('相机'),
                ),
                RaisedButton(
                  onPressed: () {
                    if (Provider.of<CameraProvider>(context, listen: false)
                            .videoPath ==
                        '') {
                      Fluttertoast.showToast(
                          msg: '暂无视频，请录制', backgroundColor: Colors.grey);
                    } else {
                      Application.router.navigateTo(context, '/video');
                    }
                  },
                  child: Text('播放视频1'),
                ),
                RaisedButton(
                  onPressed: () {
                    if (Provider.of<CameraProvider>(context, listen: false)
                            .videoPath ==
                        '') {
                      Fluttertoast.showToast(
                          msg: '暂无视频，请录制', backgroundColor: Colors.grey);
                    } else {
                      var file = File(
                          Provider.of<CameraProvider>(context, listen: false)
                              .videoPath);
                      print(file.uri);
                      Application.router.navigateTo(context, '/chewie');
                    }
                  },
                  child: Text('播放视频2'),
                )
              ],
            ),

            Divider(),
            RaisedButton(
              onPressed: () {
                Application.router.navigateTo(context, '/drag');
              },
              child: Text('拖拽demo'),
            ),
            Divider(),
            RaisedButton(
              onPressed: () {
                String _params =
                    'contract_id=07ed9b35eb2482768465c75a23a2e0aa&user_name=山东服装科技测试有限公司&credit_code=923723771111111114&preview=';
                Provider.of<WebViewProvider>(context, listen: false)
                    .setParam(_params);
                Application.router.navigateTo(context, '/web');
              },
              child: Text('内嵌H5'),
            ),
            Divider(),
            RaisedButton(
              onPressed: () {
                Application.router.navigateTo(context, '/localAuth');
              },
              child: Text('生物识别'),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
