import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/sdf_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class GesturePage extends StatefulWidget {
  GesturePage({Key key}) : super(key: key);

  @override
  _GesturePageState createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('手势密码')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () {
              Application.router.navigateTo(context, '/setGesture');
            },
            child: Text('设置手势密码'),
          ),
          Divider(),
          RaisedButton(
            onPressed: () {
              Application.router.navigateTo(context, '/verifyGesture');
            },
            child: Text('验证手势密码'),
          ),
          Divider(),
          // 是否开启手势密码登录
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('开启手势密码登录'),
              Provider.of<SDFProvider>(context).gestureLoginEnable
                  ? IconButton(
                      onPressed: () async {
                        await Provider.of<SDFProvider>(context, listen: false)
                            .setGestureLoginEnable(false);
                      },
                      icon: Image.asset('assets/images/switch_on.png'),
                    )
                  : IconButton(
                      onPressed: () async {
                        await Provider.of<SDFProvider>(context, listen: false)
                            .setGestureLoginEnable(true);
                        // 判断是否已设置手势密码，如果未设置跳转到设置页面
                        if (Provider.of<SDFProvider>(context, listen: false)
                                .gestureCode
                                .length <
                            4) {
                          Fluttertoast.showToast(
                              msg: '未设置手势密码，请设置', backgroundColor: Colors.grey);
                          Application.router.navigateTo(context, '/setGesture');
                        }
                      },
                      icon: Image.asset('assets/images/switch_off.png')),
            ],
          )
        ],
      ),
    );
  }
}
