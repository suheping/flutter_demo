import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/camera_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({Key key}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _controller;
  Future _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    String path = Provider.of<CameraProvider>(context, listen: false).videoPath;
    print(path);
    _controller = VideoPlayerController.file(File(path));
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('播放视频'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.connectionState);
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
