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
  double _initVolume;
  @override
  void initState() {
    super.initState();
    _initVolume = 0.5;
    String path = Provider.of<CameraProvider>(context, listen: false).videoPath;
    _controller = VideoPlayerController.file(File(path));
    _controller.setLooping(true);
    _controller.setVolume(_initVolume);
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
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        child: Text('+'),
                        onPressed: () {
                          setState(() {
                            _initVolume += 0.05;
                            _controller.setVolume(_initVolume);
                          });
                        },
                      ),
                      RaisedButton(
                        child: Text('-'),
                        onPressed: () {
                          setState(() {
                            _initVolume -= 0.05;
                            _controller.setVolume(_initVolume);
                          });
                        },
                      ),
                      RaisedButton(
                        child: Icon(_controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
