import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthPage extends StatefulWidget {
  LocalAuthPage({Key key}) : super(key: key);

  @override
  _LocalAuthPageState createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends State<LocalAuthPage> {
  var localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('指纹识别demo'),
        ),
        body: Container(
          child: Column(
            children: [
              RaisedButton(
                onPressed: () async {
                  try {
                    bool canCheckBiometrics =
                        await localAuth.canCheckBiometrics;
                    print(canCheckBiometrics);
                  } catch (e) {
                    print(3);
                  }
                },
                child: Text('检测是否支持生物识别'),
              ),
              Divider(),
              RaisedButton(
                onPressed: () async {
                  try {
                    List<BiometricType> availableBiometrics =
                        await localAuth.getAvailableBiometrics();
                    print(availableBiometrics);
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('获取支持的生物识别列表'),
              ),
              Divider(),
              RaisedButton(
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
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text('指纹识别'),
              ),
            ],
          ),
        ));
  }
}
