import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/sdf_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:provider/provider.dart';

class SetGesturePage extends StatefulWidget {
  SetGesturePage({Key key}) : super(key: key);

  @override
  _SetGesturePageState createState() => _SetGesturePageState();
}

class _SetGesturePageState extends State<SetGesturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请设置手势密码'),
        leading: Container(),
      ),
      body: Center(
        child: GestureView(
          size: 300,
          immediatelyClear: true,
          onPanUp: (List<int> items) async {
            if (items.length > 3) {
              await Provider.of<SDFProvider>(context, listen: false)
                  .setGestureCode(items);
              Fluttertoast.showToast(
                  msg: '手势密码设置成功', backgroundColor: Colors.grey);
              Application.router.pop(context);
            } else {
              Fluttertoast.showToast(
                  msg: '手势密码过于简单，请重新绘制！', backgroundColor: Colors.grey);
            }
          },
        ),
      ),
    );
  }
}
