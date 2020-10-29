import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/sdf_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class FingerLoginPage extends StatefulWidget {
  FingerLoginPage({Key key}) : super(key: key);

  @override
  _FingerLoginPageState createState() => _FingerLoginPageState();
}

class _FingerLoginPageState extends State<FingerLoginPage> {
  var localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // 获取是否开始了指纹登录
        future: Provider.of<SDFProvider>(context, listen: false)
            .getFingerLoginEnable(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (Provider.of<SDFProvider>(context, listen: false)
                .fingerLoginEnable) {
              return Center(
                child: FlatButton(
                  onPressed: () async {
                    //下面是汉化
                    const andStrings = const AndroidAuthMessages(
                      cancelButton: '取消',
                      goToSettingsButton: '去设置',
                      fingerprintNotRecognized: '指纹识别失败',
                      goToSettingsDescription: '请设置指纹.',
                      fingerprintHint: '指纹',
                      fingerprintSuccess: '指纹识别成功',
                      signInTitle: '指纹验证',
                      fingerprintRequiredTitle: '请先录入指纹!',
                    );
                    try {
                      bool didAuthenticate =
                          await localAuth.authenticateWithBiometrics(
                              localizedReason: '扫描指纹进行身份识别',
                              useErrorDialogs: false,
                              stickyAuth: true,
                              androidAuthStrings: andStrings);
                      print(didAuthenticate);
                      if (didAuthenticate) {
                        Application.router
                            .navigateTo(context, '/home', replace: true);
                      }
                    } catch (e) {
                      // 不支持指纹识别
                      Fluttertoast.showToast(
                          msg: '$e', backgroundColor: Colors.grey);
                      Application.router
                          .navigateTo(context, '/home', replace: true);
                    }
                  },
                  child: Text('指纹登录'),
                ),
              );
            } else {
              // Application.router.navigateTo(context, '/home', replace: true);
              return Center(
                child: FlatButton(
                  onPressed: () {
                    Application.router
                        .navigateTo(context, '/home', replace: true);
                  },
                  child: Text('未开启指纹登录，点击直接进入home页'),
                ),
              );
            }
          } else {
            return Center(
              child: Text('加载中。。。'),
            );
          }
        },
      ),
    );
  }
}
