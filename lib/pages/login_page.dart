import 'package:flutter/material.dart';
import 'package:flutter_demo/provider/sdf_provider.dart';
import 'package:flutter_demo/routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _fingerLogin(),
          _gescodeLogin(),
        ],
      ),
    ));
  }

  Widget _fingerLogin() {
    return Provider.of<SDFProvider>(context, listen: false).fingerLoginEnable
        ? FlatButton(
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
                  Application.router.navigateTo(context, '/home');
                }
              } catch (e) {
                // 不支持指纹识别
                Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.grey);
                // Application.router.navigateTo(context, '/home');
              }
            },
            child: Text('指纹登录'),
          )
        : Container();
  }

  Widget _gescodeLogin() {
    return Provider.of<SDFProvider>(context, listen: false).gestureLoginEnable
        ? FlatButton(
            onPressed: () {
              Application.router.navigateTo(context, '/verifyGesture');
            },
            child: Text('手势密码登录'),
          )
        : Container();
  }
}
