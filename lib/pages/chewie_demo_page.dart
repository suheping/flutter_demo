import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_demo/provider/camera_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ChewieDemoPage extends StatefulWidget {
  ChewieDemoPage({Key key}) : super(key: key);

  @override
  _ChewieDemoPageState createState() => _ChewieDemoPageState();
}

class _ChewieDemoPageState extends State<ChewieDemoPage> {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    String path = Provider.of<CameraProvider>(context, listen: false).videoPath;
    _controller = VideoPlayerController.file(File(path));
    print('-------------------');
    print(File(path));
    print('-------------------');
    _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: _controller.value.aspectRatio, //视频的宽高比，需要获取视频文件宽高比，动态设置
        autoPlay: true,
        looping: true,
        autoInitialize: true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('视频播放2'),
        ),
        body: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Chewie(
            controller: _chewieController,
          ),
        ));
  }
}
